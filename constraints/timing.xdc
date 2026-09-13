# scripts/run_vivado.ps1 always supplies LENET_CLOCK_PERIOD_NS.
# Add board-specific pin locations and I/O standards before implementation.
create_clock -name sys_clk -period $::env(LENET_CLOCK_PERIOD_NS) [get_ports clk]

# All three stages now use sys_clk. div2/div4 generate clock-enable pulses only,
# so there are no internally generated fabric clocks or inter-stage CDC paths.
