
`timescale 1 ns / 1 ps

	module dfx_icap_wrapper_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface s_axi_reg
		parameter integer C_s_axi_reg_DATA_WIDTH	= 32,
		parameter integer C_s_axi_reg_ADDR_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M_AXI_MEM
		parameter  C_M_AXI_MEM_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_M_AXI_MEM_BURST_LEN	= 16,
		parameter integer C_M_AXI_MEM_ID_WIDTH	= 1,
		parameter integer C_M_AXI_MEM_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_MEM_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_MEM_AWUSER_WIDTH	= 0,
		parameter integer C_M_AXI_MEM_ARUSER_WIDTH	= 4,
		parameter integer C_M_AXI_MEM_WUSER_WIDTH	= 0,
		parameter integer C_M_AXI_MEM_RUSER_WIDTH	= 0,
		parameter integer C_M_AXI_MEM_BUSER_WIDTH	= 0
	)
	(
		// Users to add ports here
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface s_axi_reg
		input wire  s_axi_reg_aclk,
		input wire  s_axi_reg_aresetn,
		input wire [C_s_axi_reg_ADDR_WIDTH-1 : 0] s_axi_reg_awaddr,
		input wire [2 : 0] s_axi_reg_awprot,
		input wire  s_axi_reg_awvalid,
		output wire  s_axi_reg_awready,
		input wire [C_s_axi_reg_DATA_WIDTH-1 : 0] s_axi_reg_wdata,
		input wire [(C_s_axi_reg_DATA_WIDTH/8)-1 : 0] s_axi_reg_wstrb,
		input wire  s_axi_reg_wvalid,
		output wire  s_axi_reg_wready,
		output wire [1 : 0] s_axi_reg_bresp,
		output wire  s_axi_reg_bvalid,
		input wire  s_axi_reg_bready,
		input wire [C_s_axi_reg_ADDR_WIDTH-1 : 0] s_axi_reg_araddr,
		input wire [2 : 0] s_axi_reg_arprot,
		input wire  s_axi_reg_arvalid,
		output wire  s_axi_reg_arready,
		output wire [C_s_axi_reg_DATA_WIDTH-1 : 0] s_axi_reg_rdata,
		output wire [1 : 0] s_axi_reg_rresp,
		output wire  s_axi_reg_rvalid,
		input wire  s_axi_reg_rready,

		// Ports of Axi Master Bus Interface M_AXI_MEM
		//input wire  m_axi_mem_init_axi_txn,
		//output wire  m_axi_mem_txn_done,
		//output wire  m_axi_mem_error,
		input wire  m_axi_mem_aclk,
		input wire  m_axi_mem_aresetn,
		output wire [C_M_AXI_MEM_ID_WIDTH-1 : 0] m_axi_mem_awid,
		output wire [C_M_AXI_MEM_ADDR_WIDTH-1 : 0] m_axi_mem_awaddr,
		output wire [7 : 0] m_axi_mem_awlen,
		output wire [2 : 0] m_axi_mem_awsize,
		output wire [1 : 0] m_axi_mem_awburst,
		output wire  m_axi_mem_awlock,
		output wire [3 : 0] m_axi_mem_awcache,
		output wire [2 : 0] m_axi_mem_awprot,
		output wire [3 : 0] m_axi_mem_awqos,
		output wire [C_M_AXI_MEM_AWUSER_WIDTH-1 : 0] m_axi_mem_awuser,
		output wire  m_axi_mem_awvalid,
		input wire  m_axi_mem_awready,
		output wire [C_M_AXI_MEM_DATA_WIDTH-1 : 0] m_axi_mem_wdata,
		output wire [C_M_AXI_MEM_DATA_WIDTH/8-1 : 0] m_axi_mem_wstrb,
		output wire  m_axi_mem_wlast,
		output wire [C_M_AXI_MEM_WUSER_WIDTH-1 : 0] m_axi_mem_wuser,
		output wire  m_axi_mem_wvalid,
		input wire  m_axi_mem_wready,
		input wire [C_M_AXI_MEM_ID_WIDTH-1 : 0] m_axi_mem_bid,
		input wire [1 : 0] m_axi_mem_bresp,
		input wire [C_M_AXI_MEM_BUSER_WIDTH-1 : 0] m_axi_mem_buser,
		input wire  m_axi_mem_bvalid,
		output wire  m_axi_mem_bready,
		output wire [C_M_AXI_MEM_ID_WIDTH-1 : 0] m_axi_mem_arid,
		output wire [C_M_AXI_MEM_ADDR_WIDTH-1 : 0] m_axi_mem_araddr,
		output wire [7 : 0] m_axi_mem_arlen,
		output wire [2 : 0] m_axi_mem_arsize,
		output wire [1 : 0] m_axi_mem_arburst,
		output wire  m_axi_mem_arlock,
		output wire [3 : 0] m_axi_mem_arcache,
		output wire [2 : 0] m_axi_mem_arprot,
		output wire [3 : 0] m_axi_mem_arqos,
		output wire [C_M_AXI_MEM_ARUSER_WIDTH-1 : 0] m_axi_mem_aruser,
		output wire  m_axi_mem_arvalid,
		input wire  m_axi_mem_arready,
		input wire [C_M_AXI_MEM_ID_WIDTH-1 : 0] m_axi_mem_rid,
		input wire [C_M_AXI_MEM_DATA_WIDTH-1 : 0] m_axi_mem_rdata,
		input wire [1 : 0] m_axi_mem_rresp,
		input wire  m_axi_mem_rlast,
		input wire [C_M_AXI_MEM_RUSER_WIDTH-1 : 0] m_axi_mem_ruser,
		input wire  m_axi_mem_rvalid,
		output wire  m_axi_mem_rready
	);

	wire clk;
	wire rstn;
	wire reset;
	assign clk = s_axi_reg_aclk;
	assign rstn = s_axi_reg_aresetn;
	assign reset = ~rstn;

	// virtual socket interface
	wire vsm_VS_0_rm_shutdown_ack; // ICAP to controller
	wire vsm_VS_0_rm_shutdown_req; // controller to ICAP
	wire vsm_VS_0_rm_decouple;
	wire vsm_VS_0_rm_reset;
	wire vsm_VS_0_event_error;
	wire vsm_VS_0_sw_shutdown_req;
	wire vsm_VS_0_sw_startup_req;

	// ICAP interface
	(* keep = "true" *)
	wire [31:0] icap_o; // ICAP to controller
	(* keep = "true" *)
	wire [31:0] icap_i; // controller to ICAP
	(* keep = "true" *)
	wire icap_csib;
	(* keep = "true" *)
	wire icap_rdwrb;

	// mask AXIL address
	wire [31:0] s_axi_reg_araddr_masked;
	wire [31:0] s_axi_reg_awaddr_masked;

	// mask AXIL reads at address 0b1xxx_xxxx
	reg read_dfx_irq;
	wire s_axi_reg_awready_int;
	wire [31:0] s_axi_reg_rdata_dfx;

	// DFX controller
	assign s_axi_reg_araddr_masked = {24'b0, s_axi_reg_araddr[7:0]};
	assign s_axi_reg_awaddr_masked = {24'b0, s_axi_reg_awaddr[7:0]};
	assign m_axi_mem_arqos = 4'b0;
	assign m_axi_mem_arlock = 1'b0;
	assign m_axi_mem_awvalid = 1'b0;
	assign m_axi_mem_wvalid = 1'b0;
	assign m_axi_mem_bready = 1'b0;
	dfx_controller_zynq dfx_ctrlr (
	    .clk(clk),
	    .reset(reset),
	    // virtual socket 0
	    .vsm_VS_0_rm_shutdown_req(vsm_VS_0_rm_shutdown_req),
        .vsm_VS_0_rm_shutdown_ack(vsm_VS_0_rm_shutdown_ack),
        .vsm_VS_0_rm_decouple    (vsm_VS_0_rm_decouple    ),
        .vsm_VS_0_rm_reset       (vsm_VS_0_rm_reset       ),
        .vsm_VS_0_event_error    (vsm_VS_0_event_error    ),
	    .vsm_VS_0_sw_shutdown_req(vsm_VS_0_sw_shutdown_req),
        .vsm_VS_0_sw_startup_req (vsm_VS_0_sw_startup_req ),
        // ICAP interface
        .icap_clk(clk),
        .icap_reset(reset),
        .icap_i(icap_o),
        .icap_o(icap_i),
        .icap_csib(icap_csib),
        .icap_rdwrb(icap_rdwrb),
        // AXIL registers (receiver)
        .s_axi_reg_awaddr (s_axi_reg_awaddr_masked),
        .s_axi_reg_awvalid(s_axi_reg_awvalid),
        .s_axi_reg_awready(s_axi_reg_awready_int),
        .s_axi_reg_wdata  (s_axi_reg_wdata  ),
        .s_axi_reg_wvalid (s_axi_reg_wvalid ),
        .s_axi_reg_wready (s_axi_reg_wready ),
        .s_axi_reg_bresp  (s_axi_reg_bresp  ),
        .s_axi_reg_bvalid (s_axi_reg_bvalid ),
        .s_axi_reg_bready (s_axi_reg_bready ),
        .s_axi_reg_araddr (s_axi_reg_araddr_masked),
        .s_axi_reg_arvalid(s_axi_reg_arvalid),
        .s_axi_reg_arready(s_axi_reg_arready),
        .s_axi_reg_rdata  (s_axi_reg_rdata_dfx),
        .s_axi_reg_rresp  (s_axi_reg_rresp  ),
        .s_axi_reg_rvalid (s_axi_reg_rvalid ),
        .s_axi_reg_rready (s_axi_reg_rready ),
        // AXI memory (commander)
        .m_axi_mem_araddr (m_axi_mem_araddr ),
        .m_axi_mem_arlen  (m_axi_mem_arlen  ),
        .m_axi_mem_arsize (m_axi_mem_arsize ),
        .m_axi_mem_arburst(m_axi_mem_arburst),
        .m_axi_mem_arprot (m_axi_mem_arprot ),
        .m_axi_mem_arcache(m_axi_mem_arcache),
        .m_axi_mem_aruser (m_axi_mem_aruser ),
        .m_axi_mem_arvalid(m_axi_mem_arvalid),
        .m_axi_mem_arready(m_axi_mem_arready),
        .m_axi_mem_rdata  (m_axi_mem_rdata  ),
        .m_axi_mem_rresp  (m_axi_mem_rresp  ),
        .m_axi_mem_rlast  (m_axi_mem_rlast  ),
        .m_axi_mem_rvalid (m_axi_mem_rvalid ),
        .m_axi_mem_rready (m_axi_mem_rready )
	);

	// make vsm_VS_0_sw_startup_req readable @ reads to 0b1xxx_xxxx
	assign s_axi_reg_awready = s_axi_reg_awready_int;
	assign s_axi_reg_rdata = read_dfx_irq ? {30'b0, vsm_VS_0_sw_shutdown_req, vsm_VS_0_sw_startup_req} : s_axi_reg_rdata_dfx;
	always @(negedge rstn or posedge clk) begin
	    if (~rstn) begin
	        read_dfx_irq <= 1'b0;
	    end else begin
	        if (s_axi_reg_awvalid & s_axi_reg_awready_int) begin
	            if (s_axi_reg_awaddr[7]) begin
	                read_dfx_irq <= 1'b1;
	            end else begin
	                read_dfx_irq <= 1'b0;
	            end
	        end
	    end
	end

	// ICAP instantiation
    ICAPE2 #(
        .DEVICE_ID(32'h3651093),     // Specifies the pre-programmed Device ID value to be used for simulation
                              // purposes.
        .ICAP_WIDTH("X32"),         // Specifies the input and output data width.
        .SIM_CFG_FILE_NAME("NONE")  // Specifies the Raw Bitstream (RBT) file to be parsed by the simulation
                              // model.
    )
    ICAPE2_inst (
        .O(icap_o),         // 32-bit output: Configuration data output bus
        .CLK(clk),          // 1-bit input: Clock Input
        .CSIB(icap_csib),   // 1-bit input: Active-Low ICAP Enable
        .I(icap_i),         // 32-bit input: Configuration data input bus
        .RDWRB(icap_rdwrb)  // 1-bit input: Read/Write Select input
    );

	endmodule
