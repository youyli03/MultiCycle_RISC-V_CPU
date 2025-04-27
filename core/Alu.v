`include "InstrDef.vh"

module Alu (
    input  wire     clk,

    // input  wire         RItype      ,
    // input  wire         Rtype       ,
    input  wire         PChandler   ,
    input  wire [2:0]   funct       ,
    input  wire         instr_30    ,
    // input  wire         Btype       ,

    input  wire         exe_status  ,
    output wire         alu_down    ,
    input  wire [2:0]   type       ,
    // input  wire         JSLtype     ,   // add req

    input  wire [31:0]  in1         ,
    input  wire [31:0]  in2         ,
    output wire [31:0]  out         


);

wire RItype = type[2] & ~type[1];
wire Rtype  = RItype & type[0]  ;
wire Btype  = type == `TYPE_BTYPE    ;
// wire otherType = ~(RItype | Btype ) ;

//在ALU内实现对Btype的FUNCT的解码，因为Btype在跳转只需在写回处知道是否要跳转
wire add_req = (funct == 3'b000)       ;    // add sub
wire and_req = (funct == 3'b111)       ;    // and
wire or_req  = (funct == 3'b110)       ;    // or
wire xor_req = (funct == 3'b100)       ;    // xor
wire slx_req = (funct[2:1] == 2'b01)   ;    // slt sltu
wire sft_req = (funct[1:0] == 2'b01)   ;    // sll srl sra

//加法器、减法器 同时扩展位宽复用减法器充当比较器
//多个位宽防止溢出
wire [32:0] adder_in1   ;
wire [32:0] adder_in2   ;

//使用funct[2] & funct[0]而不是funct == 3'b101 || funct == 3'b111进行解码
wire Btype_ne = ~(funct[2] | funct[1])     ;
wire Btype_gelt = ~Btype_ne;
wire Btype_res_reverse = funct[0];

//unsigned时扩展位为0
// wire in_unsign_flag_sltu = RItype && (funct == 3'b011)   ;
// wire in_unsign_flag_b = Btype && (funct[2:1] == 2'b11)      ;
wire in_unsign_flag_sltu = RItype & slx_req & funct[0]  ;
wire in_unsign_flag_b = Btype & funct[2] & funct[1]     ;
wire in_unsign_flag = in_unsign_flag_sltu | in_unsign_flag_b    ;

assign adder_in1[31:0] = in1    ;
assign adder_in2[31:0] = in2    ;
assign adder_in1[32] = in_unsign_flag ? 1'b0 : in1[31]  ;
assign adder_in2[32] = in_unsign_flag ? 1'b0 : in2[31]  ;

wire rglrAlu_sub_req = (add_req & instr_30)  ; //slt sltu  rs1 < rs2 -> 1
wire Btype_sub_req = funct[2]   ;
wire sub_req = PChandler ? 'b0 : ( Rtype & rglrAlu_sub_req ) | (Btype & Btype_sub_req) | (slx_req & RItype)  ; 

//可以考虑使用异或或者同或门进行代替
wire [32:0] _adder_in2 = (sub_req)? ~adder_in2 : adder_in2    ;    //减法时in2取反
wire [32:0] addsub_res = adder_in1 + _adder_in2 + sub_req   ;

wire sltx_flag = addsub_res[32] ;
wire sltx_res = sltx_flag ? 32'b1 : 32'b0   ;

wire [31:0] and_res = in1 & in2    ;
wire [31:0] or_res  = in1 | in2    ;
wire [31:0] xor_res = in1 ^ in2    ;
wire neq  = (|xor_res)      ; 

wire shifter_Ari = instr_30 ;
wire shifter_r = funct[2] ;
wire [31:0] shifter_in1 = shifter_r ? 
    {   in1[00],in1[01],in1[02],in1[03],
        in1[04],in1[05],in1[06],in1[07],
        in1[08],in1[09],in1[10],in1[11],
        in1[12],in1[13],in1[14],in1[15],
        in1[16],in1[17],in1[18],in1[19],
        in1[20],in1[21],in1[22],in1[23],
        in1[24],in1[25],in1[26],in1[27],
        in1[28],in1[29],in1[30],in1[31] } : in1     ;
wire [4:0]  shifter_in2 = in2[4:0]  ;

reg  shifter_down   ;
reg  _shifter_down  ;
reg  _exe_status    ;
reg  [4:0]  shifter_cnt ;
reg  [31:0] _sres_reg   ;
reg  [31:0] shifter_Ari_mask_reg    ;
always@(posedge clk)begin
    shifter_down <= 1'b0    ;
    _exe_status <= exe_status   ;
    if(exe_status & ~_exe_status) begin
        shifter_cnt <= 5'b0 ;
        _sres_reg <= shifter_in1 ;
        shifter_Ari_mask_reg <= 32'hffffffff ;
        if(sft_req)
            _shifter_down <= 1'b1   ;
        else
            _shifter_down <= 1'b0   ;
    end
    else begin
        if(!shifter_down) begin
            shifter_Ari_mask_reg <= shifter_Ari_mask_reg >> 1  ;
            _sres_reg <= _sres_reg << 1 ;
        end

        if(shifter_down)
            _shifter_down <= 1'b0   ;

        if(shifter_cnt + 5'b1 >= shifter_in2 && _shifter_down)
            shifter_down <= 1'b1    ;
        else
            shifter_cnt <= shifter_cnt + 5'b1   ;
    end
end

assign alu_down = (sft_req & RItype) ? shifter_down : 1'b1;

// wire [31:0] _sres = (shifter_in1 << shifter_in2)    ;
// wire [31:0] shifter_Ari_mask = 32'hffffffff >> shifter_in2  ;
wire [31:0] _sres = _sres_reg   ;
wire [31:0] shifter_Ari_mask = shifter_Ari_mask_reg ;
wire [31:0] shifter_res = shifter_r ? 
    {   _sres[00],_sres[01],_sres[02],_sres[03],
        _sres[04],_sres[05],_sres[06],_sres[07],
        _sres[08],_sres[09],_sres[10],_sres[11],
        _sres[12],_sres[13],_sres[14],_sres[15],
        _sres[16],_sres[17],_sres[18],_sres[19],
        _sres[20],_sres[21],_sres[22],_sres[23],
        _sres[24],_sres[25],_sres[26],_sres[27],
        _sres[28],_sres[29],_sres[30],_sres[31] } : _sres   ;
wire [31:0] shifter_Ari_res = (shifter_res & shifter_Ari_mask) | ({32{in1[31]}} & (~shifter_Ari_mask));

//可以考虑使用异或或者同或门进行代替
wire _Btype_res = (~neq & Btype_ne) | (addsub_res[32] & Btype_gelt);
wire Btype_res = Btype_res_reverse ? ~_Btype_res : _Btype_res;

// wire neq  = (xor_res != 32'b0); 

// wire [31:0] __shifter_res = ( {32{shifter_Ari}} & shifter_Ari_res ) |
//                         ( {32{~shifter_Ari}} & shifter_res ) ;
// wire [31:0] RItype_res = ({32{add_req}} & addsub_res[31:0]) |
//                         ({32{sft_req}} & __shifter_res) |
//                         ({32{slx_req}} & sltx_res) |
//                         ({32{xor_req}} & xor_res ) |
//                         ({32{or_req} } & or_res  ) |
//                         ({32{and_req}} & and_res ) ;

// assign out = ({32{otherType}} & addsub_res[31:0]) |
//             ({32{RItype}} & RItype_res ) |
//             ({32{Btype}} & Btype_res) ;

assign out = PChandler ? addsub_res[31:0] :
             RItype ?
             (
                 add_req ? addsub_res[31:0] :
                 sft_req ? (shifter_Ari ? shifter_Ari_res : shifter_res) :
                 slx_req ? sltx_res :
                 xor_req ? xor_res :
                 or_req  ? or_res :
                 and_res
             ):
             Btype ? Btype_res :
             addsub_res[31:0]    ;

// assign out = 32{RItype}& (
//                 32{add_req} & addsub_res[31:0] |
//                 32{sft_req} & (shifter_Ari ? shifter_Ari_res : shifter_res) |
//                 32{slx_req} & sltx_res |
//                 32{xor_req} & xor_res |
//                 32{or_req } & or_res |
//                 32{and_req} & and_res
//             )|
//             (32{Btype} & Btype_res) |
//             (32{add_req} & addsub_res[31:0])    ;


endmodule
