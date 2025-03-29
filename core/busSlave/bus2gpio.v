module bus2gpio(
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
    output reg  [31:0]  slave_rdata ,
    
    // GPIO 物理接口
    input  wire [31:0]  gpio_in     ,
    output wire [31:0]  gpio_out    ,
    output wire [31:0]  gpio_dir     // 0=input, 1=output

);

localparam GPIO_DATA_REG   = 32'h0000;  // GPIO 数据寄存器
localparam GPIO_DIR_REG    = 32'h0004;  // 方向控制寄存器
localparam GPIO_SET_REG    = 32'h0008;  // 置位寄存器

reg [31:0] gpio_dir_reg ;  // 方向控制寄存器
reg [31:0] gpio_set_reg ;  // 置位寄存器

assign gpio_dir = gpio_dir_reg  ;
assign gpio_out = gpio_set_reg  ;

always @(posedge clk or negedge rst_n) begin
    slave_valid <= 1'b0 ;
    if(!rst_n) begin
        gpio_dir_reg <= 32'h0;
        gpio_set_reg <= 32'h0;
    end else begin
        if(slave_req) begin
            if(slave_write) begin //write
                case(slave_addr)
                GPIO_DIR_REG:begin
                    gpio_dir_reg <= slave_wdata ;
                end
                GPIO_SET_REG:begin
                    gpio_set_reg <= slave_wdata ;
                end
                endcase
            end else begin //read
                slave_valid <= 1'b1 ;
                case(slave_addr)
                GPIO_DATA_REG:begin
                    slave_rdata <= gpio_in  ;
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