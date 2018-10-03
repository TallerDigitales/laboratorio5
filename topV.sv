module topV (
    input logic clk, rst, go,
    output logic[7:0] r, g, b,
	 output logic o_hs, o_vs, o_sync, o_blank, o_clk);
	 
	 logic [9:0] x, y;
	 
	 frequencyDivider ffd(clk, rst, o_clk);
	 
	 vgaController v0(o_clk, rst, o_hs, o_vs, o_sync, o_blank, x, y);
	 
	 logic [7:0] rt, gt, bt;
	 
	 ColorSelector _selector(~go,clk,o_clk,rst, rt,gt,bt);
	 
	 
	 assign r = o_blank ? rt : 8'd0;
	 assign g = o_blank ? gt : 8'd0;
	 assign b = o_blank ? bt : 8'd0;
	 
endmodule

