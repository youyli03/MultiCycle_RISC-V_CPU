module RiscvTop #(
	parameter [31:0] PC_RESET = 32'h 0000_0000
)(
    input         clk       ,
    input         rst_n     ,
    
	output  reg         mem_req     ,
	output  reg         mem_write   ,
	input               mem_valid   ,
	input               mem_ready   ,
	output  reg [31:0]  mem_addr    ,
	output wire [31:0]  mem_wdata   ,
	input       [31:0]  mem_rdata   ,
	output wire [3:0]   mem_mask    
    
);

localparam STATE_IDLE   = 3'd0  ;   //复位
localparam STATE_IF     = 3'd1  ;   //取指
localparam STATE_ID     = 3'd2  ;   //译码
localparam STATE_EX     = 3'd3  ;   //执行
localparam STATE_MEM    = 3'd4  ;   //存储
localparam STATE_WB     = 3'd5  ;   //写回

reg  [2:0]  rv_state        ;
reg  [2:0]  rv_state_nxt    ;

reg  [31:0] pc      ;

reg  [31:0] instr   ;
// assign instr = mem_rdata   ;
wire [31:0] imm32   ;

wire [31:0] o_rd1   ;
wire [31:0] o_rd2   ;

wire [2:0]  type    ;

// wire        lui     ;
// wire        RItype  ;
// wire        Btype   ;
// wire        Jal     ;
// wire        Jalr    ;
// wire        Load    ;
// wire        Store   ;

wire load_store = ~type[2] & type[1]    ;
wire store      = type[0] & load_store  ;

wire [1:0]  in1_sel ;
wire [2:0]  in2_sel ;
wire [31:0] alu_in1 ;
wire [31:0] alu_in2 ;
wire [31:0] alu_out ;

// wire [6:0]  opcode  ;
wire [4:0]  rd      ;
wire [2:0]  func3   ;
wire [4:0]  rs1     ;
wire [4:0]  rs2     ;
// wire [6:0]  func7   ;

wire [1:0]  ls_size = func3[1:0] ;
wire        load_unsigned_flag = func3[2] ;
reg  [31:0] _load_data ;
// wire        load_signed = load_unsigned_flag ?
//                 ( (ls_size == 2'b0) ? load_data[7] :
//                   (ls_size == 2'b1) ? load_data[15] :
//                   load_data[15] ) : 0;
wire        load_signed = load_unsigned_flag & ( (~ls_size[0] & _load_data[7]) | (ls_size[0] & _load_data[15]));
reg  [31:0] load_data ;
reg  [31:0] alu_out_save ;
always@(*) begin
    alu_out_save <= alu_out_save ;
    if(rv_state == STATE_EX)
        alu_out_save <= alu_out ;
end

reg  [31:0] _store_data ;
reg  [3:0]  _store_mask ;
assign mem_wdata = _store_data ;

wire Btype_Jump_en = alu_out_save[0] ;

// wire        pc_change_allow = ( Btype & alu_out[0]) | (Jal | Jalr)  ;
// wire [31:0] pc_change_res   = Jalr ? alu_out : pc + imm32    ;
// wire [31:0] pc_add_4        = pc + 3'd4 ;

wire        reg_wr_req  ;
wire        reg_wr_en = (rv_state == STATE_WB) && reg_wr_req;
wire [1:0]  reg_wr_sel ;
wire [31:0] reg_wr_data = reg_wr_sel[0] ? imm32 : 
                        reg_wr_sel[1] ? load_data :
                        alu_out_save ;


// assign opcode   = instr[6:0]    ;
assign rd       = instr[11:7]   ;
assign func3    = instr[14:12]  ;
assign rs1      = instr[19:15]  ;
assign rs2      = instr[24:20]  ;
// assign func7    = instr[31:25]  ;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rv_state <= STATE_IDLE      ;
    else
        rv_state <= rv_state_nxt    ;
end

always @(*) begin
    if(!rst_n) begin
        rv_state_nxt <= STATE_IDLE  ;
    end else begin
        case(rv_state)
        STATE_IDLE:begin
            rv_state_nxt <= STATE_IF    ;
        end
        STATE_IF:begin //取指
            rv_state_nxt <= STATE_ID    ;
        end
        STATE_ID:begin //译码 �?个周�?
            if(mem_valid) begin
                rv_state_nxt <= STATE_EX    ;
                instr <= mem_rdata   ;
            end
        end
        STATE_EX:begin //执行 等待ALU结束信号
            rv_state_nxt <= STATE_MEM   ;
        end
        STATE_MEM:begin //load、store和分支指令�??
            rv_state_nxt <= STATE_WB   ;
        end
        STATE_WB:begin
            rv_state_nxt <= STATE_IF    ;
        end
        endcase
    end
end

// always @(*) begin
//     alu_in1 = in1_sel ? pc : o_rd1      ;
//     alu_in2 = in2_sel ? imm32 : o_rd2   ;
//     if(rv_state == STATE_WB) begin
//         alu_in1 = pc    ;
//         alu_in2 = Btype ? imm32 : 3'd4  ;
//     end
// end

// assign alu_in1 = (rv_state == STATE_WB) ? (Jalr ? o_rd1 : pc) :
//                 in1_sel ? pc: o_rd1      ;
// assign alu_in2 = (rv_state == STATE_WB) ? ((Btype & Btype_Jump_en) | Jal | Jalr ? imm32 : 3'd4) :
//                 Jal | Jalr ? 3'd4 :
//                 in2_sel ? imm32 : o_rd2   ;
assign alu_in1 = (rv_state == STATE_WB) ? (in1_sel[1] ? o_rd1 : pc) :
                in1_sel[0] ? pc: o_rd1      ;
assign alu_in2 = (rv_state == STATE_WB) ? ((in2_sel[2] & Btype_Jump_en) | in2_sel[1] ? imm32 : 3'd4) :
                in2_sel[1] ? 3'd4 :
                in2_sel[0] ? imm32 : o_rd2   ;

// output  reg         mem_req     ,
// output  reg         mem_write   ,
// input               mem_valid   ,
// input               mem_ready   ,
// output wire [31:0]  mem_addr    ,
// output  reg [31:0]  mem_wdata   ,
// input       [31:0]  mem_rdata   

// assign mem_addr = (rv_state == STATE_MEM )? alu_out_save : pc ;
always@(rv_state) begin
    mem_addr <= mem_addr;
    case(rv_state)
    STATE_IF : mem_addr <= pc       ;
    STATE_MEM: mem_addr <= alu_out  ;
    endcase
end

//假设4字节对齐
always@(*) begin
    _store_mask <= 4'hf ;
    case(ls_size)
    2'b00: _store_mask <= 4'b01  ;
    2'b01: _store_mask <= 4'b11  ;
    endcase
end
assign mem_mask = _store_mask << mem_addr[1:0] ;

always@(*) begin
    _store_data <= o_rd2 ;
    case(mem_addr[1:0])
    2'b01: _store_data[15:8]  <= o_rd2[7:0]  ;
    2'b10: _store_data[31:16] <= o_rd2[15:0] ;
    2'b11: _store_data[31:24] <= o_rd2[7:0]  ;
    endcase
end

//假设4字节对齐
always@(*) begin
    _load_data <= mem_rdata ;
    case(mem_addr[1:0])
    2'b01: _load_data[7:0]  <= mem_rdata[15:8]  ;
    2'b10: _load_data[15:0] <= mem_rdata[31:16] ;
    2'b11: _load_data[7:0]  <= mem_rdata[31:24] ;
    endcase
end

always@(*) begin
    case(ls_size)
    2'b00: load_data <= { load_signed ? 24'hffffff : 24'h0, _load_data[7:0]};
    2'b01: load_data <= { load_signed ? 16'hffff : 16'h0, _load_data[15:0]} ;
    default: load_data <= _load_data ;
    endcase
end

always @(*) begin
    mem_req <= 1'b0  ;
    mem_write   <= 1'b0 ;
    case(rv_state)
        STATE_IF: begin
            mem_req <= 1'b1  ;
        end
        //放在WB而不是MEM是因为这个可以方便jal/jalr指令写回pc+4
        STATE_MEM: begin
            mem_req <= load_store   ;
            mem_write   <= store    ;
            // mem_req <= Load | Store ;
            // mem_write   <= Store    ;
        end
    endcase
end

always @(posedge clk) begin
    pc <= pc ;
    case(rv_state)
        STATE_IDLE: pc <= PC_RESET  ;
        //放在WB而不是MEM是因为这个可以方便jal/jalr指令写回pc+4
        STATE_WB: begin
                pc <= alu_out ;
        end
    endcase
end

(* DONT_TOUCH = "true" *) Alu Alu0(
    .clk        (clk        ),

    // .RItype     (RItype     ),
    // .Rtype      (RItype & ~in2_sel ),
    .PChandler  ((rv_state == STATE_WB)),
    .funct      (func3      ),
    .instr_30   (instr[30]  ),
    // .Btype      (Btype      ),
    // input  wire         JSLtype     ,   // add req

    .type       (type       ),

    .in1        (alu_in1    ),
    .in2        (alu_in2    ),
    .out        (alu_out    )
);

(* DONT_TOUCH = "true" *) InstrDecU IDU(
    .instr      (instr      ),
    .imm32      (imm32      ),
    .in1_sel    (in1_sel    ),       // 0 reg, 1 pc  , pc在mem阶段再更�?,这样不用pc-4
    .in2_sel    (in2_sel    ),       // 0 reg, 1 imm32

    .type       (type       ),
    // .lui        (lui        ),
    // .RItype     (RItype     ), // add sub sll slt sltu xor srl sra or and
    // .Btype      (Btype      ),
    // .Jal        (Jal        ),
    // .Jalr       (Jalr       ),
    // .Load       (Load       ),
    // .Store      (Store      ),

    .reg_wr_sel (reg_wr_sel ),
    .reg_wr_req (reg_wr_req )
);

(* DONT_TOUCH = "true" *) RegFile RegFile0(
    .clk    (clk        ),
    .rs1    (rs1        ),
    .rs2    (rs2        ),
    .rd     (rd         ),
    .wr_en  (reg_wr_en  ),

    .rd1    (o_rd1      ),
    .rd2    (o_rd2      ),
    .i_data (reg_wr_data)
);




endmodule