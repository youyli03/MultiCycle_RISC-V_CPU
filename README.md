# MultiCycle RISC-V CPU

一个基于 Verilog HDL 实现的多周期 RISC-V RV32I 处理器，配套简易总线与片上外设，可综合至 GOWIN GW2A-18 FPGA，同时支持 Xilinx Vivado 仿真。

---

## 目录

- [架构概述](#架构概述)
- [目录结构](#目录结构)
- [指令支持](#指令支持)
- [存储器映射](#存储器映射)
- [外设说明](#外设说明)
- [快速上手](#快速上手)
- [仿真](#仿真)
- [目标硬件](#目标硬件)
- [License](#license)

---

## 架构概述

处理器采用 **7 状态一次热编码 (One-Hot) FSM** 实现多周期流水：

```
IDLE → IF（取指）→ ID（译码）→ REG2（读 rs2）→ EX（执行）→ MEM（访存）→ WB（写回）
```

- **寄存器堆**：32 × 32-bit，单端口读写，降低资源占用（`ram_style="distributed"`）
- **ALU**：复用加减法器实现比较（SLT/SLTU/BLT/BGE 等），支持移位、逻辑运算
- **立即数**：由指令类型控制的多路选择器在 ID 阶段组合生成，无需额外寄存器
- **总线**：1 主 4 从的简易请求-应答总线（req / valid / ready 握手）

### 模块层次

```
GW_SOC_TOP / SOC_TOP
├── RiscvTop          ← CPU 核心（多周期 FSM）
│   ├── InstrDecU     ← 指令译码单元
│   ├── Alu           ← 算术逻辑单元
│   └── RegFile       ← 通用寄存器堆
└── bus               ← 地址路由总线
    ├── bus2mem       ← SRAM（Slave 0）
    ├── bus2gpio      ← GPIO（Slave 1）
    ├── bus2uart      ← UART（Slave 2）
    └── bus2tim       ← 定时器（Slave 3）
```

---

## 目录结构

```
.
├── core/                  # RTL 源码
│   ├── RiscvTop.v         # CPU 顶层（多周期 FSM）
│   ├── InstrDecU.v        # 指令译码
│   ├── InstrDef.vh        # 指令宏定义
│   ├── Alu.v              # ALU
│   ├── RegFile.v          # 寄存器堆
│   ├── bus.v.V            # 总线
│   ├── soc_top.v          # SoC 顶层
│   ├── busSlave/          # 总线从设备
│   │   ├── bus2mem.v      # 8KB SRAM
│   │   ├── bus2gpio.v     # 32-bit GPIO
│   │   ├── bus2uart.v     # UART（含 TX/RX FIFO）
│   │   ├── bus2tim.v      # 定时器
│   │   ├── uart_rx.v
│   │   └── uart_tx.v
│   └── code/              # 示例软件
│       ├── main.s         # 汇编示例
│       ├── cTest/         # C 语言测试程序
│       └── Flowinglight/  # 流水灯示例
├── sim/                   # 仿真 Testbench
│   ├── tb_soc.v
│   ├── tb_single_instr.v
│   ├── tb_rtypr_itype_imm.v
│   ├── tb_load_store.v
│   └── tb_jtype_btype.v
├── gowin-prj/             # GOWIN IDE 工程
├── multicycle-riscv-prj/  # Xilinx Vivado 工程
├── riscv-gcc-x86/         # RISC-V GCC 工具链（x86 Linux）
├── v2hex.py               # Intel HEX → 仿真 mem 格式转换脚本
└── note/note.md           # 设计备注
```

---

## 指令支持

实现 **RISC-V RV32I** 基础整数指令集：

| 类型 | 指令 |
|------|------|
| R-type | ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND |
| I-type (算术) | ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI |
| I-type (访存) | LB, LH, LW, LBU, LHU |
| S-type | SB, SH, SW |
| B-type | BEQ, BNE, BLT, BGE, BLTU, BGEU |
| J-type | JAL, JALR |
| U-type | LUI, AUIPC |

---

## 存储器映射

| 地址范围 | 大小 | 说明 |
|----------|------|------|
| `0x8000_0000` – `0x8000_1FFF` | 8 KB | SRAM（代码 + 数据） |
| `0xF000_0000` – `0xF000_000B` | — | GPIO |
| `0xF000_1000` – `0xF000_100B` | — | UART |
| `0xF000_2000` – `0xF000_200F` | — | 定时器 |

CPU 复位 PC：`0x8000_0000`

---

## 外设说明

### GPIO（`0xF000_0000`）

| 偏移 | 寄存器 | 说明 |
|------|--------|------|
| `0x000` | GPIO_DATA | 读取引脚输入值 |
| `0x004` | GPIO_DIR | 方向控制（0=输入，1=输出） |
| `0x008` | GPIO_SET | 输出数据寄存器 |

### UART（`0xF000_1000`）

| 偏移 | 寄存器 | 说明 |
|------|--------|------|
| `0x000` | STATUS | TX/RX FIFO 状态标志 |
| `0x004` | DATA | 读/写数据字节 |
| `0x008` | BAUD | 波特率分频值 |

TX/RX 各配备 32 字节深度的环形 FIFO。

### 定时器（`0xF000_2000`）

| 偏移 | 寄存器 | 说明 |
|------|--------|------|
| `0x000` | CTRL | 启动 / 自动重装 / 清零 |
| `0x004` | CNT | 计数上限（分频） |
| `0x008` | VAL | 当前计数值 |
| `0x00C` | OVERCNT | 溢出累计次数 |

---

## 快速上手

### 1. 编译软件

需要 `riscv-none-embed-gcc`（已附于 `riscv-gcc-x86/` 目录，适用 x86 Linux）。

```bash
cd core/code/cTest
make
```

编译产物为 `.hex` 文件（Intel HEX 格式）。

### 2. 生成仿真内存初始化文件

```bash
python v2hex.py <input.hex> <output.mem>
```

输出的 `.mem` 文件可由 `$readmemh` 加载至仿真中的 SRAM。

### 3. 综合到 GOWIN FPGA

使用 **GOWIN IDE**，打开 `gowin-prj/gowin-prj.gprj`，直接综合并下载。

---

## 仿真

使用 **Xilinx Vivado** 打开 `multicycle-riscv-prj/multicycle-riscv-prj.xpr`，或将 `sim/` 与 `core/` 目录下的文件加入任意兼容 Verilog 的仿真器运行。

SoC 级 Testbench：`sim/tb_soc.v`（UART TX/RX 自回环，GPIO 输入固定为 `0x0F00`）。

---

## 目标硬件

| 项目 | 规格 |
|------|------|
| FPGA | GOWIN GW2A-LV18PG256C8/I7 (GW2A-18C) |
| 工作时钟 | 108 MHz（PLL 生成） |
| 时序约束 | 9.259 ns（见 `gowin-prj/src/gowin-prj.sdc`） |

---

## License

[MIT](LICENSE)
