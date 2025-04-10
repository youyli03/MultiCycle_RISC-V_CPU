lui x1, 0xf0000
addi x2, x0, 17
sw x2, 8(x1)
lw x3, 0(x1)
lui x10, 0xf0001
addi x11, x0, 433
sw x11, 8(x10)
addi x12, x0, 0xff
sw x12, 4(x10)
addi x12, x0, 0xaa
sw x12, 4(x10)
addi x12, x0, 0x55
sw x12, 4(x10)
lui x15, 0xf0002
addi x16, x0, 99
sw x16, 4(x15)
addi x17, x0, 3
sw x17, 0(x15)
loop:
lw x18, 0x8(x15)
lw x19, 0xc(x15)
j loop