module Register #(parameter bus = 24) (input clk, rst, enable, input [bus-1:0]d,output [bus-1:0] q);


	always_ff @(posedge clk)
		if (rst) q <= 0;
		else if (enable) q <= d;

endmodule
