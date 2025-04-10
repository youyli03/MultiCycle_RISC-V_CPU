module bus2tim(
    // 系统信号
    input wire          clk         ,
    input wire          rst_n       ,
    
    // Memory 接口
    input  wire         slave_req   ,
    input  wire         slave_write ,
    output reg          slave_valid ,
    output reg          slave_ready ,
    input  wire [31:0]  slave_addr  ,
    input  wire [31:0]  slave_wdata ,
    output reg  [31:0]  slave_rdata 

);

localparam  TIM_CTRL_REG    = 32'h0000;  // 启动/自动重装/清零溢出次数
localparam  TIM_CNT_REG     = 32'h0004;  // 分频
localparam  TIM_VAL_REG     = 32'h0008;  // 读数/设置计数
localparam  TIM_OVERCNT_REG = 32'h000c;  // 溢出次数

reg         tim_en = 0,tim_autoload = 0 ;
reg  [31:0] __tim_cnt   ;      // 计数
reg  [31:0] tim_cnt_reg ;      // 计数寄存器
reg  [31:0] tim_overcnt_reg ;   // 溢出寄存器

always @(posedge clk or negedge rst_n) begin
    slave_valid <= 1'b0 ;
    if(!rst_n) begin
        tim_en  <= 1'b0 ;
        tim_autoload <= 1'b0;
        __tim_cnt       <= 32'b0 ;
        tim_cnt_reg     <= 32'b0 ;
        tim_overcnt_reg <= 32'b0 ;
    end else begin
        if(tim_en)begin
            __tim_cnt <= __tim_cnt + 32'b1  ;
            if(__tim_cnt >= tim_cnt_reg)begin
                if(tim_autoload)
                    __tim_cnt       <= 32'b0 ;
                else
                    __tim_cnt <= __tim_cnt  ;
                tim_overcnt_reg <= tim_overcnt_reg + 32'b1  ;
            end
        end
        if(slave_req) begin
            if(slave_write) begin //write
                case(slave_addr)
                TIM_CTRL_REG:begin
                    tim_en <= slave_wdata[0] ;
                    tim_autoload <= slave_wdata[1] ;
                    if(slave_wdata[2])
                        tim_overcnt_reg <= 32'b0 ;
                end
                TIM_CNT_REG:begin
                    tim_cnt_reg <= slave_wdata  ;
                end
                TIM_VAL_REG:begin
                    __tim_cnt   <= slave_wdata  ;
                end
                TIM_OVERCNT_REG:begin
                    tim_overcnt_reg <= slave_wdata  ;
                end
                endcase
            end else begin //read
                slave_valid <= 1'b1 ;
                case(slave_addr)
                TIM_VAL_REG:begin
                    slave_rdata <= __tim_cnt    ;
                end
                TIM_OVERCNT_REG:begin
                    slave_rdata <= tim_overcnt_reg  ;
                end
                default:begin
                    slave_rdata <= 32'h0    ;
                end
                endcase
            end
        end
    end
end


endmodule