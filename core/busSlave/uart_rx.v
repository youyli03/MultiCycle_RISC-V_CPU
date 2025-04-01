module uart_rx(
    input wire clk          ,       // 时钟信号
    input wire rst_n        ,       // 异步复位信号
    input wire uart_rx      ,       // UART 接收信号
    input wire uart_tick    ,       // 波特率时钟信号
    output reg [7:0] rx_data,       // 接收到的数据
    output reg rx_done              // 数据接收完成标志
);

    // UART 接收状态机状态
    localparam IDLE = 0,
               START = 1,
               DATA = 2,
               STOP = 3;

    reg [1:0] state;         // 当前状态
    reg [3:0] bit_count;     // 已接收的比特数
    reg [7:0] shift_reg;     // 位移寄存器，用于存储接收到的比特

    // UART 接收状态机
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            bit_count <= 0;
            shift_reg <= 0;
            rx_data <= 0;
            rx_done <= 0;
        end else begin
            rx_done <= 0;
            case (state)
                IDLE: begin
                    if (uart_tick && uart_rx == 0) begin
                        state <= DATA; // 检测到起始位
                        bit_count <= 0;
                        shift_reg <= 0;
                    end
                end
                DATA: begin
                    if (uart_tick) begin
                        shift_reg <= {uart_rx, shift_reg[7:1]}; // 将接收到的比特移入移位寄存器
                        bit_count <= bit_count + 1;
                        if (bit_count == 4'd7) begin
                            state <= STOP; // 数据位接收完成，进入停止位状态
                        end
                    end
                end
                STOP: begin
                    rx_data <= shift_reg; // 输出接收到的数据
                    if (uart_tick) begin
                        if (uart_rx == 1) begin
                            state <= IDLE; // 检测到停止位，返回空闲状态
                            rx_done <= 1; // 设置接收完成标志
                        end
                    end
                end
            endcase
        end
    end

endmodule