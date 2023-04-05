// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Mon Feb 27 23:40:41 2023
// Host        : PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               Labor_SoC-Design/SoC_Project/SoC_Project.gen/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_sim_netlist.v
// Design      : blk_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "blk_mem_gen_0,blk_mem_gen_v8_4_5,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module blk_mem_gen_0
   (clka,
    wea,
    addra,
    dina,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [14:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [0:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [0:0]douta;

  wire [14:0]addra;
  wire clka;
  wire [0:0]dina;
  wire [0:0]douta;
  wire [0:0]wea;
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
  wire [0:0]NLW_U0_doutb_UNCONNECTED;
  wire [14:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [14:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "15" *) 
  (* C_ADDRB_WIDTH = "15" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.584575 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
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
  (* C_INIT_FILE = "blk_mem_gen_0.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "32768" *) 
  (* C_READ_DEPTH_B = "32768" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "1" *) 
  (* C_READ_WIDTH_B = "1" *) 
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
  (* C_WRITE_DEPTH_A = "32768" *) 
  (* C_WRITE_DEPTH_B = "32768" *) 
  (* C_WRITE_MODE_A = "READ_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "1" *) 
  (* C_WRITE_WIDTH_B = "1" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  blk_mem_gen_0_blk_mem_gen_v8_4_5 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(1'b0),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[14:0]),
        .regcea(1'b0),
        .regceb(1'b0),
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
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[14:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata(1'b0),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VHPlDkoDlWlBfBMvPBmGYmaek3s9hXXhjF28kllYPnaNm3TSnzzpXHWHc8Ye9/2L2yiQfJ1hTWou
Ia/zeQ8h9/dtr6QB5YkyW4wlb/LbMgXb+DGIXPSllNl0IMsRQIcQDbcQm1bO/nlhb+2pjxiuaQrl
DbvxoDwPs7z3LunRxsg=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lmIhoX8hXuc7tNV1sXY1K2/gXL7Y7Hq73qQF7+x03UWWTRd3uhGmVQtOMVbhIW+66UkWUHiD26zL
fzqGor8bgSNGpSFyS11k4TwLQT4OfAMGO8C9Qmmh4+VENBnpS9TW+wHzCv8oUwht7xYtYRZvOvYK
F3fMppz2sBkUd1lciw98ZE/UmNkhqBuMfIYF43j45DEJ55PBhOZNg91Ls4v3qBHyBAaYPFFoMry3
d5Fw1PZyFQSEOSSpwgyds2aN0g6oIwl7zm0LJrM9VDAOxBUE50hk+oHr4jj8J8UhHQJnlEHm1Idm
rvxKygNKRvfSpa90NYxZJFYgqnrMYg+19+9aZA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
VkyCjO2onoeZWEoYQ/4ue7X5mkHyTYVW9xjdoTsGS4GdP/Q64VaCZL/jr6R8DVDXPMnH7tRMrDpo
jpYBnyzSgOkfgqM+96ioC2fDyAaG4gYgGLmrBR6qK3/mxXwAZZX+GJ9R/eWXkc9h8xN+gsSSX6/M
jIQCgeT6q7PB4dWT6KY=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Iub91V+TnhVlZCSLu6iKmFjix71y6/l83OPTs8uewWvkE7WcqYxEKi9fonXEkzAtWzuKwEUqnOlN
VBsNJqPUdKcd22q523mrdt89mpdosWD+hvZdO7ELhJniY5u9h49FFkubpN2JiUTcIcKEYxVNlds4
wyvaYUqbPVH5v2ooJwDdimS4GVn9HerCOgPwfshvQDNlMTxLcYju4v8BHMc5Rub9Q/ihvpQU74v2
ouZ9XIwA+C6pBLwvaqS8jE7HXOokgqJilaX/W/t+KEgiFry/txRTMU9WMD7tCN7lcfjCydmS3Lq+
3u6Hsr0S8BwNjcaDpZDnBTygUJd4JSqREnk33w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
U46EWFmKmpZGaWfyL+dokyQtJtaOYsa7HCW/+fdtw9/yHKTWFpmqKBZngBj5rPkNhtTDDCJkqsYj
tUXg1j4tgIBaCQn9B0q/aG+B3gPLrudp9hLL25mVbsfiTzdekiV2hJMmhuMoavKKPJHC6zyW7kZi
80er82OQy8h+Df/fe6TRjH9xEt3/b80tRKUMbxkLfnnkAyyf1KfOhB6/uyI4mwXuQR+DsAbzybKR
YtXpOiW72tGrXTFlzcwbHamWZefqsilVpBw6V5dh33vYKGx50xwWpj76maAkpQrOpB7zufeldJe4
W1UOEN84AZdRTLkVSxamWo/wp8nP9fiGS/ItRw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qczgIJYpE/SzErzK7eWJBGcDFEzDLm8cKbwJbPXuM6YnJxx44W+E60R3war7K2QGFAkOoCDUtDC7
SghJGF32btaDLzeKm0tQ669sBtQmMIaBrlt7I9QBkNM8zN9GL92qxNC9o3UVWMOYy5BmH8nUPgcE
O6lRubeltlrTuDe7UJQ2nEPHcXjpUJJ8dxktyW+LovBy1OxW8g4GRAsmEJsoOEg0HuDdWcc4IshJ
PvwPJ7LblELAKsdkSt65y9VaklaEm7MlH4ImlgIa74TgRmutLUbWxM1QYhGE5rAzFhGU5i3RJOdx
L3N7GGGvLMW2z9NSHbIFX+/eNII9fNJ9nZbgLA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ti1NUgDv8YPk90APMwfu/mRr38QYwAxZfv0T6zQ89YS55t2EquEGVqrEafYX6rTydLOw8le1Oucv
f2oERpSSSTih/ScZneSZmuPE/Zh2BU1Ajv0j+/+0uEWXU+5lLPbDJjnapTmJXih1MYPf0SHpZZmE
BKj2IEBI9MPZlh6bxpa5BWJnyPdAvHf+UNaMXU9+pmbtrzUVebql4mFJu45Z3+ehmFY4FBW3zXMF
44C4TlHACLwL3vHVMCVfeKhgdVDbpE+/IFhTStz7mZ9h9RKGanQcs6YDVM1R+2RKA1QT1fX4FiQc
1V+FGmrm1ujxmFGXwpfNKByVlfCY0oWhRJCYYQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
HuEXFK0NXt09xU2yxxjng1OLsT+ZEM4EhqBgpr9D2ljw2vDaMBrqEsRQTc2B9soDq3ewDduHJXBd
OGYxkPnoN6LhjULtB2nTgjcH6NxA4puZ1ZNcndDndVBo8rTW5W1OqHq6InAG0CqPpTIkuqz3ECPl
EysI++MCDfH6tIzlekxJFIJ1McJsTq5rFuLzMMcrmkBxgcayDpOcCFuzZzCczxmt/cCCIKmDybwT
OQXmOcLJoYLP4sFu6R9c6xO8i6p++crv2N3eIxZHKbek9xBBZqQM9EYuEtsbkqAs9XZpa16i5njR
BDFxTKcP6r7JgFALJE89AZhBbate5JXWp0v4ECZD18aEL17CipwcWPutNMdG1apzSPP5y59n7rMG
yxBPz1gKHc3Emkl4WcO0hjICxqmO6dMXoY8JvBSf6ry2l0sH9Ihr3Bq5WWmlhPHnoaNr5jl//vNe
KfToWtn97eoVSt1LnmXXnSpdigbHr0UIg8AdkpdkuNRaWdVicDdgSo49

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
mokwst2bn6UxD6V9UdIgCIG1QQ/d0FiJqYGOTI2eHPV6YElaLjnJ8DnQmZnGS95o3x93FDOoa58C
RwYsX1fVoVtXkj1LuZq0k7q9vEe4T8xMjpkeYtIHY9k0Xhy1Lq/xRlfzGAf9fvf9e+f4r7aR/Sb/
uCZxxugG5niTwLENY1n3NthYL0jvo8Fmdw4Qg0nTCGWlVCws+09K0g9/lx6I9EcuHHemcHO3fOZG
lMc4NaPNozKwnyDMoWUkwiVxyFEPFaQLNYqzjvR+CqrWfhFLo96JWhL+eaDoNuZoBVYQtNH5ZwBL
BoO27Pw10lgcReGlZBz3BLO7T4ddynCx0+eSnw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PiP7AjOQqqouyQMoBQqgWIDhUSViq94rIvGiIJ/UKMDspM/yXw1caE8AhWHTjYckC4yLpPAz5P6s
1Z6flzDPrzVwg4e59X2cc4IMCHhedna0rDO804njcc6amRDTeLsMLTkWfvomB4xwszm2AgT+PRnB
WHd09ZUDVFjiBXT+Oa9AicgGJHrX3w823yBPuAa704kje/SzgtiDpcTU1eLmLhLW7LpEd9KIHd9s
ER7Uk9Orws0Kq9PMTqMX4hMn5K5mFakOeOURiEbUjdv5RiIJ2g/PlQXSItM8fHsBTQa6fOaJwQTI
vHwK3a8ZBHpfT1YH+n7wNiNUZwD4SFXm1QVx4g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ul5ZfTHJwMctaNhYRortUZizYMPYRef7uYqPSuMkxsArnxI/cjGh+KRMwzV86hyp/6TXSJIjm5ec
2wX2UONdPN+DOJ84jYC4JbgJQrPnTj7ioD8uLX/WlyPcQzyF5keqFgj5eR5s13FskVWCuAWf5m9w
mhFEKFjVXDAr7gVgAJh/hL8P6Psrnf+LGfiM8JhnDepsHEYykGlpD3fzru2BGgqHWqPqFMcnyVGl
vysaIXiJz/eYKvO8RGcgd3DJAM/wPm9A0m/DWcmSnczOgTjoqkHcBg2H5uJMLvufzmjImi6LYEqq
v04ESDEN31cSUzqUYcayvMFOnI/WNsWbFIa5+Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 25808)
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
