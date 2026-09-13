// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Sep 12 18:53:06 2026
// Host        : m11307409 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim z:/ip/blk_mem_gen_fc/blk_mem_gen_fc_sim_netlist.v
// Design      : blk_mem_gen_fc
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_fc,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_fc
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [9:0]addra;
  wire clka;
  wire [7:0]douta;
  wire ena;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_doutb_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     1.1884 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "blk_mem_gen_fc.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_fc.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "730" *) 
  (* C_READ_DEPTH_B = "730" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "730" *) 
  (* C_WRITE_DEPTH_B = "730" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_fcblk_mem_gen_v8_4_11 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[7:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2025.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
gydSV72FvW4hnoyUt6yZFJHfJqjRQWPUfYIuDKP0fpjrPOkLRbJGBr4Z9msYTvoIHRlYtXJ2YMY0
d1TIQb+FK4gKsTRru9wr397OxuFBsTRf4e+ZjpYZEdsnqYWcgMSzhN4yhPvO06GyZO15y/LKBxa8
3OKwxVlOLYXhv+sxdXg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
WHB6Zbfa5Qi47krP9T4L8UnPOlr881dWx7UcYaZfNGIQQM0gadcoXbhucIpRaUuyOKxv6yhKveRN
h0l+N9+KX6rbZ6+TRhP9JAMuPhlpI7T42QtRv5zx9+m3ct5S0NMszbFaK8zeTAYra5BGP7BHmtkr
MpKfLK5sFyaTE/A7ACtAace9MwFTHDZdl9uUs4aY6KJlm6GaypKduiqkNugukJp5vlFPX/ZapJqG
KMtMhI6grhcuYb1FJrwRZ4jW7hs9HxddSdGLzsZ0HsBcO/qaCPTst+ZA0YIQfd5ULlFmPqq39FfO
p1P+2hEH2n+LycbMj5cn4Dxfqv2R8eucM78R3w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
SmAzQA1VEuJXtJi5vXa2Jg7YvRqAJs6PX9HTZ1YqrJw4VfonBW3726gJ81BjlizpMkcf/Uk5sFIK
aPedVhEs4xCIZylz7gXYDshtytOA/pXUID2qV9nXr8qfI+FydSADUF3ScYDZmlkclFqlZrGq6DQ7
da3lJAzt2h/iR+cczrA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
iAph5JWb/chMQpLPX1UoLjQDxN5l2I8McM/k2xN5wRht7HXoE6F5yV8luDjn3zkI6vnfUYo7BaI1
mogRRx+R3XcwxvhHr+lngh4+/YLVex1TFncl+kiUMAsu3M/FjFSiqGMVMdKTNLDqr35DuZJVyuiF
lTwXob/KkbQDJiJjBEoxbt+968rKRKRyJGcqIjm4mqRBdqMcgo3HOJFG74SFsWAQrxvXfBhdLSG3
OfoLfls9XDojBjp7G83k0h82g1eeWgBfydm/OcX9o48Pst93NvI4ua8WShZL8MCvRWYqWZrrjrWi
cfUjXAF5SDACjq1/OU6arz/Idz6/a7AP/jmexw==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BY49GZBxBT/gjZDPyaSWlti/sctckoR7jK6NuWdhnF9tiyNfVU7BqjjwxSnyMi0Uucv1BKHXC18h
8hQbFWnNtrq71ilURotXux7sssHlVJ2i1CsJWU18DOcBWxm2ai89uwvxDJh3TJkBJixB5KPvsDhL
lWOjTvZWPoR+Ixy+Tzo+U5Vx7z7SOakRwTrn3u7+c3vmCEBphE+HKeJExhBAoOEd0SXK5iwXaByW
D7Wb7zq6NNUmnCyaJ2BG9kGxLVsf+md7SlocuaFsYyaRZhwPyTucxIlz1tLYwcytKzx0ovoax3no
nYgzlzP/F0/PDWk9BqXgr/tuclc4EZYX0cf4ng==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2025.1-2029.x", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qGnCvL35qO7cbUEKCL50yDv1UvezcqBz601zctKop1954QlcjemzZWZHg1zJ00nJaToNdH2S8AKX
n8hNJvbQ+x5HEGL5DoSU9m5qjXd8xxocnZ0yzuZX/dGCT8kDn3gWJR2Gz13pT+w2LQUno1fX+MsC
ehgwvjBBT6GeYjdxHi+aybQUP9AblSxX/z3vh857SGCPohEWvghOgORCHAe45YD+ZWnL62FLxMM2
c+Ozq/Au/Q4q1Yzlzcfv8Mnsvg7OqOeEamQHbuYOfdkJUuYqOwsskEWW348u7FXtsf8m7P3pZyyz
IWyTDAW4igGguMPLHfbtK/twZx8ScJQmOKzglg==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hz+6K8+wh5/fukU4ZWNDXGsq6hreSVCSPP67nA6kUz9Vpjy4TtTnOrrl1BWY0ivEC7Ldyw8VI60A
VO/WPlt409LdAZdMZGsEZ1JuTZ0m9LPcgu9CPCyoMECctmd8LHE+otY6etTmYABB9syY61rk2hrv
RgbcyT/HCK9TzWxSm+XMqvx2nvagCLkMDPh/JZv51fj2zcKaBPnxsz8rnDipaeo0fEyVRC3Y1F/V
U3RmXojBjIumPHSJkQ537dENJEIA0Ra65u8EM/+ItUn1bcryLcIbKy1xGadrHmHdHRUoRcAodO2C
B48bNVeL0VnGg8P9ACIB04lMNzn5p6A1tPOb4Q==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
YDpb+UeT0rJ543Q8wCo2xSS3gpVAT+JoStgBlV5IMjJoUOWkiOPn691FGChmDi3BTq5NxC73KHHR
1galACCjeTGq6cv+0Zc2Ocm1oobdrnSPHp7TMDr5Zle8FX6WywJCiGdoWBODggZSlbOASIK/PVfY
cZM2z60M6RSvzsi3TnYHiKYHpju8THVoSgRd6r31GcbiSy9TjjARERXan0OVc79jGuAg90mmDEEq
91eqmn6NZ9yLI2fgBjFUZbtFCpmJ8WGxOL1h39niWnRK3ZXnk8jcpnZUlxLbYTPO0Z3vVr1zrvcn
RVQloU0OLqg7M95zSs7NtX5Vzvb6jGbMehWV+WMMyxWmxL2XOwsAwPSeX2dI2r77pioY7X6VzH7f
/JxMAnq9udra3WGPsUkD1G0CvPkCC3zdxjpVaflY37ztX9UONhKtzMQa8lJc1IL8GhXRY3R9Lg2c
HIeXSGkpNNuFDqKT6Khe/6Casq+SjFJq+IH9IUtz6RUZTkbFb0Xhgm2P

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q+63zFEYw/LeMgxa7g8g79GGvSyIKDKD8RvvC4DHDQuGObf6n9OGZX4e17v/E/+EDEwUhsWQHFDI
Lp/aH+6fNRmhu9BEWVjxq2WRrQSl4eQjfIaSOXu2dlYh3JjRJwiUp4LteVh8RFAf5t5sRQO4dRIK
x+h28yliSgibaWEAv5FaJQ1EFbNwmgedAaSYjgf2A3afBUcBh5Uy9VHbW/zRzdhhJdsVNBjZYcFy
CVLOcf1toCRp8J4U5FlnFMOzFegUbdXFQhq2VmIhPRxWjrfTk6iR4BcMEN9UMij/5IHRAeBdksyD
CqEKsyFxosbI5KVMRZ1Ln75Zipn0JdsGekHkxg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DPUa5DLPYRWvbPnX0U412yoWvvvHyuq43DrYmDJGTK0cR5U4U6th8icYgizC1/hUAEzt19kM/hVa
zZh7bXSWACYLpcfhPY8dRTVGDZVjpbkraw0ceBryLP7jc6Jt5JdNw88tZtZpprCB7nQ25lUL82Hf
WTwL1ZqgGIvtfHhxO0JF5L5ES5giedwQ6u5ffXG3UB6ELcpQD1NvpW5lAz4mfXyvVDCAPZN581TF
tlAy79iKbPKlJ2zFn1BS2cuRIHHe2JRxwPo+0n5VD5CXVgg+lCYxTnCxI8CdyFaTumbs4IfAKwVI
wSN/btbwDUhW9hAHWHIRo+BpdJ4qeGcTDPKtsA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mf5hcf6JE6yLm0jNCQnHMVmogjLlPz6re0FwG67yvOJ3FuEorru0emIeAKEwgOoxjUYNWvcM7QAH
/UEeB2EIdjLl6glPAUda0HjtaCU2rdncVdM8k6DSMBggc4yo18Qx5F+1TD/RoBgoo0jNkMdDy6wJ
JHjqlN+R01z3yYIMQ9f2z6ZaYncbBYEp4+YAb7g1D7CSMxP5cFRpQznRpYp0JwqJfT9CHzlKgdab
8B288NxeLM66iYodiTS+GSRGLGtDWXpz9yeiuiPe6kJxae2GJyHIMSfluO/0Slc3m24DQNdbojf8
jdc0G2UnrDe5mCUTfYiDmpOWTUJOdYo0FK0N2g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 18672)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
