#Assign2                   By: Bryan Butz
#CSCI 463                  Due: 10/15/19

#Purpose: This microcode program adds up a register to
#hex value 41 through 48 (ASCII A,B,C,D,E,F,G,H) and saves
#them into memory address 0080 through 0087

00  0  0  0  0  0  0  0  0  00  00  00  #reset

00  0  1  0  0  0  0  0  0  10  10  10
00  0  1  1  0  0  0  0  0  10  10  10
00  0  1  0  0  0  0  0  0  10  10  10  #put 1 in reg 2 for incrementing


00  0  1  0  0  0  0  0  0  01  01  01
00  0  1  1  0  0  0  0  0  01  01  01
00  0  1  0  0  0  0  0  0  01  01  01  #add reg1 to reg1 with carry

00  0  1  0  0  0  0  0  0  01  01  01
00  0  1  1  0  0  0  0  0  01  01  01
00  0  1  0  0  0  0  0  0  01  01  01  #add reg1 to reg1 with carry

00  0  1  0  0  0  0  0  0  01  01  01
00  0  1  1  0  0  0  0  0  01  01  01
00  0  1  0  0  0  0  0  0  01  01  01  #add reg1 to reg1 with carry

00  0  1  0  0  0  0  0  0  01  01  01
00  0  1  1  0  0  0  0  0  01  01  01
00  0  1  0  0  0  0  0  0  01  01  01  #add reg1 to reg1 with carry

00  0  1  0  0  0  0  0  0  01  01  01
00  0  1  1  0  0  0  0  0  01  01  01
00  0  1  0  0  0  0  0  0  01  01  01  #add reg1 to reg1 with carry

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  0  0  0  0  11  01  01
00  0  0  1  0  0  0  0  0  11  01  01
00  0  0  0  0  0  0  0  0  11  01  01  #save value of r1 + r1 into reg3 
00  0  0  0  0  0  0  0  0  11  11  11
00  0  0  1  0  0  0  0  0  11  11  11
00  0  0  0  0  0  0  0  0  11  11  11  #save value of r3 + r3 into reg3 (80)


00  0  1  0  0  0  0  0  0  01  01  01
00  0  1  1  0  0  0  0  0  01  01  01
00  0  1  0  0  0  0  0  0  01  01  01  #add reg1 to reg1 once more for 41


00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory



#save 42 in 0081

00  0  0  0  0  0  0  0  0  11  11  10
00  0  0  1  0  0  0  0  0  11  11  10
00  0  0  0  0  0  0  0  0  11  11  10  #save value of 81 in reg3

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory


#save 43 in 0082

00  0  0  0  0  0  0  0  0  11  11  10
00  0  0  1  0  0  0  0  0  11  11  10
00  0  0  0  0  0  0  0  0  11  11  10  #save value of 82 in reg3

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory

#save 44 in 0083

00  0  0  0  0  0  0  0  0  11  11  10
00  0  0  1  0  0  0  0  0  11  11  10
00  0  0  0  0  0  0  0  0  11  11  10  #save value of 83 in reg3

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory

#save 45 in 0084

00  0  0  0  0  0  0  0  0  11  11  10
00  0  0  1  0  0  0  0  0  11  11  10
00  0  0  0  0  0  0  0  0  11  11  10  #save value of 84 in reg3

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory


#save 46 in 0085

00  0  0  0  0  0  0  0  0  11  11  10
00  0  0  1  0  0  0  0  0  11  11  10
00  0  0  0  0  0  0  0  0  11  11  10  #save value of 85 in reg3

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory


#save 47 in 0086

00  0  0  0  0  0  0  0  0  11  11  10
00  0  0  1  0  0  0  0  0  11  11  10
00  0  0  0  0  0  0  0  0  11  11  10  #save value of 86 in reg3

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory


#save 48 in 0087

00  0  0  0  0  0  0  0  0  11  11  10
00  0  0  1  0  0  0  0  0  11  11  10
00  0  0  0  0  0  0  0  0  11  11  10  #save value of 87 in reg3

00  0  1  0  0  0  0  0  0  01  01  00
00  0  1  1  0  0  0  0  0  01  01  00
00  0  1  0  0  0  0  0  0  01  01  00  #add reg0 to reg1 with carry



00  0  0  0  0  1  0  0  0  00  00  11
00  0  0  0  0  0  0  0  0  00  00  11  #save address in mar

00  0  0  0  0  0  0  1  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to mbr

00  0  0  0  0  0  1  0  0  00  00  01
00  0  0  0  0  0  0  0  0  00  00  01  #writing to memory

