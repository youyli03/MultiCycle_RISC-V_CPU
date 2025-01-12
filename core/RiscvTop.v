module RiscvTop #(
	parameter [31:0] PC_RESET = 32'h 0000_0000
)(
    input         clk       ,
    input         rst_n     ,
    
	output  reg         mem_req     ,
	output  reg         mem_write   ,
	input               mem_valid   ,
	input               mem_ready   ,
	output wire [31:0]  mem_addr    ,
	output  reg [31:0]  mem_wdata   ,
	input       [31:0]  mem_rdata   
	// output  reg [3:0]   mem_mask    
    
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

wire [31:0] instr   ;
assign instr = mem_rdata   ;
wire [31:0] imm32   ;

wire [31:0] o_rd1   ;
wire [31:0] o_rd2   ;

wire        lui     ;
wire        RItype  ;
wire        Btype   ;
wire        Jal     ;
wire        Jalr    ;
wire        Load    ;
wire        Store   ;

wire        in1_sel ;
wire        in2_sel ;
wire [31:0] alu_in1 = in1_sel ? pc : o_rd1      ;
wire [31:0] alu_in2 = in2_sel ? imm32 : o_rd2   ;
wire [31:0] alu_out ;

// wire [6:0]  opcode  ;
wire [4:0]  rd      ;
wire [2:0]  func3   ;
wire [4:0]  rs1     ;
wire [4:0]  rs2     ;
// wire [6:0]  func7   ;

wire [31:0] Load_data;

wire        pc_change_allow = ( Btype & alu_out[0]) | (Jal | Jalr)  ;
wire [31:0] pc_change_res   = Jalr ? alu_out : pc + imm32    ;
wire [31:0] pc_add_4        = pc + 3'd4 ;

wire        reg_wr_req  ;
wire        reg_wr_en = (rv_state == STATE_WB) && reg_wr_req;
wire [31:0] reg_wr_data = (Jalr | Jal) ? pc_add_4 : 
                        lui ? imm32 : 
                        Load ? Load_data :
                        alu_out ;


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
            // if(mem_valid)
                rv_state_nxt <= STATE_ID    ;
        end
        STATE_ID:begin //译码 一个周期
            rv_state_nxt <= STATE_EX    ;
        end
        STATE_EX:begin //执行 等待ALU结束信号
            rv_state_nxt <= STATE_MEM   ;
        end
        STATE_MEM:begin //load、store和分支指令。
            rv_state_nxt <= STATE_WB   ;
        end
        STATE_WB:begin
            rv_state_nxt <= STATE_IF    ;
        end
        endcase
    end
end


// output  reg         mem_req     ,
// output  reg         mem_write   ,
// input               mem_valid   ,
// input               mem_ready   ,
// output wire [31:0]  mem_addr    ,
// output  reg [31:0]  mem_wdata   ,
// input       [31:0]  mem_rdata   
assign mem_addr = pc    ;

always @(posedge clk) begin
    mem_req <= 1'b0  ;
    case(rv_state)
        STATE_IF: begin
            mem_req <= 1'b1  ;
        end
        //放在WB而不是MEM是因为这个可以方便jal/jalr指令写回pc+4
        STATE_MEM: begin
        end
    endcase
end

always @(posedge clk) begin
    pc <= pc ;
    case(rv_state)
        STATE_IDLE: pc <= PC_RESET  ;
        //放在WB而不是MEM是因为这个可以方便jal/jalr指令写回pc+4
        STATE_WB: begin
            if(pc_change_allow)
                pc <= pc_change_res ;
            else
                pc <= pc_add_4      ;
        end
    endcase
end

Alu Alu0(
    .clk        (clk        ),

    .RItype     (RItype     ),
    .funct      (func3      ),
    .instr_30   (instr[30]  ),
    .Btype      (Btype      ),
    // input  wire         JSLtype     ,   // add req

    .in1        (alu_in1    ),
    .in2        (alu_in2    ),
    .out        (alu_out    )
);

InstrDecU IDU(
    .instr      (instr      ),
    .imm32      (imm32      ),
    .in1_sel    (in1_sel    ),       // 0 reg, 1 pc  , pc在mem阶段再更新,这样不用pc-4
    .in2_sel    (in2_sel    ),       // 0 reg, 1 imm32

    .lui        (lui        ),
    .RItype     (RItype     ), // add sub sll slt sltu xor srl sra or and
    .Btype      (Btype      ),
    .Jal        (Jal        ),
    .Jalr       (Jalr       ),
    .Load       (Load       ),
    .Store      (Store      ),

    .reg_wr_req (reg_wr_req )
);

RegFile RegFile0(
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