module bus(
    input  wire         master_req      ,
	input  wire         master_write    ,
	output reg          master_valid    ,
	output reg          master_ready    ,
    input  wire [31:0]  master_addr     ,
    input  wire [31:0]  master_wdata    ,
    output reg  [31:0]  master_rdata    ,
	input  wire [3:0]   master_mask     ,
    
	output reg          slave_0_req     ,
	output wire         slave_0_write   ,
	input  wire         slave_0_valid   ,
	input  wire         slave_0_ready   ,
	output wire [31:0]  slave_0_addr    ,
	output reg  [31:0]  slave_0_wdata   ,
	input  wire [31:0]  slave_0_rdata   ,
	output wire [3:0]   slave_0_mask    ,
    
	output reg          slave_1_req     ,
	output wire         slave_1_write   ,
	input  wire         slave_1_valid   ,
	input  wire         slave_1_ready   ,
	output wire [31:0]  slave_1_addr    ,
	output reg  [31:0]  slave_1_wdata   ,
	input  wire [31:0]  slave_1_rdata   ,
    
	output reg          slave_2_req     ,
	output wire         slave_2_write   ,
	input  wire         slave_2_valid   ,
	input  wire         slave_2_ready   ,
	output wire [31:0]  slave_2_addr    ,
	output reg  [31:0]  slave_2_wdata   ,
	input  wire [31:0]  slave_2_rdata   ,
    
	output reg          slave_3_req     ,
	output wire         slave_3_write   ,
	input  wire         slave_3_valid   ,
	input  wire         slave_3_ready   ,
	output wire [31:0]  slave_3_addr    ,
	output reg  [31:0]  slave_3_wdata   ,
	input  wire [31:0]  slave_3_rdata   
);

//mem  0x80000000
assign slave_0_addr = {4'b0,master_addr[27:0]};
//gpio 0xf0000000
assign slave_1_addr = {20'b0,master_addr[11:0]};
//uart 0xf0001000
assign slave_2_addr = {20'b0,master_addr[11:0]};
//tim  0xf0002000
assign slave_3_addr = {20'b0,master_addr[11:0]};

assign slave_0_write = master_write ;
assign slave_1_write = master_write ;
assign slave_2_write = master_write ;
assign slave_3_write = master_write ;

assign slave_0_mask  = master_mask  ;

reg [1:0] slave_sel;
always@(*)begin
    slave_sel   <= 2'd0 ;
    if(master_addr[31:16] == 16'hf000) begin
        case(master_addr[15:12])
        4'd0: slave_sel <= 2'd1;
        4'd1: slave_sel <= 2'd2;
        4'd2: slave_sel <= 2'd3;
        endcase
    end
end

always@(*)begin
    slave_0_req   <= 1'b0 ;
    slave_1_req   <= 1'b0 ;
    slave_2_req   <= 1'b0 ;
    slave_3_req   <= 1'b0 ;

    slave_0_wdata <= 32'b0;
    slave_1_wdata <= 32'b0;
    slave_2_wdata <= 32'b0;
    slave_3_wdata <= 32'b0;

    master_valid  <= 1'b0 ;
    master_ready  <= 1'b0 ;
    case(slave_sel)
    2'd0:begin
        slave_0_req   <= master_req   ;
        slave_0_wdata <= master_wdata ;
        master_rdata <= slave_0_rdata ;
        master_valid <= slave_0_valid ;
        master_ready <= slave_0_ready ;
    end
    2'd1:begin
        slave_1_req   <= master_req   ;
        slave_1_wdata <= master_wdata ;
        master_rdata <= slave_1_rdata ;
        master_valid <= slave_1_valid ;
        master_ready <= slave_1_ready ;
    end
    2'd2:begin
        slave_2_req   <= master_req   ;
        slave_2_wdata <= master_wdata ;
        master_rdata <= slave_2_rdata ;
        master_valid <= slave_2_valid ;
        master_ready <= slave_2_ready ;
    end
    2'd3:begin
        slave_3_req   <= master_req   ;
        slave_3_wdata <= master_wdata ;
        master_rdata <= slave_3_rdata ;
        master_valid <= slave_3_valid ;
        master_ready <= slave_3_ready ;
    end
    endcase
end

endmodule