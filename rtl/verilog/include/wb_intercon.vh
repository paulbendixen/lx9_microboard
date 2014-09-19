wire [31:0] wb_m2s_or1200_d_adr;
wire [31:0] wb_m2s_or1200_d_dat;
wire  [3:0] wb_m2s_or1200_d_sel;
wire        wb_m2s_or1200_d_we;
wire        wb_m2s_or1200_d_cyc;
wire        wb_m2s_or1200_d_stb;
wire  [2:0] wb_m2s_or1200_d_cti;
wire  [1:0] wb_m2s_or1200_d_bte;
wire [31:0] wb_s2m_or1200_d_dat;
wire        wb_s2m_or1200_d_ack;
wire        wb_s2m_or1200_d_err;
wire        wb_s2m_or1200_d_rty;
wire [31:0] wb_m2s_or1200_i_adr;
wire [31:0] wb_m2s_or1200_i_dat;
wire  [3:0] wb_m2s_or1200_i_sel;
wire        wb_m2s_or1200_i_we;
wire        wb_m2s_or1200_i_cyc;
wire        wb_m2s_or1200_i_stb;
wire  [2:0] wb_m2s_or1200_i_cti;
wire  [1:0] wb_m2s_or1200_i_bte;
wire [31:0] wb_s2m_or1200_i_dat;
wire        wb_s2m_or1200_i_ack;
wire        wb_s2m_or1200_i_err;
wire        wb_s2m_or1200_i_rty;
wire [31:0] wb_m2s_dbg_adr;
wire [31:0] wb_m2s_dbg_dat;
wire  [3:0] wb_m2s_dbg_sel;
wire        wb_m2s_dbg_we;
wire        wb_m2s_dbg_cyc;
wire        wb_m2s_dbg_stb;
wire  [2:0] wb_m2s_dbg_cti;
wire  [1:0] wb_m2s_dbg_bte;
wire [31:0] wb_s2m_dbg_dat;
wire        wb_s2m_dbg_ack;
wire        wb_s2m_dbg_err;
wire        wb_s2m_dbg_rty;
wire [31:0] wb_m2s_gpio_adr;
wire  [7:0] wb_m2s_gpio_dat;
wire  [3:0] wb_m2s_gpio_sel;
wire        wb_m2s_gpio_we;
wire        wb_m2s_gpio_cyc;
wire        wb_m2s_gpio_stb;
wire  [2:0] wb_m2s_gpio_cti;
wire  [1:0] wb_m2s_gpio_bte;
wire  [7:0] wb_s2m_gpio_dat;
wire        wb_s2m_gpio_ack;
wire        wb_s2m_gpio_err;
wire        wb_s2m_gpio_rty;
wire [31:0] wb_m2s_mem_adr;
wire [31:0] wb_m2s_mem_dat;
wire  [3:0] wb_m2s_mem_sel;
wire        wb_m2s_mem_we;
wire        wb_m2s_mem_cyc;
wire        wb_m2s_mem_stb;
wire  [2:0] wb_m2s_mem_cti;
wire  [1:0] wb_m2s_mem_bte;
wire [31:0] wb_s2m_mem_dat;
wire        wb_s2m_mem_ack;
wire        wb_s2m_mem_err;
wire        wb_s2m_mem_rty;

wb_intercon wb_intercon0
   (.wb_clk_i          (wb_clk),
    .wb_rst_i          (wb_rst),
    .wb_or1200_d_adr_i (wb_m2s_or1200_d_adr),
    .wb_or1200_d_dat_i (wb_m2s_or1200_d_dat),
    .wb_or1200_d_sel_i (wb_m2s_or1200_d_sel),
    .wb_or1200_d_we_i  (wb_m2s_or1200_d_we),
    .wb_or1200_d_cyc_i (wb_m2s_or1200_d_cyc),
    .wb_or1200_d_stb_i (wb_m2s_or1200_d_stb),
    .wb_or1200_d_cti_i (wb_m2s_or1200_d_cti),
    .wb_or1200_d_bte_i (wb_m2s_or1200_d_bte),
    .wb_or1200_d_dat_o (wb_s2m_or1200_d_dat),
    .wb_or1200_d_ack_o (wb_s2m_or1200_d_ack),
    .wb_or1200_d_err_o (wb_s2m_or1200_d_err),
    .wb_or1200_d_rty_o (wb_s2m_or1200_d_rty),
    .wb_or1200_i_adr_i (wb_m2s_or1200_i_adr),
    .wb_or1200_i_dat_i (wb_m2s_or1200_i_dat),
    .wb_or1200_i_sel_i (wb_m2s_or1200_i_sel),
    .wb_or1200_i_we_i  (wb_m2s_or1200_i_we),
    .wb_or1200_i_cyc_i (wb_m2s_or1200_i_cyc),
    .wb_or1200_i_stb_i (wb_m2s_or1200_i_stb),
    .wb_or1200_i_cti_i (wb_m2s_or1200_i_cti),
    .wb_or1200_i_bte_i (wb_m2s_or1200_i_bte),
    .wb_or1200_i_dat_o (wb_s2m_or1200_i_dat),
    .wb_or1200_i_ack_o (wb_s2m_or1200_i_ack),
    .wb_or1200_i_err_o (wb_s2m_or1200_i_err),
    .wb_or1200_i_rty_o (wb_s2m_or1200_i_rty),
    .wb_dbg_adr_i      (wb_m2s_dbg_adr),
    .wb_dbg_dat_i      (wb_m2s_dbg_dat),
    .wb_dbg_sel_i      (wb_m2s_dbg_sel),
    .wb_dbg_we_i       (wb_m2s_dbg_we),
    .wb_dbg_cyc_i      (wb_m2s_dbg_cyc),
    .wb_dbg_stb_i      (wb_m2s_dbg_stb),
    .wb_dbg_cti_i      (wb_m2s_dbg_cti),
    .wb_dbg_bte_i      (wb_m2s_dbg_bte),
    .wb_dbg_dat_o      (wb_s2m_dbg_dat),
    .wb_dbg_ack_o      (wb_s2m_dbg_ack),
    .wb_dbg_err_o      (wb_s2m_dbg_err),
    .wb_dbg_rty_o      (wb_s2m_dbg_rty),
    .wb_gpio_adr_o     (wb_m2s_gpio_adr),
    .wb_gpio_dat_o     (wb_m2s_gpio_dat),
    .wb_gpio_sel_o     (wb_m2s_gpio_sel),
    .wb_gpio_we_o      (wb_m2s_gpio_we),
    .wb_gpio_cyc_o     (wb_m2s_gpio_cyc),
    .wb_gpio_stb_o     (wb_m2s_gpio_stb),
    .wb_gpio_cti_o     (wb_m2s_gpio_cti),
    .wb_gpio_bte_o     (wb_m2s_gpio_bte),
    .wb_gpio_dat_i     (wb_s2m_gpio_dat),
    .wb_gpio_ack_i     (wb_s2m_gpio_ack),
    .wb_gpio_err_i     (wb_s2m_gpio_err),
    .wb_gpio_rty_i     (wb_s2m_gpio_rty),
    .wb_mem_adr_o      (wb_m2s_mem_adr),
    .wb_mem_dat_o      (wb_m2s_mem_dat),
    .wb_mem_sel_o      (wb_m2s_mem_sel),
    .wb_mem_we_o       (wb_m2s_mem_we),
    .wb_mem_cyc_o      (wb_m2s_mem_cyc),
    .wb_mem_stb_o      (wb_m2s_mem_stb),
    .wb_mem_cti_o      (wb_m2s_mem_cti),
    .wb_mem_bte_o      (wb_m2s_mem_bte),
    .wb_mem_dat_i      (wb_s2m_mem_dat),
    .wb_mem_ack_i      (wb_s2m_mem_ack),
    .wb_mem_err_i      (wb_s2m_mem_err),
    .wb_mem_rty_i      (wb_s2m_mem_rty));

