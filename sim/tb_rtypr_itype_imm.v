`include "InstrDef.vh"

module tb_rtype_itype_imm( );

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
        // ========== 代码段 ========== //
    data[0]  = 32'h00000013;   // addi x0, x0, 0   (NOP)
    data[1]  = 32'h05000113;   // addi x2, x0, 0x50  (x2 = 数据段基地址 0x50)

    // ===== 初始化测试数据到寄存器 ===== //
    data[2]  = 32'h800000B7;   // lui x1, 0x80000   (x1 = 0x80000000, 最小负数)
    data[3]  = 32'hFFFFF0B7;   // lui x1, 0xFFFFF   (x1 = 0xFFFFF000)
    data[4]  = 32'h00008113;   // addi x2, x1, 0    (x2 = x1 = 0xFFFFF000)
    data[5]  = 32'h7FF00193;   // addi x3, x0, 2047 (x3 = 0x7FF)
    data[6]  = 32'h00400213;   // addi x4, x0, 4    (x4 = 4)
    data[7]  = 32'hFFF00293;   // addi x5, x0, -1   (x5 = 0xFFFFFFFF)
    data[8]  = 32'h00100313;   // addi x6, x0, 1    (x6 = 1)
    data[9]  = 32'h00000393;   // addi x7, x0, 0    (x7 = 0)

    // ===== R-type 指令测试 ===== //
    // 1. add 测试（正 + 正、正 + 负、负 + 负）
    data[10] = 32'h006303B3;   // add x7, x6, x6    (x7 = 1 + 1 = 2)
    data[11] = 32'h405303B3;   // sub x7, x6, x5    (x7 = 1 - (-1) = 2)
    data[12] = 32'h405283B3;   // sub x7, x5, x5    (x7 = -1 - (-1) = 0)

    // 2. and/or/xor 测试
    data[13] = 32'h0062F3B3;   // and x7, x5, x6    (x7 = 0xFFFFFFFF & 0x1 = 0x1)
    data[14] = 32'h0062E3B3;   // or x7, x5, x6     (x7 = 0xFFFFFFFF | 0x1 = 0xFFFFFFFF)
    data[15] = 32'h0062C3B3;   // xor x7, x5, x6    (x7 = 0xFFFFFFFF ^ 0x1 = 0xFFFFFFFE)

    // 3. sll/srl/sra 移位测试
    data[16] = 32'h006293B3;   // sll x7, x5, x6    (x7 = 0xFFFFFFFF << 1 = 0xFFFFFFFE)
    data[17] = 32'h0062D3B3;   // srl x7, x5, x6    (x7 = 0xFFFFFFFF >> 1逻辑 = 0x7FFFFFFF)
    data[18] = 32'h4062D3B3;   // sra x7, x5, x6    (x7 = 0xFFFFFFFF >> 1算术 = 0xFFFFFFFF)

    // 4. slt/sltu 比较测试
    data[19] = 32'h0062A3B3;   // slt x7, x5, x6    (x7 = (-1 < 1) ? 1 : 0 → 1)
    data[20] = 32'h0062B3B3;   // sltu x7, x5, x6   (x7 = (0xFFFFFFFF < 0x1) ? 1 : 0 → 0)

    // ===== I-type 指令测试 ===== //
    // 1. addi 测试（正数、负数、边界）
    data[21] = 32'h00130313;   // addi x6, x6, 1    (x6 = 1 + 1 = 2)
    data[22] = 32'hFFF28293;   // addi x5, x5, -1   (x5 = -1 - 1 = -2 → 0xFFFFFFFE)
    data[23] = 32'h7FF00313;   // addi x6, x0, 2047 (x6 = 2047)

    // 2. andi/ori/xori 测试
    data[24] = 32'hFF52F313;   // andi x6, x5, -11  (x6 = 0xFFFFFFFE & 0xFFFFFFF5 = 0xFFFFFFF4)
    data[25] = 32'h0012E313;   // ori x6, x5, 1     (x6 = 0xFFFFFFFE | 0x1 = 0xFFFFFFFF)
    data[26] = 32'h00F2C313;   // xori x6, x5, 15   (x6 = 0xFFFFFFFE ^ 0xF = 0xFFFFFFF1)

    // 3. slli/srli/srai 移位测试
    data[27] = 32'h00129313;   // slli x6, x5, 1    (x6 = 0xFFFFFFFE << 1 = 0xFFFFFFFC)
    data[28] = 32'h0012D313;   // srli x6, x5, 1    (x6 = 0xFFFFFFFE >> 1逻辑 = 0x7FFFFFFF)
    data[29] = 32'h4012D313;   // srai x6, x5, 1    (x6 = 0xFFFFFFFE >> 1算术 = 0xFFFFFFFF)

    // 4. slti/sltiu 立即数比较测试
    data[30] = 32'h0072A313;   // slti x6, x5, 7    (x6 = (-2 < 7) ? 1 : 0 → 1)
    data[31] = 32'h0072B313;   // sltiu x6, x5, 7   (x6 = (0xFFFFFFFE < 7) ? 1 : 0 → 0)

    // ===== 存储测试结果到数据段 ===== //
    data[32] = 32'h00712023;   // sw x7, 0(x2)      (存储 R-type 结果)
    data[33] = 32'h00612423;   // sw x6, 8(x2)      (存储 I-type 结果)

    data[34] = 32'h70000537;   // lui x10, 0x70000     x10 0x70000000
    data[35] = 32'h41c55513;   // srai x10, x10, 28    0x70000000 >> 28

    data[36] = 32'hf0000537;   // lui x10, 0x70000     x10 0xf0000000
    data[37] = 32'h41c55513;   // srai x10, x10, 28    0xf0000000 >> 28
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