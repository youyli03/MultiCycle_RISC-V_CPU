module RegFile (
    input         clk       ,
    input [4:0]   rs1       ,   //32位指令的源操作数1索引 
    // input [4:0]   rs2       ,   //32位指令的源操作数2索引
    input [4:0]   rd        ,   //32位指令的结果操作数索引
    input [31:0]  i_data    ,   //写回寄存器的数据
    input         wr_en     ,   //写入通用寄存器控制信号  1：写入  RegfileWr
    output reg [31:0] rd1       //从寄存器读取的第一个数
    // output reg [31:0] rd2       //从寄存器读取的第二个数
    
    );

    //双端口读占用 64 Slice Registers
    //单端口读 32 Slice Registers
    (*ram_style="distributed"*) reg [31:0] rf[31:0]; //32个32位通用寄存器
    
    integer  i;
    initial
    begin
        for(i = 0; i < 32; i = i+1)
            rf[i] = 0;
    end
    
    always @ (posedge clk)
    begin
        rd1 <= rf[rs1];
        // rd2 <= rf[rs2];
        if(wr_en)
            rf[rd] <= i_data;
        // rf[0] <= 0  ;
    end
    

endmodule