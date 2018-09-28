module ColorFSM(input logic go, clk, reset, output logic WE1,WE2,WE3,WE4);



	typedef enum logic [2:0]{ a, b, c, d, e,	f,	g, h } state;
	
	state current, next;
	always_ff @(posedge clk)
	begin
		if (reset) current <= a;
		else current <= next;
	
	end
	
	
	always_comb
		case (current)
			//que voy a hacer con el estado a?
			a:
				//para la entrada go verdadera
				if (go) begin 
					next = b;
				end
				// para go falsa... 
				else next = a;
			b:
				next = c;
			default: 
				next = a;
		endcase
	//asignacion de la salida
	assign WE1 = current == b;
	assign WE2 = current == d;
	//...
	
	
		
endmodule
