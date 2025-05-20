# toolchain = E:/code/MultiCycle_RISC-V_CPU/riscv-gcc-x86/bin/riscv-none-embed-
toolchain = F:/Github/MultiCycle_RISC-V_CPU/riscv-gcc-x86/bin/riscv-none-embed-

# 定义编译器
CC = $(toolchain)gcc.exe
objdump = $(toolchain)objdump.exe
objcopy = $(toolchain)objcopy.exe

# 定义编译器选项，例如调试选项
CFLAGS = -march=rv32i -mabi=ilp32 -T link.ld -nostartfiles -nostdlib 

# 定义目标文件名
TARGET = oledGame

# 定义源文件
SOURCE = main.c startup.S \
	oled/I2C.c \
	oled/OLED.c \
	oled/dino.c \

OBJECTS = $(SOURCE:.c=.o)
OBJECTS := $(OBJECTS:.S=.o)

# 默认目标
all: $(TARGET).elf $(TARGET).asm $(TARGET).v

# 链接目标文件生成 ELF 文件
$(TARGET).elf: $(OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET).elf $(OBJECTS) -Os -Wl,--gc-sections

# 将 C 源文件编译为目标文件
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# 将汇编源文件编译为目标文件
%.o: %.S
	$(CC) $(CFLAGS) -c $< -o $@

# 反汇编生成带源码的汇编文件
$(TARGET).asm: $(TARGET).elf
	$(objdump) -d -S $^ > $@
	
$(TARGET).v: $(TARGET).elf
	$(objcopy) -O verilog $< $@

# 清理生成的文件
clean:
	del $(TARGET)*
	del $(subst /,\,$(OBJECTS))