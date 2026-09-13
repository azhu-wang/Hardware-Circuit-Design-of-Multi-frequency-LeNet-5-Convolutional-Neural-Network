param(
    [ValidateSet('syntax', 'unit', 'constraints', 'regen-ip', 'ip', 'rtl-ip', 'top-sim', 'synth', 'timing')]
    [string]$Task = 'unit',
    [string]$Part = 'xc7z020clg400-1',
    [double]$ClockPeriodNs = 10.0
)

$ErrorActionPreference = 'Stop'
$RootDir = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$env:LENET_ROOT = $RootDir.Replace('\', '/')
$env:LENET_PART = $Part
$env:LENET_CLOCK_PERIOD_NS = $ClockPeriodNs.ToString([Globalization.CultureInfo]::InvariantCulture)
$VivadoRoot = 'C:\Xilinx\2025.1\Vivado'
$VivadoBin = Join-Path $VivadoRoot 'bin'

if (-not (Test-Path -LiteralPath $VivadoBin)) {
    throw "Vivado 2025.1 was not found at $VivadoRoot"
}

# This installation has a damaged per-user Tcl Store catalog. Supplying every
# installed package directory keeps batch mode reproducible without changing the
# user's global Vivado configuration.
$PackageDirs = Get-ChildItem -LiteralPath (Join-Path $VivadoRoot 'data\XilinxTclStore') `
    -Recurse -Filter pkgIndex.tcl | ForEach-Object { $_.DirectoryName.Replace('\', '/') }
$env:TCLLIBPATH = $PackageDirs -join ' '

$BuildDir = Join-Path $RootDir 'build'
New-Item -ItemType Directory -Force -Path $BuildDir | Out-Null

$CommonSources = @(
    'top.v', 'layer_1.v', 'layer_2.v', 'layer_3.v',
    'input_buffer_1.v', 'input_buffer_2.v', 'Pooling_buffer_1.v', 'Pooling_buffer_2.v',
    'conv33.v', 'conv11.v', 'OutputAccumulator.v', 'relu.v', 'maxpooling.v',
    'fully_connected.v', 'div2.v', 'div4.v'
) | ForEach-Object { Join-Path $RootDir $_ }

Push-Location $BuildDir
try {
    if ($Task -eq 'syntax') {
        & (Join-Path $VivadoBin 'xvlog.bat') --sv @CommonSources
    }
    elseif ($Task -eq 'unit') {
        & (Join-Path $VivadoBin 'xvlog.bat') --sv `
            (Join-Path $RootDir 'conv33.v') `
            (Join-Path $RootDir 'conv11.v') `
            (Join-Path $RootDir 'OutputAccumulator.v') `
            (Join-Path $RootDir 'relu.v') `
            (Join-Path $RootDir 'fully_connected.v') `
            (Join-Path $RootDir 'div2.v') `
            (Join-Path $RootDir 'div4.v') `
            (Join-Path $RootDir 'verification\tb_arithmetic.sv')
        if ($LASTEXITCODE -ne 0) { throw 'xvlog failed' }
        & (Join-Path $VivadoBin 'xelab.bat') tb_arithmetic -s tb_arithmetic_sim `
            -timescale 1ns/1ps
        if ($LASTEXITCODE -ne 0) { throw 'xelab failed' }
        $SimulationOutput = & (Join-Path $VivadoBin 'xsim.bat') tb_arithmetic_sim -runall 2>&1
        $SimulationOutput | ForEach-Object { Write-Output $_ }
        if ($SimulationOutput -match 'FAIL:') { throw 'Self-checking simulation reported a failure' }
    }
    elseif ($Task -in @('constraints', 'regen-ip', 'ip', 'rtl-ip', 'top-sim')) {
        $IpDrive = @('Z:', 'Y:', 'X:', 'W:') | Where-Object {
            -not (Test-Path -LiteralPath "$_\")
        } | Select-Object -First 1
        if (-not $IpDrive) { throw 'No free temporary drive letter is available for Vivado IP generation' }
        & subst.exe $IpDrive $RootDir
        if ($LASTEXITCODE -ne 0) { throw 'Could not create a short Vivado IP path' }
        $IpVivadoExitCode = 1
        $IpScript = if ($Task -eq 'regen-ip') {
            'regenerate_ip.tcl'
        }
        elseif ($Task -eq 'constraints') {
            'check_constraints.tcl'
        }
        elseif ($Task -eq 'rtl-ip') {
            'check_top_ip.tcl'
        }
        else {
            'check_ip.tcl'
        }
        try {
            Push-Location "$IpDrive\build"
            & (Join-Path $VivadoBin 'vivado.bat') -mode batch `
                -source "$IpDrive\scripts\$IpScript" `
                -log "$IpDrive\build\vivado-ip.log" `
                -journal "$IpDrive\build\vivado-ip.jou"
            $IpVivadoExitCode = $LASTEXITCODE
        }
        finally {
            Pop-Location
            & subst.exe $IpDrive /D
        }
        if ($IpVivadoExitCode -ne 0) { throw "Vivado task '$Task' failed" }

        if ($Task -eq 'top-sim') {
            Get-ChildItem -LiteralPath (Join-Path $RootDir 'ip') -Recurse -Filter '*.mif' |
                Copy-Item -Destination $BuildDir -Force
            $IpSimulationModels = Get-ChildItem -LiteralPath (Join-Path $RootDir 'ip') `
                -Recurse -Filter '*.v' | Where-Object { $_.Directory.Name -eq 'sim' } |
                ForEach-Object { $_.FullName }

            & (Join-Path $VivadoBin 'xvlog.bat') --sv @CommonSources `
                @IpSimulationModels (Join-Path $RootDir 'verification\tb_top_smoke.sv')
            if ($LASTEXITCODE -ne 0) { throw 'Top-level xvlog failed' }
            & (Join-Path $VivadoBin 'xelab.bat') tb_top_smoke -s tb_top_smoke_sim `
                -L blk_mem_gen_v8_4_11 -timescale 1ns/1ps
            if ($LASTEXITCODE -ne 0) { throw 'Top-level xelab failed' }
            $SimulationOutput = & (Join-Path $VivadoBin 'xsim.bat') tb_top_smoke_sim -runall 2>&1
            $SimulationOutput | ForEach-Object { Write-Output $_ }
            if ($LASTEXITCODE -ne 0 -or $SimulationOutput -match 'FAIL:') {
                throw 'Self-checking top-level simulation reported a failure'
            }
        }
    }
    elseif ($Task -eq 'timing') {
        & (Join-Path $VivadoBin 'vivado.bat') -mode batch `
            -source (Join-Path $RootDir 'scripts\report_constrained_timing.tcl') `
            -log (Join-Path $BuildDir 'vivado-timing.log') `
            -journal (Join-Path $BuildDir 'vivado-timing.jou') `
            -tclargs $env:LENET_ROOT
    }
    else {
        & (Join-Path $VivadoBin 'vivado.bat') -mode batch `
            -source (Join-Path $RootDir 'scripts\synth.tcl') `
            -log (Join-Path $BuildDir 'vivado.log') `
            -journal (Join-Path $BuildDir 'vivado.jou') `
            -tclargs $env:LENET_ROOT
    }
    if ($LASTEXITCODE -ne 0) { throw "Vivado task '$Task' failed" }
}
finally {
    Pop-Location
}
