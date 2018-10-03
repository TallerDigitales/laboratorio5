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
			
			//Cuando el go indica que se va al estado a,
			//se puede acceder por medio del default
			a:
				//para la entrada go verdadera
				if (go)
					next = b;
				// para go falsa... 
				else next = a;
			b:
				next = c;
			
			//Cuando el go indica que se va al estado c	
			c:
				//para la entrada go verdadera
				if (go)
					next = d;
				// para go falsa... 
				else next = c;
			d:
				next = e;
			
			//Cuando el go indica que se va al estado e
			e:
				//para la entrada go verdadera
				if (go) begin 
					next = f;
				end
				// para go falsa... 
				else next = e;
			f:
				next = g;
				
			//Cuando el go indica que se va al estado e
			g:
				//para la entrada go verdadera
				if (go) begin 
					next = h;
				end
				// para go falsa... 
				else next = g;
			h:
				next = a;
				
			default: 
				next = a;
		endcase
	//asignacion de la salida
	assign WE1 = current == b;
	assign WE2 = current == d;
	assign WE3 = current == f;
	assign WE4 = current == h;
	
		
endmodule
