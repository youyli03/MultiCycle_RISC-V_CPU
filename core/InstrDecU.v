`include "InstrDef.vh"

module InstrDecU (
    input  wire [31:0]  instr   ,

    output wire [31:0]  imm32   ,

    output wire         in1_sel ,       // 0 reg, 1 pc  , pc在mem阶段再更新,这样不用pc+4
    output wire         in2_sel ,       // 0 reg, 1 imm32

    output wire         lui     ,
    output wire         RItype  , // add sub sll slt sltu xor srl sra or and
    output wire         Btype   ,
    output wire         Jal     ,
    output wire         Jalr    ,
    output wire         Load    ,
    output wire         Store   ,

    output wire         reg_wr_req  

);

wire [6:0]  opcode  ;
wire [2:0]  func3   ;

assign opcode   = instr[6:0]    ;
assign func3    = instr[14:12]  ;


wire Rtype  ;
wire Itype_imm  ;
wire Itype_load ;
wire Itype_jalr ;
wire Stype  ;
// wire Btype  ;
wire Jtype  ;
wire Utype_lui      ;
wire Utype_auipc    ;

assign Rtype = (opcode == `Rtype        );
assign Itype_imm    = (opcode == `Itype_imm     );
assign Itype_load   = (opcode == `Itype_load    );
assign Itype_jalr   = (opcode == `Itype_jalr    );
assign Stype = (opcode == `Stype        );
assign Btype = (opcode == `Btype        );
assign Jtype = (opcode == `Jtype_jal    );
assign Utype_lui    = (opcode == `Utype_lui     );
assign Utype_auipc  = (opcode == `Utype_auipc   );

//条件分支不使用alu 直接pc+imm
assign in1_sel = Utype_auipc | Jtype | Itype_jalr;
// lui 不使用alu auipc in1 pc in2 imm32 jal pc imm32 jalr rs1 imm32
// load mem->rd store rs2->mem
//jal 和 btype都在mem获得pc地址
// assign in2_sel = Utype_auipc | Stype | Itype_load | RItype | Itype_jalr;
assign in2_sel = ~(Utype_lui | Jtype | Btype | Rtype)   ;

assign RItype = Rtype | Itype_imm       ;
assign reg_wr_req = ~(Btype | Stype)    ;

// assign Jal_Jalr = Jtype | Itype_jalr    ;
assign lui  = Utype_lui     ;
assign Jal  = Jtype         ;
assign Jalr = Itype_jalr    ;
assign Load = Itype_load    ;
assign Store = Stype    ;

// assign imm32 = (Itype_imm) ? {{20{instr[31]}}, instr[31:20]} :
//                (Stype) ? {{20{instr[31]}}, instr[31:25], instr[11:7]} :
//                (Btype) ? {{20{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0} :
//                (Jtype) ? {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0} :
//                {instr[31:12], 12'b0} ;
//                (Utype_lui | Utype_auipc) ? {instr[31:12], 12'b0} :
//                32'b0 ;

wire [31:0] imm32_i = {{20{instr[31]}}, instr[31:20]};
wire [31:0] imm32_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
wire [31:0] imm32_b = {{20{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
wire [31:0] imm32_j = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
wire [31:0] imm32_u = {instr[31:12], 12'b0};

//
// assign imm32 = ({32{Itype_imm}} & imm32_i) |
//                ({32{Stype}} & imm32_s) |
//                ({32{Btype}} & imm32_b) |
//                ({32{Jtype}} & imm32_j) |
//                ({32{Utype_lui | Utype_auipc}} & imm32_u) ;

//34
// assign imm32 = (Itype_imm | Itype_jalr | Itype_load) ? imm32_i :
//                (Stype) ? imm32_s :
//                (Btype) ? imm32_b :
//                (Jtype) ? imm32_j :
//                imm32_u ;

//30
assign imm32 = (Utype_lui | Utype_auipc) ? imm32_u :
               (Stype) ? imm32_s :
               (Btype) ? imm32_b :
               (Jtype) ? imm32_j :
               imm32_i ;



endmodule