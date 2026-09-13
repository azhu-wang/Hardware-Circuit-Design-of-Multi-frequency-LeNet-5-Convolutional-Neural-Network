// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Sep 12 18:51:52 2026
// Host        : m11307409 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim z:/ip/blk_mem_gen_c2/blk_mem_gen_c2_sim_netlist.v
// Design      : blk_mem_gen_c2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_c2,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_c2
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
  (* C_INIT_FILE = "blk_mem_gen_c2.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_c2.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "660" *) 
  (* C_READ_DEPTH_B = "660" *) 
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
  (* C_WRITE_DEPTH_A = "660" *) 
  (* C_WRITE_DEPTH_B = "660" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_c2blk_mem_gen_v8_4_11 U0
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
