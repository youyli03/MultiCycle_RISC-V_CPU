module SOC_TOP(
    input         clk       ,
    input         rst_n     ,

    output wire         uart_tx ,
    input  wire         uart_rx ,

    input  wire [31:0]  gpio_in     ,
    output wire [31:0]  gpio_out    ,
    output wire [31:0]  gpio_dir     // 0=input, 1=output
);

wire         master_req     ;
wire         master_write   ;
wire         master_valid   ;
wire         master_ready   ;
wire [31:0]  master_addr    ;
wire [31:0]  master_wdata   ;
wire [31:0]  master_rdata   ;
wire [3:0]   master_mask    ;
wire         slave_0_req    ;
wire         slave_0_write  ;
wire         slave_0_valid  ;
wire         slave_0_ready  ;
wire [31:0]  slave_0_addr   ;
wire [31:0]  slave_0_wdata  ;
wire [31:0]  slave_0_rdata  ;
wire [3:0]   slave_0_mask   ;
wire         slave_1_req    ;
wire         slave_1_write  ;
wire         slave_1_valid  ;
wire         slave_1_ready  ;
wire [31:0]  slave_1_addr   ;
wire [31:0]  slave_1_wdata  ;
wire [31:0]  slave_1_rdata  ;
wire         slave_2_req    ;
wire         slave_2_write  ;
wire         slave_2_valid  ;
wire         slave_2_ready  ;
wire [31:0]  slave_2_addr   ;
wire [31:0]  slave_2_wdata  ;
wire [31:0]  slave_2_rdata  ;
wire         slave_3_req    ;
wire         slave_3_write  ;
wire         slave_3_valid  ;
wire         slave_3_ready  ;
wire [31:0]  slave_3_addr   ;
wire [31:0]  slave_3_wdata  ;
wire [31:0]  slave_3_rdata  ;

(* DONT_TOUCH = "true" *) RiscvTop RiscvTop0(
    .clk       (clk		),
    .rst_n     (rst_n	),
    
	.mem_req   (master_req      ),
	.mem_write (master_write    ),
	.mem_valid (master_valid    ),
	.mem_ready (master_ready    ),
	.mem_addr  (master_addr     ),
	.mem_wdata (master_wdata    ),
	.mem_rdata (master_rdata    ),
	.mem_mask  (master_mask     )
);

bus bus0(
    .master_req     (master_req     ),
	.master_write   (master_write   ),
	.master_valid   (master_valid   ),
	.master_ready   (master_ready   ),
    .master_addr    (master_addr    ),
    .master_wdata   (master_wdata   ),
    .master_rdata   (master_rdata   ),
	.master_mask    (master_mask    ),

	.slave_0_req    (slave_0_req    ),
	.slave_0_write  (slave_0_write  ),
	.slave_0_valid  (slave_0_valid  ),
	.slave_0_ready  (slave_0_ready  ),
	.slave_0_addr   (slave_0_addr   ),
	.slave_0_wdata  (slave_0_wdata  ),
	.slave_0_rdata  (slave_0_rdata  ),
	.slave_0_mask   (slave_0_mask   ),

	.slave_1_req    (slave_1_req    ),
	.slave_1_write  (slave_1_write  ),
	.slave_1_valid  (slave_1_valid  ),
	.slave_1_ready  (slave_1_ready  ),
	.slave_1_addr   (slave_1_addr   ),
	.slave_1_wdata  (slave_1_wdata  ),
	.slave_1_rdata  (slave_1_rdata  ),

	.slave_2_req    (slave_2_req    ),
	.slave_2_write  (slave_2_write  ),
	.slave_2_valid  (slave_2_valid  ),
	.slave_2_ready  (slave_2_ready  ),
	.slave_2_addr   (slave_2_addr   ),
	.slave_2_wdata  (slave_2_wdata  ),
	.slave_2_rdata  (slave_2_rdata  ),

	.slave_3_req    (slave_3_req    ),
	.slave_3_write  (slave_3_write  ),
	.slave_3_valid  (slave_3_valid  ),
	.slave_3_ready  (slave_3_ready  ),
	.slave_3_addr   (slave_3_addr   ),
	.slave_3_wdata  (slave_3_wdata  ),
	.slave_3_rdata  (slave_3_rdata  )
);

bus2mem mem0(
    .clk       (clk		),
    .rst_n     (rst_n	),
    
    // Memory 接口
    .slave_req  	(slave_0_req    ),
    .slave_write	(slave_0_write  ),
    .slave_valid	(slave_0_valid  ),
    .slave_ready	(slave_0_ready  ),
    .slave_addr 	(slave_0_addr   ),
    .slave_wdata	(slave_0_wdata  ),
    .slave_rdata	(slave_0_rdata  ),
    .slave_mask 	(slave_0_mask   )

);

bus2gpio gpio0(
    .clk       (clk		),
    .rst_n     (rst_n	),
    
    // Memory 接口
    .slave_req   	(slave_1_req    ),
    .slave_write 	(slave_1_write  ),
    .slave_valid 	(slave_1_valid  ),
    .slave_ready 	(slave_1_ready  ),
    .slave_addr  	(slave_1_addr   ),
    .slave_wdata 	(slave_1_wdata  ),
    .slave_rdata 	(slave_1_rdata  ),
    
    // GPIO 物理接口
    .gpio_in 		(gpio_in 	),
    .gpio_out		(gpio_out	),
    .gpio_dir		(gpio_dir	) // 0=input, 1=output
);

bus2uart uart0(
    .clk       (clk		),
    .rst_n     (rst_n	),
    
    // Memory 接口
    .slave_req   	(slave_2_req    ),
    .slave_write 	(slave_2_write  ),
    .slave_valid 	(slave_2_valid  ),
    .slave_ready 	(slave_2_ready  ),
    .slave_addr  	(slave_2_addr   ),
    .slave_wdata 	(slave_2_wdata  ),
    .slave_rdata 	(slave_2_rdata  ),

    .uart_rx		(uart_rx    ),
    .uart_tx		(uart_tx    )

);


endmodule