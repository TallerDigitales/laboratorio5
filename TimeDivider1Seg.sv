//clk is a 50Mhz
module TimeDivider1Seg #(parameter LIMIT = 32'd1562500) (input logic clk, reset, output logic clkout);

	logic [31:0] data;
	logic reset_counter;
	//counter #(32) _counter(clk, reset_counter | reset, data);
	
	//25 000 000 tics
	assign reset_counter = (data == 32'd25000000);
	
	
	

	always_ff @(posedge clk)
	begin
		if (reset) begin 
			clkout <= 1;
			data <= 32'd0;
		end
		else if (data >= LIMIT)begin
			clkout <= ~clkout;
			data <= 32'd0;
		end
		else data <= data  + 32'd1;
		//else if (reset_counter) clkout  <= ~clkout;
	end

endmodule
