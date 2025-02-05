`include "InstrDef.vh"

module tb_single_instr( );

reg  clk = 1;
reg  rst = 0;
always #1 clk = ~clk;

reg [31:0] data [1023:0];
wire mem_en = (mem_addr[31:10] == 22'd0 );

wire        mem_req   ;
wire        mem_write ;
reg         mem_valid ;
reg         mem_ready ;
wire [31:0] mem_addr  ;
wire [31:0] mem_wdata ;
reg  [31:0] mem_rdata ;
wire [3:0]  mem_mask  ;

wire [31:0] __mem_rdata = data[mem_addr[9:2]] ;
wire [31:0] _mem_rdata = 
    {   __mem_rdata[7:0],__mem_rdata[15:8],__mem_rdata[23:16],__mem_rdata[31:24]} ;

initial begin
    // data[0]  = 32'h00000013; // addi x0, x0, 0  (x0 is always 0, so this is a NOP)
    // data[1]  = 32'h00100093; // addi x1, x0, 1  (x1 = x0 + 1)
    // data[2]  = 32'h00108113; // addi x2, x1, 1  (x2 = x1 + 1)
    // data[3]  = 32'h00110193; // addi x3, x2, 1  (x3 = x2 + 1)
    // data[4]  = 32'h00118213; // addi x4, x3, 1  (x4 = x3 + 1)
    // data[5]  = 32'h00120293; // addi x5, x4, 1  (x5 = x4 + 1)
    // data[6]  = 32'h00128313; // addi x6, x5, 1  (x6 = x5 + 1)
    // data[7]  = 32'h00130393; // addi x7, x6, 1  (x7 = x6 + 1)
    // data[8]  = 32'h00138413; // addi x8, x7, 1  (x8 = x7 + 1)
    // data[9]  = 32'h00140493; // addi x9, x8, 1  (x9 = x8 + 1)
    // data[10] = 32'h00148513; // addi x10, x9, 1 (x10 = x9 + 1)
    // data[11] = 32'h00150593; // addi x11, x10, 1 (x11 = x10 + 1)
    // data[12] = 32'h00158613; // addi x12, x11, 1 (x12 = x11 + 1)
    // data[13] = 32'h00160693; // addi x13, x12, 1 (x13 = x12 + 1)
    // data[14] = 32'h00168713; // addi x14, x13, 1 (x14 = x13 + 1)
    // data[15] = 32'h00170793; // addi x15, x14, 1 (x15 = x14 + 1)
    // data[16] = 32'h00178813; // addi x16, x15, 1 (x16 = x15 + 1)
    // data[17] = 32'h00180893; // addi x17, x16, 1 (x17 = x16 + 1)
    // data[18] = 32'h00188913; // addi x18, x17, 1 (x18 = x17 + 1)
    // data[19] = 32'h00190993; // addi x19, x18, 1 (x19 = x18 + 1)
    // data[20] = 32'h00198a13; // addi x20, x19, 1 (x20 = x19 + 1)
    // data[21] = 32'h001a0a93; // addi x21, x20, 1 (x21 = x20 + 1)
    // data[22] = 32'h001a8b13; // addi x22, x21, 1 (x22 = x21 + 1)
    // data[23] = 32'h001b0b93; // addi x23, x22, 1 (x23 = x22 + 1)
    // data[24] = 32'h001b8c13; // addi x24, x23, 1 (x24 = x23 + 1)
    // data[25] = 32'h001c0c93; // addi x25, x24, 1 (x25 = x24 + 1)
    // data[26] = 32'h001c8d13; // addi x26, x25, 1 (x26 = x25 + 1)
    // data[27] = 32'h001d0d93; // addi x27, x26, 1 (x27 = x26 + 1)
    // data[28] = 32'h001d8e13; // addi x28, x27, 1 (x28 = x27 + 1)
    // data[29] = 32'h001e0e93; // addi x29, x28, 1 (x29 = x28 + 1)
    // data[30] = 32'h001e8f13; // addi x30, x29, 1 (x30 = x29 + 1)
    // data[31] = 32'h001f0f93; // addi x31, x30, 1 (x31 = x30 + 1)

        // ========== 代码段 ========== //
    data[0]  = 32'h00000013;   // addi x0, x0, 0  (NOP)
    data[1]  = 32'h05000113;   // addi x2, x0, 0x50  (x2 = 0x50，数据段基地址)
    data[2]  = 32'h00400193;   // addi x3, x0, 4    (x3 = 4，偏移量)

    // 测试 lw (加载字)
    data[3]  = 32'h00012283;   // lw x5, 0(x2)     (x5 = data[20] = 0x12345678)
    data[4]  = 32'h00412303;   // lw x6, 4(x2)     (x6 = data[21] = 0x87654321)

    // 测试 sw (存储字)
    data[5]  = 32'h00512423;   // sw x5, 8(x2)     (data[22] = x5 = 0x12345678)
    data[6]  = 32'h00612623;   // sw x6, 12(x2)    (data[23] = x6 = 0x87654321)

    // 测试 lh (加载半字)
    data[7]  = 32'h00015483;   // lh x9, 0(x2)     (x9 = 0x5678，符号扩展)
    data[8]  = 32'h00215503;   // lh x10, 2(x2)    (x10 = 0x1234，符号扩展)

    // 测试 sh (存储半字)
    data[9]  = 32'h00915823;   // sh x9, 16(x2)    (data[24] = 0x5678)
    data[10] = 32'h00a15a23;   // sh x10, 20(x2)   (data[25] = 0x1234)

    // 测试 lb (加载字节)
    data[11] = 32'h00014603;   // lb x12, 0(x2)    (x12 = 0x78，符号扩展)
    data[12] = 32'h00114683;   // lb x13, 1(x2)    (x13 = 0x56，符号扩展)

    // 测试 sb (存储字节)
    data[13] = 32'h00c16c23;   // sb x12, 24(x2)   (data[26] = 0x78)
    data[14] = 32'h00d16e23;   // sb x13, 28(x2)   (data[27] = 0x56)

    // 结束
    data[15] = 32'h00000013;   // addi x0, x0, 0  (NOP)

    // ========== 数据段 ========== //
    // 初始化数据（从地址 0x50 开始）
    data[20] = 32'h12345678;   // 测试数据 1
    data[21] = 32'h87654321;   // 测试数据 2
    data[22] = 32'h00000000;   // 预留空间（sw 测试写入位置）
    data[23] = 32'h00000000;   // 预留空间（sw 测试写入位置）
    data[24] = 32'h00000000;   // 预留空间（sh 测试写入位置）
    data[25] = 32'h00000000;   // 预留空间（sh 测试写入位置）
    data[26] = 32'h00000000;   // 预留空间（sb 测试写入位置）
    data[27] = 32'h00000000;   // 预留空间（sb 测试写入位置）

    #10
    rst <= 1 ;
end

reg  [31:0] mask;
always@(*)begin
    mask[7:0]   <= mem_mask[0]?8'hff:8'h0;
    mask[15:8]  <= mem_mask[1]?8'hff:8'h0;
    mask[23:16] <= mem_mask[2]?8'hff:8'h0;
    mask[31:24] <= mem_mask[3]?8'hff:8'h0;
end

always@(posedge clk) begin
    mem_valid <= 0 ;
    if(mem_req & mem_en)begin
        if(mem_write)
            data[mem_addr[9:2]] <= (data[mem_addr[9:2]] & (~mask) )| (mem_wdata & mask) ;
        else begin
            mem_rdata <= __mem_rdata;
            mem_valid <= 1 ;
        end
    end
end

RiscvTop RiscvTop0(
    .clk       (clk),
    .rst_n     (rst),
    
	.mem_req   (mem_req  )   ,
	.mem_write (mem_write)   ,
	.mem_valid (mem_valid)   ,
	.mem_ready (mem_ready)   ,
	.mem_addr  (mem_addr )   ,
	.mem_wdata (mem_wdata)   ,
	.mem_rdata (mem_rdata)   ,
	.mem_mask  (mem_mask )   
);


endmodule