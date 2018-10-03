module ColorSelector
	#(parameter HACTIVE = 10'd635,
	HFP 	  = 10'd15,
	HSYN    = 10'd95,
	HBP     = 10'd48,
	HSS     = HSYN + HBP,
	HSM	  = HSYN + HBP + HACTIVE/2,
	HSE     = HSYN + HBP + HACTIVE,
	HMAX    = HSYN + HBP + HACTIVE + HFP,										
	VACTIVE = 10'd480,
	VFP     = 10'd10,
	VSYN    = 10'd2,
	VBP     = 10'd33,
	VSS     = VSYN + VBP,
	VSM     = VSYN + VBP + VACTIVE/2,
	VSE     = VSYN + VBP + VACTIVE,
	VMAX    = VSYN + VBP + VACTIVE + VFP)

	(input go, clk_rdm, clk, rst, output logic [7:0] r,g,b);
	
	logic [9:0] hCnt, vCnt;
	
	logic hRstF, vRstF, hDS, hDE, vDS, vDE, ROW1,COL1 = 0;
	
	logic WE1,WE2,WE3,WE4;
	
	logic clkout;
	TimeDivider1Seg (clk, rst,clkout);
	
	ColorFSM(go, clkout, rst, WE1,WE2,WE3,WE4);

	logic [23:0] color1,color2,color3,color4, default_color, 
		generated_color, selected_color, output_color;
	
	
	
	counter #(24)  (clk, rst,1,generated_color);
	
	
	
	
	
	
	Register _color1(clkout, rst, WE1, generated_color, color1);
	Register _color2(clkout, rst, WE2, generated_color, color2);
	Register _color3(clkout, rst, WE3, generated_color, color3);
	Register _color4(clkout, rst, WE4, generated_color, color4);
	
	
	//WEX 0 se muestra la pantalla en negro en esa zona
	
	//0000 color default
	//0001 color 1
	//0010 color 2
	//0100 color 3
	//1000 color 4
	
	
	
	
		
	comparator#(10) hMaxComparator(.a(hCnt), .b(HMAX - 1), .gte(hRstF));
	comparator#(10) vMaxComparator(.a(vCnt), .b(VMAX - 1), .gte(vRstF));

	counter#(10) horizontalPixelCounter(clk, (rst | hRstF), 1, hCnt);
	counter#(10) VerticalPixelCounter(clk, (rst | hRstF & vRstF), hRstF, vCnt);
	
	
	comparator#(10) hDisplayStartComparator(.a(hCnt), .b(HSS), .gte(hDS));
	comparator#(10) hDisplayEndComparator(.a(hCnt), .b(HSE), .lt(hDE));
	
	
	comparator#(10) vDisplayStartComparator(.a(vCnt), .b(VSS), .gte(vDS));
	comparator#(10) vDisplayEndComparator(.a(vCnt), .b(VSE), .lt(vDE));
	
	
	comparator#(10) hDisplayEndComparator_1(.a(hCnt), .b(HSM), .lt(ROW1));
	comparator#(10) hDisplayEndComparator_2(.a(vCnt), .b(VSM), .lt(COL1));
	
	
	assign default_color = 24'd0;
	
	assign selected_color = (ROW1)?(COL1? color1:color2):(COL1? color3:color4);
	
	assign output_color = (hDS & hDE & vDS & vDE)? selected_color : default_color; 
	
	
	
	
	assign r = output_color[7:0];
	assign g = output_color[15:8];
	assign b = output_color[23:16];


endmodule
