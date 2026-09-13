// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Sep 12 18:53:44 2026
// Host        : m11307409 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim z:/ip/blk_mem_gen_picture/blk_mem_gen_picture_sim_netlist.v
// Design      : blk_mem_gen_picture
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_picture,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_picture
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [13:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [13:0]addra;
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
  wire [13:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [13:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "14" *) 
  (* C_ADDRB_WIDTH = "14" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.227034 mW" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_picture.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_picture.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "9000" *) 
  (* C_READ_DEPTH_B = "9000" *) 
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
  (* C_WRITE_DEPTH_A = "9000" *) 
  (* C_WRITE_DEPTH_B = "9000" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_pictureblk_mem_gen_v8_4_11 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[13:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[13:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 59328)
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
