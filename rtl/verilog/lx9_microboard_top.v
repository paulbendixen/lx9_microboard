module lx9_microboard
  #(parameter UART_SIM = 0)
  (input  wb_clk_i,
   input  wb_rst_i,
   input  uart_rx,
   output uart_tx,
   output [3:0] leds);

   localparam wb_aw = 32;
   localparam wb_dw = 32;

   localparam MEM_SIZE_BITS = 9;

   wire 	    wb_clk;
   
   wire wb_rst = wb_rst_i;

   reg [24:0] 	cnt;

   IBUFG wb_clk_bufg(.I(wb_clk_i),
		     .O(wb_clk));

   assign uart_tx = 1'b0;

   ////////////////////////////////////////////////////////////////////////
   //
   // Clock and reset generation
   // 
   ////////////////////////////////////////////////////////////////////////
   

   ////////////////////////////////////////////////////////////////////////
   //
   // Wishbone interconnect
   //
   ////////////////////////////////////////////////////////////////////////
   
   `include "wb_intercon.vh"

   ////////////////////////////////////////////////////////////////////////
   //
   // or1200
   // 
   ////////////////////////////////////////////////////////////////////////
   wire	[15:0]	or1k_dbg_adr = 16'd0;
   wire [31:0] 	or1k_dbg_dat_i = 32'd0;
   wire 	or1k_dbg_stb = 1'b0;
   wire 	or1k_dbg_we = 1'b0;
   wire [31:0] 	or1k_dbg_dat_o;
   wire 	or1k_dbg_ack;
   wire 	or1k_dbg_stall = 1'b0;
   wire 	or1k_dbg_bp;
   
   wire [19:0] 				  or1200_pic_ints;
   mor1kx
     #(.OPTION_CPU0 ("CAPPUCCINO"),
       .FEATURE_DEBUGUNIT ("ENABLED"),
       .FEATURE_INSTRUCTIONCACHE ("ENABLED"),
       .OPTION_ICACHE_SET_WIDTH	(8),
       .OPTION_ICACHE_BLOCK_WIDTH	(5),
       .OPTION_ICACHE_WAYS	(2),
       .OPTION_ICACHE_LIMIT_WIDTH	(32),
       .FEATURE_DATACACHE	("NONE"),
       .OPTION_DCACHE_SET_WIDTH	(8),
       .OPTION_DCACHE_BLOCK_WIDTH	(5),
       .OPTION_DCACHE_WAYS	(2),
       .OPTION_DCACHE_LIMIT_WIDTH	(31),

       .FEATURE_IMMU	("NONE"),
       .FEATURE_DMMU	("NONE"),

       .FEATURE_DSX ("ENABLED"),
       .FEATURE_DIVIDER ("SERIAL"),
       .OPTION_PIC_TRIGGER	("LEVEL"),

       .DBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
       .IBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"))
mor1kx0
       (
	// Core clocks, resets
	.clk				(wb_clk),
	.rst				(wb_rst),
	// Instruction bus
	.iwbm_adr_o			(wb_m2s_or1200_i_adr),
	.iwbm_dat_o			(wb_m2s_or1200_i_dat),
	.iwbm_sel_o			(wb_m2s_or1200_i_sel),
	.iwbm_we_o			(wb_m2s_or1200_i_we ),
	.iwbm_cyc_o			(wb_m2s_or1200_i_cyc),
	.iwbm_stb_o			(wb_m2s_or1200_i_stb),
	.iwbm_cti_o			(wb_m2s_or1200_i_cti),
	.iwbm_bte_o			(wb_m2s_or1200_i_bte),
	.iwbm_dat_i			(wb_s2m_or1200_i_dat),
	.iwbm_ack_i			(wb_s2m_or1200_i_ack),
	.iwbm_err_i			(wb_s2m_or1200_i_err),
	.iwbm_rty_i			(wb_s2m_or1200_i_rty),
	// Data bus
	.dwbm_adr_o			(wb_m2s_or1200_d_adr),
	.dwbm_dat_o			(wb_m2s_or1200_d_dat),
	.dwbm_sel_o			(wb_m2s_or1200_d_sel),
	.dwbm_we_o			(wb_m2s_or1200_d_we),
	.dwbm_cyc_o			(wb_m2s_or1200_d_cyc),
	.dwbm_stb_o			(wb_m2s_or1200_d_stb),
	.dwbm_cti_o			(wb_m2s_or1200_d_cti),
	.dwbm_bte_o			(wb_m2s_or1200_d_bte),
	.dwbm_dat_i			(wb_s2m_or1200_d_dat),
	.dwbm_ack_i			(wb_s2m_or1200_d_ack),
	.dwbm_err_i			(wb_s2m_or1200_d_err),
	.dwbm_rty_i			(wb_s2m_or1200_d_rty),

	.avm_d_address_o (),
	.avm_d_byteenable_o (),
	.avm_d_read_o (),
	.avm_d_readdata_i (32'h00000000),
	.avm_d_burstcount_o (),
	.avm_d_write_o (),
	.avm_d_writedata_o (),
	.avm_d_waitrequest_i (1'b0),
	.avm_d_readdatavalid_i (1'b0),

	.avm_i_address_o (),
	.avm_i_byteenable_o (),
	.avm_i_read_o (),
	.avm_i_readdata_i (32'h00000000),
	.avm_i_burstcount_o (),
	.avm_i_waitrequest_i (1'b0),
	.avm_i_readdatavalid_i (1'b0),
	// Debug interface ports
	.du_addr_i			(or1k_dbg_adr),
	.du_stb_i			(or1k_dbg_stb),
	.du_dat_i			(or1k_dbg_dat_i),
	.du_we_i			(or1k_dbg_we),
	.du_dat_o			(or1k_dbg_dat_o),
	.du_ack_o			(or1k_dbg_ack),
	.du_stall_i			(or1k_dbg_stall),
	.du_stall_o			(),

	// Interrupts      
	.irq_i			({12'd0,or1200_pic_ints}));

   ////////////////////////////////////////////////////////////////////////
   //
   // Generic main RAM
   // 
   ////////////////////////////////////////////////////////////////////////
   wb_ram
     #(.depth (2**MEM_SIZE_BITS),
       .memfile ("../src/lx9_microboard/sw/led_blink.vh"))
   wb_ram0
     (
      //Wishbone Master interface
      .wb_clk_i (wb_clk),
      .wb_rst_i (wb_rst),
      .wb_adr_i	(wb_m2s_mem_adr[MEM_SIZE_BITS-1:0]),
      .wb_dat_i	(wb_m2s_mem_dat),
      .wb_sel_i	(wb_m2s_mem_sel),
      .wb_we_i	(wb_m2s_mem_we),
      .wb_cyc_i	(wb_m2s_mem_cyc),
      .wb_stb_i	(wb_m2s_mem_stb),
      .wb_cti_i	(wb_m2s_mem_cti),
      .wb_bte_i	(wb_m2s_mem_bte),
      .wb_dat_o	(wb_s2m_mem_dat),
      .wb_ack_o	(wb_s2m_mem_ack),
      .wb_err_o (wb_s2m_mem_err));

   assign wb_s2m_mem_rty = 1'b0;
 
////////////////////////////////////////////////////////////////////////
//
// GPIO 0
//
////////////////////////////////////////////////////////////////////////

wire [7:0]	gpio0_in;
wire [7:0]	gpio0_out;
wire [7:0]	gpio0_dir;

   // Tristate logic for IO
   // 0 = input, 1 = output
/*genvar                    i;
generate
	for (i = 0; i < 8; i = i+1) begin: gpio0_tris
		assign gpio0_io[i] = gpio0_dir[i] ? gpio0_out[i] : 1'bz;
		assign gpio0_in[i] = gpio0_dir[i] ? gpio0_out[i] : gpio0_io[i];
	end
endgenerate
*/
gpio gpio0 (
	// GPIO bus
	.gpio_i		(gpio0_in),
	.gpio_o		(gpio0_out),
	.gpio_dir_o	(gpio0_dir),
	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_gpio_adr[0]),
	.wb_dat_i	(wb_m2s_gpio_dat),
	.wb_we_i	(wb_m2s_gpio_we),
	.wb_cyc_i	(wb_m2s_gpio_cyc),
	.wb_stb_i	(wb_m2s_gpio_stb),
	.wb_cti_i	(wb_m2s_gpio_cti),
	.wb_bte_i	(wb_m2s_gpio_bte),
	.wb_dat_o	(wb_s2m_gpio_dat),
	.wb_ack_o	(wb_s2m_gpio_ack),
	.wb_err_o	(wb_s2m_gpio_err),
	.wb_rty_o	(wb_s2m_gpio_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst));

   assign leds[3:0] = gpio0_out[3:0];
/*
   wire 	dbg_capture;
   wire 	dbg_sel;
   wire 	dbg_shift;
   wire 	dbg_tck;
   wire 	dbg_tdi;
   wire 	dbg_tms;
   wire 	dbg_update;
   wire 	dbg_tdo;

   // BSCAN_SPARTAN6: Spartan-6 JTAG Boundary-Scan Logic Access
   //   Spartan-6
   // Xilinx HDL Language Template, version 11.1
   BSCAN_SPARTAN6
     #(.JTAG_CHAIN(1))
   BSCAN_SPARTAN6_inst
     (.CAPTURE (dbg_capture),
      .DRCK    (),
      // the CAPTUREDR and SHIFTDR states.
      .RESET   (),
      .RUNTEST (),

      .SEL     (dbg_sel),
      .SHIFT   (dbg_shift),
      .TCK     (dbg_tck),
      .TDI     (dbg_tdi),
      .TMS     (dbg_tms),
      .UPDATE  (dbg_update),
      .TDO     (dbg_tdo));

   adbg_top dbg_if0
     (// OR1K interface
      .cpu0_clk_i	(wb_clk),
      .cpu0_rst_o	(or1k_rst),
      .cpu0_addr_o	(or1k_dbg_adr),
      .cpu0_data_o	(or1k_dbg_dat_i),
      .cpu0_stb_o	(or1k_dbg_stb_i),
      .cpu0_we_o	(or1k_dbg_we_i),
      .cpu0_data_i	(or1k_dbg_dat_o),
      .cpu0_ack_i	(or1k_dbg_ack_o),
      .cpu0_stall_o	(or1k_dbg_stall_i),
      .cpu0_bp_i	(or1k_dbg_bp_o),

      // TAP interface
      .tck_i	(dbg_tck),
      .tdi_i	(dbg_tdi),
      .tdo_o	(dbg_tdo),
      .rst_i	(wb_rst),
      .capture_dr_i	(dbg_capture),
      .shift_dr_i	(dbg_shift),
      .pause_dr_i	(dbg_pause),
      .update_dr_i	(dbg_update),
      .debug_select_i	(dbg_sel),

      // Wishbone debug master
      .wb_rst_i	(wb_rst),
      .wb_clk_i	(wb_clk),
      .wb_dat_i	(wb_s2m_dbg_dat),
      .wb_ack_i	(wb_s2m_dbg_ack),
      .wb_err_i	(wb_s2m_dbg_err),
      
      .wb_adr_o	(wb_m2s_dbg_adr),
      .wb_dat_o	(wb_m2s_dbg_dat),
      .wb_cyc_o	(wb_m2s_dbg_cyc),
      .wb_stb_o	(wb_m2s_dbg_stb),
      .wb_sel_o	(wb_m2s_dbg_sel),
      .wb_we_o	(wb_m2s_dbg_we),
      .wb_cti_o	(wb_m2s_dbg_cti),
      .wb_bte_o	(wb_m2s_dbg_bte));
*/   
   ////////////////////////////////////////////////////////////////////////
   //
   // OR1200 Interrupt assignment
   // 
   ////////////////////////////////////////////////////////////////////////
   assign or1200_pic_ints[0] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[1] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[2] = 0;
   assign or1200_pic_ints[3] = 0;
   assign or1200_pic_ints[4] = 0;
   assign or1200_pic_ints[5] = 0;
   assign or1200_pic_ints[6] = 0;
   assign or1200_pic_ints[7] = 0;
   assign or1200_pic_ints[8] = 0;
   assign or1200_pic_ints[9] = 0;
   assign or1200_pic_ints[10] = 0;
   assign or1200_pic_ints[11] = 0;
   assign or1200_pic_ints[12] = 0;
   assign or1200_pic_ints[13] = 0;
   assign or1200_pic_ints[14] = 0;
   assign or1200_pic_ints[15] = 0;
   assign or1200_pic_ints[16] = 0;
   assign or1200_pic_ints[17] = 0;
   assign or1200_pic_ints[18] = 0;
   assign or1200_pic_ints[19] = 0;
   
endmodule
