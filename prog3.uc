#Assign3                          By: Bryan Butz
#CSCI 463                         Due: 11/12/19

#Purpose: This microcode opens a memory file and runs through
#the ucsimulator using the memory file as instructions. The microcode 
#represents the functions/operations of a CPU.

\# All fields are in hex format
# 
# address
# uc_addr_mux[2]    next insn addr = uc_next_addr, flags, IR opcode
# uc_alu_func[2]    0 = add, 1 = xor, 2 = and, 3 = or
# uc_alu_comp_b     1 = compliment b
# uc_alu_ci         1 = carry in
# uc_alu_flags_clk  1 = clock the flag latch
# uc_mar_we         1 = clock a write into MAR
# uc_mem_we         1 = clock a write into the RAM
# uc_mbr_out_we     1 = clock a write into the MBR_out latch
# uc_mbr_in_we      1 = clock a write into the MBR_in latch
# uc_reg_we_clk     1 = clock a write intot he register file
# uc_reg_addr_ir    0 = use reg addr from uc, 1 = use the a field address from IR 
# uc_reg_addr[3]    the uc destination register address if writing 
# uc_alu_reg_a_ir   0 = set alu_reg_a mux using the uc address, 1 = use the a field from the IR
# uc_alu_reg_a[3]   uc address for alu_reg_a
# uc_alu_reg_b_ir   0 = set alu_reg_b mux using the uc address, 1 = use the b field from the IR
# uc_alu_reg_b[3]   uc address for alu_reg_b
# uc_next_addr[16]  uc next instruction

# read a byte from memory and put it into the IR

0000 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # do nothing

#############################
# fetch an insn from PC address 
0001 0  0 0 0  0 1 0 0 0  0 0 5  0 4 0 7 0002   # put the PC reg value into the MAR
0002 0  0 0 0  0 0 0 0 1  0 0 5  0 4 0 7 0003   # falling edge on uc_mar_we, rising edge on uc_mbr_in_we
0003 0  0 0 0  0 0 0 0 0  0 0 5  0 4 0 7 0004   # falling edge on uc_mbr_in_we
0004 0  0 0 0  0 0 0 0 0  1 0 5  0 7 0 4 0005   # rising edge on uc_reg_we_clk w/ir as target
0005 0  0 0 0  0 0 0 0 0  0 0 5  0 7 0 4 0006   # falling edge on uc_reg_we_clk

# add 1 to PC
0006 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 0007   # add 1 to PC & rising edge on uc_reg_we_clk
0007 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 0010   # falling edge on uc_reg_we_clk

#############################
# instruction decode logic
0010 2  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 00f0   # branch based on the opcode in the IR!

00f0 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1000   # opcode 0 NOP
00f1 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1100   # opcode 1 LDI Ra,imm
00f2 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1200   # opcode 2 ST Ra,imm
00f3 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1300   # opcode 3 ADD Ra,Rb
00f4 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1400   # opcode 4 SUB Ra,Rb
00f5 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1500   # opcode 5 XOR Ra,Rb
00f6 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1600   # opcode 6 AND Ra,Rb
00f7 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1700   # opcode 7 OR Ra,Rb
00f8 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1800   # opcode 8 MOV Ra,Rb
00f9 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1900   # opcode 9 LD Ra,mem(imm)
00fa 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1a00   # opcode a B imm (absolute)
00fb 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1b00   # opcode b BR PC+imm
00fc 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1c00   # opcode c BNZ PC+imm
00fd 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1d00   # opcode d BZ PC+imm
00fe 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 ffff   # opcode e
00ff 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 ffff   # opcode f HALT

#############################
# NOP no operation
1000 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # go to insn fetch

#############################
# LDI Ra,imm
# fetch the byte in memory that the PC is pointing to now
1100 0  0 0 0  0 1 0 0 0  0 0 7  0 4 0 7 1101   # MAR <- PC
1101 0  0 0 0  0 0 0 0 0  0 0 7  0 4 0 7 1102   #
1102 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 1103   # MBR_IN <- mem_in
1103 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 1104   #
1104 0  0 0 0  0 0 0 0 0  1 1 7  0 7 0 4 1105   # Ra <- MBR_IN
1105 0  0 0 0  0 0 0 0 0  0 1 7  0 7 0 4 1106   #
1106 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 1107   # PC <- PC+1
1107 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 1108   # 

1108 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # go to insn fetch


##############################
# B imm
1a00 0  0 0 0  0 1 0 0 0  0 0 7  0 4 0 7 1a01   # MAR <- PC
1a01 0  0 0 0  0 0 0 0 0  0 0 7  0 4 0 7 1a02   #
1a02 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 1a03   # MBR_IN <- mem_in
1a03 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 1a04   #
1a04 0  0 0 0  0 0 0 0 0  1 0 4  0 7 0 4 1a05   # PC <- MBR_IN
1a05 0  0 0 0  0 0 0 0 0  0 0 4  0 7 0 4 1a06   #

1a06 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # go to insn fetch

##############################
# ADD Ra,Rb

1300 0  0 0 0  1 0 0 0 0  1 1 0  0 0 1 1  1301 # Ra <- Ra + Rb & FLAGS <-ALU st$
1301 0  0 0 0  0 0 0 0 0  0 1 0  0 0 1 1  1302 # 

1302 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7  0001 # go to insn fetch

##############################
# ST Ra,imm

1200 0  0 0 0  0 1 0 0 0  0 0 7  0 4 0 7 1201   # MAR <- PC *
1201 0  0 0 0  0 0 0 0 0  0 0 7  0 4 0 7 1202   #
1202 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 1203   # MBR_IN <- mem_in *
1203 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 1204   #
1204 0  0 0 0  0 1 0 0 0  0 0 7  0 7 0 4 1205   # MAR <- MBR_IN
1205 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 4 1206   #
1206 0  0 0 0  0 0 0 1 0  0 0 7  1 0 0 7 1207   # MBR_OUT <- Ra
1207 0  0 0 0  0 0 0 0 0  0 0 7  1 0 0 7 1208   # 
1208 0  0 0 0  0 1 1 0 0  0 0 7  0 7 0 7 1209   # mem(MAR) <- MBR_OUT
1209 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 1210   #
1210 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 1211   # PC <- PC+1
1211 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 1212   #


1212 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7  0001 # go to insn fetch

##############################
# SUB Ra,Rb

1400 0  0 1 1  1 0 0 0 0  1 1 0  1 0 1 1  1401 # Ra <- Ra + Rb & FLAGS <-ALU st$
1401 0  0 1 1  0 0 0 0 0  0 1 0  1 0 1 1  1402 #

1402 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7  0001 # go to insn fetch

############################
# XOR Ra,Rb
1500 0  1 0 0  1 0 0 0 0  1 1 0  1 7 1 7  1501 # Ra <- Ra XOR Rb & FLAGS <-ALU status
1501 0  1 0 0  0 0 0 0 0  0 1 0  1 7 1 7  1502 # falling edge

1502 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7  0001 # go to insn fetch

##############################
# OR Ra,Rb

1700 0  1 0 0  1 0 0 0 0  1 1 0  1 7 1 7  1701 # Ra <- Ra OR Rb & FLAGS <-ALU st$
1701 0  1 0 0  0 0 0 0 0  0 1 0  1 7 1 7  1702 #

1702 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7  0001 # go to insn fetch

##############################
# AND Ra,Rb

1600 0  2 0 0  1 0 0 0 0  1 1 0  1 7 1 7  1601 # Ra <- Ra AND Rb & FLAGS <-ALU st$
1601 0  2 0 0  0 0 0 0 0  0 1 0  1 7 1 7  1602 #

1602 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7  0001 # go to insn fetch

##############################
# MOV Ra,Rb

1800 0  0 0 0  0 0 0 0 0  1 1 0  1 0 1 1  1801 # Ra <- Ra AND Rb & FLAGS <-ALU st$
1801 0  0 0 0  0 0 0 0 0  0 1 0  1 0 1 1  1802 #

1802 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7  0001 # go to insn fetch

#############################
# LD Ra,mem(imm)

1900 0  0 0 0  0 1 0 0 0  0 0 7  0 4 0 7 1901   # MAR <- PC
1901 0  0 0 0  0 0 0 0 0  0 0 7  0 4 0 7 1902   #
1902 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 1903   # MBR_IN <- mem_in
1903 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 1904   #
1904 0  0 0 0  0 1 0 0 0  0 0 7  0 7 0 4 1905   # MAR <- MBR_IN
1905 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 4 1906   #
1906 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 1907   # MBR_IN <- mem_in
1907 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 1908   #
1908 0  0 0 0  0 0 0 0 0  1 1 0  1 7 0 4 1909   # Ra <- MBR_IN
1909 0  0 0 0  0 0 0 0 0  0 0 0  1 7 0 4 1910   #
1910 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 1911   # PC <- PC+1
1911 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 1912   #

1912 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # go to insn fetch


#############################
# BR imm
1b00 0  0 0 0  0 1 0 0 0  0 0 7  0 4 0 7 1b01   # MAR <- PC
1b01 0  0 0 0  0 0 0 0 0  0 0 7  0 4 0 7 1b02   #
1b02 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 1b03   # MBR_IN <- mem_in
1b03 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 1b04   #
1b04 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 1b05   # PC <- PC + 1
1b05 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 1b06   #
1b06 0  0 0 0  0 0 0 1 0  1 0 4  0 4 0 4 1b07   # PC <- PC + MBR_IN
1b07 0  0 0 0  0 0 0 0 0  0 0 4  0 4 0 4 1b08   #

1b08 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # go to insn fetch


#############################
# BNZ PC+imm
1d00 1  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d1f   # branch based on the flags reg

# Branch table for BNZ
0d10 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #----
0d11 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #---N
0d12 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #--Z-
0d13 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #--ZN
0d14 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #-U--
0d15 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #-U-N
0d16 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #-UZ-
0d17 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #-UZN
0d18 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #S---
0d19 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #S--N
0d1a 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #S-Z-
0d1b 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #S-ZN
0d1c 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #SU--
0d1d 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d00   #SU-N
0d1e 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #SUZ-
0d1f 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0d02   #SUZN


# IF( !Z )
0d00 0  0 0 0  0 1 0 0 0  0 0 7  0 4 0 7 0d0a   # MAR <- PC
0d0a 0  0 0 0  0 0 0 0 0  0 0 7  0 4 0 7 0d03   #
0d03 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 0d04   # PC <- PC + 1
0d04 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 0d05   #
0d05 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 0d06   # MBR_IN <- mem_in
0d06 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 0d07   #
0d07 0  0 0 0  0 0 0 1 0  1 0 4  0 4 0 4 0d08   # PC <- PC + MBR_IN
0d08 0  0 0 0  0 0 0 0 0  0 0 4  0 4 0 4 0d09   #

# ELSE
0d02 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 0e10   # PC <- PC + 1
0e10 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 0d09   #

0d09 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # go to insn fetch


#############################
# BZ PC+imm
1c00 1  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 1c1f   # branch based on the flags reg

# Branch table for BZ
1c10 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #----
1c11 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #---N
1c12 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #--Z-
1c13 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #--ZN
1c14 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #-U--
1c15 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #-U-N
1c16 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #-UZ-
1c17 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #-UZN
1c18 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #S---
1c19 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #S--N
1c1a 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #S-Z-
1c1b 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #S-ZN
1c1c 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #SU--
1c1d 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c00   #SU-N
1c1e 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #SUZ-
1c1f 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 2c02   #SUZN



# IF( Z )
2c02 0  0 0 0  0 1 0 0 0  0 0 7  0 4 0 7 2c0a   # MAR <- PC
2c0a 0  0 0 0  0 0 0 0 0  0 0 7  0 4 0 7 2c03   #
2c03 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 2c04   # PC <- PC + 1
2c04 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 2c05   #
2c05 0  0 0 0  0 0 0 0 1  0 0 7  0 7 0 7 2c06   # MBR_IN <- mem_in
2c06 0  0 0 0  0 0 0 0 0  0 0 7  0 7 0 7 2c07   #
2c07 0  0 0 0  0 0 0 1 0  1 0 4  0 4 0 4 2c08   # PC <- PC + MBR_IN
2c08 0  0 0 0  0 0 0 0 0  0 0 4  0 4 0 4 2c09   #

# ELSE
2c00 0  0 0 1  0 0 0 0 0  1 0 4  0 4 0 7 2e10   # PC <- PC + 1
2e10 0  0 0 1  0 0 0 0 0  0 0 4  0 4 0 7 2c09   #

2c09 0  0 0 0  0 0 0 0 0  0 0 0  0 7 0 7 0001   # go to insn fetch



