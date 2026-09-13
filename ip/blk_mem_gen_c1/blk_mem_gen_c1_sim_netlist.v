// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Sep 12 18:51:17 2026
// Host        : m11307409 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim z:/ip/blk_mem_gen_c1/blk_mem_gen_c1_sim_netlist.v
// Design      : blk_mem_gen_c1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_c1,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_c1
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [5:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [5:0]addra;
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
  wire [5:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [5:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "6" *) 
  (* C_ADDRB_WIDTH = "6" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.3768 mW" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_c1.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_c1.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "60" *) 
  (* C_READ_DEPTH_B = "60" *) 
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
  (* C_WRITE_DEPTH_A = "60" *) 
  (* C_WRITE_DEPTH_B = "60" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_c1blk_mem_gen_v8_4_11 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[5:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[5:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 20048)
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
