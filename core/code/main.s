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
addi x24, x0, 0

loop:
lw x18, 0x8(x15)
lw x19, 0xc(x15)
lw x20, 0x0(x10)
srli x25, x19, 7
bne x25, x24, timupdata
addi x21, x0, 0x4
and x22, x20, x21
beq x22, x0, uartupdate
j loop

uartupdate:
lw x23, 0x4(x10)
addi x30, x0, 0xff
and x23, x23, x30
sw x23, 8(x1)
j loop

timupdata:
addi x24, x25, 0
lw x23, 0x4(x10)
addi x30, x0, 0xff
xori x30, x30, -1
slli x26, x24, 8
and x23, x30, x26
sw x23, 8(x1)
j loop
