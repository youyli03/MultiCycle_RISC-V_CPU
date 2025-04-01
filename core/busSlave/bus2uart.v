module bus2uart(
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

    input  wire         uart_rx     ,
    output wire         uart_tx     

);

localparam UART_STATUS  = 12'h000;  // UART 状态寄存器
localparam UART_DATA    = 12'h004;  // UART 读写寄存器  后8位
localparam UART_BAUD    = 12'h008;  // UART 波特率寄存器

reg  [31:0] uart_reg_baud   ;
wire [31:0] uart_reg_status ;

wire        uart_tick   ;
reg         _uart_tick_clk  ;
reg  [31:0] _uart_tick_clk_cnt  ;
assign  uart_tick = _uart_tick_clk  ;

reg  [7:0]  rx_buf [31:0];
reg  [7:0]  tx_buf [31:0];

reg  [4:0]  rx_head ;
reg  [4:0]  rx_tail ;
reg  [4:0]  tx_head ;
reg  [4:0]  tx_tail ;

wire        uart_status_rx_isFull   = ((rx_head + 5'b1) == rx_tail)?1'b1:1'b0   ;
wire        uart_status_rx_isEmpty  = (rx_head == rx_tail)?1'b1:1'b0            ;
wire        uart_status_tx_isFull   = ((tx_head + 5'b1) == tx_tail)?1'b1:1'b0   ;
wire        uart_status_tx_isEmpty  = (tx_head == tx_tail)?1'b1:1'b0            ;
assign      uart_reg_status = {28'b0,
                    uart_status_rx_isFull, uart_status_rx_isEmpty,
                    uart_status_tx_isFull, uart_status_tx_isEmpty   };

wire [7:0]  rx_data ;
wire        rx_done ;
reg         tx_en   ;
reg  [7:0]  tx_data ;
wire        tx_done ;

always @(posedge clk or negedge rst_n) begin
    slave_valid <= 1'b0 ;
    if(!rst_n) begin
        uart_reg_baud <= 32'd2;
        rx_tail <= 0;
        tx_head <= 0;
    end else begin
        if(slave_req) begin
            if(slave_write) begin //write
                case(slave_addr)
                UART_DATA:begin
                    tx_buf[tx_head] <= slave_wdata[7:0] ;
                    tx_head <= tx_head + 5'b1 ;
                end
                UART_BAUD:begin
                    uart_reg_baud <= slave_wdata ;
                end
                endcase
            end else begin //read
                slave_valid <= 1'b1 ;
                case(slave_addr)
                UART_STATUS:begin
                    slave_rdata <= uart_reg_status  ;
                end
                UART_DATA:begin
                    if(rx_tail == rx_head) begin
                        slave_rdata <= 32'h0    ;
                    end else begin
                        slave_rdata <= {24'b0, rx_buf[rx_tail]};
                        rx_tail <= rx_tail + 5'b1 ;
                    end
                end
                default:begin
                    slave_rdata <= 32'h0    ;
                end
                endcase
            end
        end
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        _uart_tick_clk_cnt <= 32'b0;
        _uart_tick_clk <= 1'b1;
    end else begin
        if(_uart_tick_clk_cnt >= uart_reg_baud ) begin
            _uart_tick_clk_cnt <= 32'b0 ;
            _uart_tick_clk <= ~_uart_tick_clk   ;
        end else
            _uart_tick_clk_cnt <= _uart_tick_clk_cnt + 32'b1;
        if(_uart_tick_clk_cnt  == 32'b0)
            _uart_tick_clk <= ~_uart_tick_clk   ;
    end
end

uart_rx uart_rx0(
    .clk        (clk        ),       // 时钟信号
    .rst_n      (rst_n      ),       // 异步复位信号
    .uart_rx    (uart_rx    ),       // UART 接收信号
    .uart_tick  (uart_tick  ),       // 波特率时钟信号
    .rx_data    (rx_data    ),       // 接收到的数据
    .rx_done    (rx_done    )        // 数据接收完成标志
);

uart_tx uart_tx0(
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .tx_en      (tx_en      ),
    .uart_tx    (uart_tx    ),
    .uart_tick  (uart_tick  ),
    .tx_data    (tx_data    ),
    .tx_done    (tx_done    )       
);

always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        tx_tail <= 0;
        tx_en   <= 0;
    end else begin
            if(tx_tail != tx_head && !tx_en) begin
                tx_data <= tx_buf[tx_tail]  ;
                tx_en   <= 1'b1 ;
            end
        if(uart_tick) begin
            if(tx_done) begin
                rx_buf[rx_head] <= rx_data;
                tx_tail <= tx_tail + 5'b1 ;
                tx_en   <= 1'b0 ;
            end
        end
    end
end

always @(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        rx_head <= 0;
    end else begin
        if(rx_done) begin
            rx_buf[rx_head] <= rx_data;
            rx_head <= rx_head + 5'b1 ;
        end
    end
end

endmodule