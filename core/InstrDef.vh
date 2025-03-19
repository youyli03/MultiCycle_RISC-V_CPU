
// opcode
`define Rtype       7'b0110011   //add/sub sll slt sltu xor srl sra or and  10条
`define Itype_imm   7'b0010011   //addi slti sltiu xori ori andi slli srli/srai
`define Itype_load  7'b0000011   //lb lh lw lbu lhu
`define Stype       7'b0100011   //sb sh sw
`define Btype       7'b1100011   //beq bne blt bge bltu bgeu
`define Jtype_jal   7'b1101111   //JAL
`define Itype_jalr  7'b1100111   //JALR
`define Utype_lui   7'b0110111   //LUI
`define Utype_auipc 7'b0010111   //AUIPC

//type
`define TYPE_TYPE_NONE   3'b000
`define TYPE_BTYPE       3'b001
`define TYPE_LOAD        3'b010
`define TYPE_STORE       3'b011
`define TYPE_ITYPE       3'b100
`define TYPE_RTYPE       3'b101
`define TYPE_JAL         3'b110
`define TYPE_JALR        3'b111 

//funct3
`define FUNCT_ADDSUB       3'b000
`define FUNCT_SLL          3'b001
`define FUNCT_SLT          3'b010
`define FUNCT_SLTU         3'b011
`define FUNCT_XOR          3'b100
`define FUNCT_SRLSRA       3'b101
`define FUNCT_OR           3'b110
`define FUNCT_AND          3'b111 

`define FUNCT_ADDI         3'b000
`define FUNCT_SLTI         3'b010
`define FUNCT_SLTIU        3'b011
`define FUNCT_XORI         3'b100
`define FUNCT_ORI          3'b110
`define FUNCT_ANDI         3'b111
`define FUNCT_SLLI         3'b001
`define FUNCT_SRLISRAI     3'b101

`define FUNCT_BEQ          3'b000
`define FUNCT_BNE          3'b001
`define FUNCT_BLT          3'b100
`define FUNCT_BGE          3'b101
`define FUNCT_BLTU         3'b110
`define FUNCT_BGEU         3'b111


//load
`define FUNCT_LB            3'b000
`define FUNCT_LH            3'b001
`define FUNCT_LW            3'b010
`define FUNCT_LBU           3'b100
`define FUNCT_LHU           3'b101
//store
`define FUNCT_SB            3'b000
`define FUNCT_SH            3'b001
`define FUNCT_SW            3'b010














