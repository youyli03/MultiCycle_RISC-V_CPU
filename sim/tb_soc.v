`include "InstrDef.vh"

module tb_soc( );

reg  clk = 1;
reg  rst = 0;
always #1 clk = ~clk;

initial begin
    #10
    rst <= 1 ;
end

SOC_TOP SOC_TOP0(
    .clk        (clk        ),
    .rst_n      (rst        ),
    .gpio_in    (32'h0f00   )
);


endmodule
