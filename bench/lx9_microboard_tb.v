module lx9_microboard_tb;

reg clk   = 0;
reg rst_n = 0;

always
	#5 clk <= ~clk;

initial begin
	#100 rst_n <= 1;
	#200 rst_n <= 0;
end

vlog_tb_utils vlog_tb_utils0();

integer mem_words;
integer i;
reg [31:0] mem_word;
reg [1023:0] elf_file;

   /*initial begin
      if($value$plusargs("elf_load=%s", elf_file)) begin
	 $elf_load_file(elf_file);
	 
	 mem_words = $elf_get_size/4;
	 for(i=0; i < mem_words; i = i+1)
	   lx9_microboard_tb.dut.wb_ram0.ram0.mem[i] = $elf_read_32(i*4);
      end else
	$display("No ELF file specified");
   end*/

/*reg enable_jtag_vpi;
initial enable_jtag_vpi = $test$plusargs("enable_jtag_vpi");

jtag_vpi jtag_vpi0
(
	.tms		(tms),
	.tck		(tck),
	.tdi		(tdi),
	.tdo		(tdo),
	.enable		(enable_jtag_vpi),
	.init_done	(orpsoc_tb.dut.wb_rst));
*/
lx9_microboard dut
(
	.wb_clk_i		(clk),
	.wb_rst_i		(rst_n),
	//JTAG interface
 /*.tms_pad_i		(tms),
	.tck_pad_i		(tck),
	.tdi_pad_i		(tdi),
	.tdo_pad_o		(tdo),*/
	//UART interface
	.uart_rx	(uart),
	.uart_tx	(uart),
 .leds ()
);

mor1kx_monitor
  #(.LOG_DIR("."))
   i_monitor();

//FIXME: Get correct baud rate from parameter
/*uart_decoder
	#(.uart_baudrate_period_ns(8680/2))
uart_decoder0
(
	.clk(clk),
	.uart_tx(uart)
);*/

endmodule
