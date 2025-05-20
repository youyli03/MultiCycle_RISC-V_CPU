.section .text._start
.globl main
.globl _start
_start:
    lui sp, %hi(0x80001d00)    # 将 0xf80 的高 20 位加载到 sp 的高位
    addi sp, sp, %lo(0x80001d00) # 将 0xf80 的低 12 位加到 sp
    call main          /* 调用 main 函数 */
    j .                /* 无限循环 */