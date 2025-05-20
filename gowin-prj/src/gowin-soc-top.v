module GW_SOC_TOP(
    input         clk       ,
    input         rst_n     ,

    output wire         uart_tx ,
    input  wire         uart_rx ,

    inout       [31:0]  gpio    
);

wire    rpll_clk    ;
wire    rpll_down   ;

wire [31:0]  gpio_out   ;
wire [31:0]  gpio_dir   ;

genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin: gpio_bits
        assign gpio[i] = gpio_dir[i] ? gpio_out[i] : 1'bz;
    end
endgenerate

// 读取输入
reg [31:0]  gpio_in     ;
always @(posedge clk) begin
    gpio_in <= gpio     ;
end

SOC_TOP SOC_TOP0(
    .clk        (rpll_clk   ),
    .rst_n      (rpll_down  ),

    .uart_tx    (uart_tx    ),
    .uart_rx    (uart_rx    ),

    .gpio_in    (gpio_in    ),
    .gpio_out   (gpio_out   ),
    .gpio_dir   (gpio_dir   ) // 0=input, 1=output
);

Gowin_rPLL Gowin_rPLL0(
    .clkout     ( rpll_clk  ),
    .lock       ( rpll_down ),
    .reset      ( ~rst_n    ),
    .clkin      ( clk       )
);

endmodule