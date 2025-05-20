ENTRY(_start)  /* 指定入口为 _start */

MEMORY {
    RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 8K /* 根据硬件调整 */
}

SECTIONS {
    .text : {
        *(.text._start) /* 启动代码 */
        *(.text*)
    } > RAM
    /* 其他段（如.data、.bss）略 */
}