module bus2mem(
    input         clk       ,
    input         rst_n     ,
    
    // Memory 接口
    input  wire         slave_req   ,
    input  wire         slave_write ,
    output reg          slave_valid ,
    output reg          slave_ready ,
    input  wire [31:0]  slave_addr  ,
    input  wire [31:0]  slave_wdata ,
    output reg  [31:0]  slave_rdata ,
    input  wire [3:0]   slave_mask  

);

reg [31:0] data [2047:0];

wire [31:0] __mem_rdata = data[slave_addr[14:2]] ;
wire [31:0] _mem_rdata = 
    {   __mem_rdata[7:0],__mem_rdata[15:8],__mem_rdata[23:16],__mem_rdata[31:24]} ;

reg  [31:0] mask;
always@(*)begin
    mask[7:0]   <= slave_mask[0]?8'hff:8'h0;
    mask[15:8]  <= slave_mask[1]?8'hff:8'h0;
    mask[23:16] <= slave_mask[2]?8'hff:8'h0;
    mask[31:24] <= slave_mask[3]?8'hff:8'h0;
end

always@(posedge clk) begin
    slave_valid <= 0 ;
    if(slave_req)begin
        if(slave_write)
            data[slave_addr[14:2]] <= (data[slave_addr[14:2]] & (~mask) )| (slave_wdata & mask) ;
        else begin
            slave_rdata <= __mem_rdata;
            slave_valid <= 1 ;
        end
    end
end

initial begin
    // $readmemh("E:/code/MultiCycle_RISC-V_CPU/core/mem_data/ctest.hex", data); // 从 data.hex 文件中读取十六进制数据
    $readmemh("F:/Github/MultiCycle_RISC-V_CPU/core/mem_data/oled.hex", data); // 从 data.hex 文件中读取十六进制数据
end

endmodule