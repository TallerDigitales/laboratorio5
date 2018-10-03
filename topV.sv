module topV (
    input logic clk, rst,
    output logic[7:0] r, g, b,
	 output logic o_hs, o_vs, o_sync, o_blank, o_clk);
	 
	 logic [9:0] x, y;
	 
	 frequencyDivider ffd(clk, rst, o_clk);
	 
	 vgaController v0(o_clk, rst, o_hs, o_vs, o_sync, o_blank, x, y);
	 
	 
	 assign r = o_blank ? 8'd255 : 8'd0;
	 assign g = o_blank ? 8'd0 : 8'd0;
	 assign b = o_blank ? 8'd0 : 8'd0;
	 
endmodule

