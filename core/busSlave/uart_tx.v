module uart_tx(
    input wire clk              ,
    input wire rst_n            ,
    input wire tx_en            ,
    output reg uart_tx          ,
    input wire uart_tick        ,
    input wire [7:0] tx_data    ,
    output reg tx_done           
);

localparam IDLE = 0,
            START = 1,
            DATA = 2,
            STOP = 3;

reg [1:0] state     ;         // 当前状态
reg [3:0] bit_count ;     // 已接收的比特数
reg [7:0] _tx_data  ;     // 位移寄存器，用于存储接收到的比特

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE   ;
        uart_tx <= 1'b1 ;
        tx_done <= 0    ;
    end else begin
        case (state)
            IDLE: begin
                uart_tx <= 1'b1 ;
                state <= IDLE   ; 
                tx_done <= 0    ;
                if(tx_en && uart_tick) begin
                    state <= DATA       ; 
                    _tx_data <= tx_data ;
                    uart_tx <= 1'b0     ;
                    bit_count <= 4'd0   ;
                end
            end
            DATA: begin
                if (uart_tick) begin
                    state <= DATA;
                    uart_tx <= _tx_data[0] ;
                    _tx_data <= {1'b0, _tx_data[7:1]};
                    bit_count <= bit_count + 4'd1   ;
                    if(bit_count == 4'd7) begin
                        state <= STOP; // 数据位接收完成，进入停止位状态
                    end
                end
            end
            STOP: begin
                tx_done <= 1    ;
                if (uart_tick) begin
                    state <= IDLE; // 检测到停止位，返回空闲状态
                end
            end
        endcase
    end
end

endmodule