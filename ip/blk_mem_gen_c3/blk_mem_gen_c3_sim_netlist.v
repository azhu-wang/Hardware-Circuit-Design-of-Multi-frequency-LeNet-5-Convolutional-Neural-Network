// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Sep 12 18:52:26 2026
// Host        : m11307409 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim z:/ip/blk_mem_gen_c3/blk_mem_gen_c3_sim_netlist.v
// Design      : blk_mem_gen_c3
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_c3,blk_mem_gen_v8_4_11,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_11,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module blk_mem_gen_c3
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [4:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;

  wire [4:0]addra;
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
  wire [4:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [4:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "5" *) 
  (* C_ADDRB_WIDTH = "5" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_c3.mem" *) 
  (* C_INIT_FILE_NAME = "blk_mem_gen_c3.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "26" *) 
  (* C_READ_DEPTH_B = "26" *) 
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
  (* C_WRITE_DEPTH_A = "26" *) 
  (* C_WRITE_DEPTH_B = "26" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_c3blk_mem_gen_v8_4_11 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0}),
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
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[4:0]),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[4:0]),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 19984)
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
