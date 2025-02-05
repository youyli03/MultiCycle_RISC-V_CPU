`include "InstrDef.vh"

module tb_jtype_btype( );

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
    data[0]  = 32'h00100413;   // addi x8, x0, 1
    data[1]  = 32'h00200493;   // addi x9, x0, 2 
    
    //x8 1 x9 2
    data[2]  = 32'h00940463;   // beq x8, x9, 30
    data[3]  = 32'h00150513;   // addi x10, x10, 1

    data[4]  = 32'h10000637;   //lui x12, 65536
    // data[4]  = 32'h00941463;   // bne x8, x9, 8
    data[5]  = 32'h00150513;   // addi x10, x10, 1
    data[6]  = 32'h00944463;   // blt x8, x9, 8           # If x8 < x9, skip the increment
    data[7]  = 32'h00200697;   // auipc x13, 512
    // data[7]  = 32'h00150513;   // addi x10, x10, 1
    data[8]  = 32'h00945463;   // bge x8, x9, 8           # If x8 >= x9, skip the increment
    data[9]  = 32'h00200697;   // auipc x13, 512
    // data[9]  = 32'h00150513;   // addi x10, x10, 1
    data[10] = 32'h00946463;   // bltu x8, x9, 8          # If x8 < x9 (unsigned), skip the increment
    data[11] = 32'h00150513;   // addi x10, x10, 1
    data[12] = 32'h00947463;   // bgeu x8, x9, 8          # If x8 >= x9 (unsigned), skip the increment
    data[13] = 32'h00150513;   // addi x10, x10, 1

    // //jal x1, 2048
    // data[14]  = 32'h001000ef;
    //jalr x1, 128(x0)
    data[14] =32'h080000e7;
    //jalr x3, 128(x0)
    data[15] =32'h80001e7;

    //jal x2, -68
    data[32] =32'hfbdff16f;

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