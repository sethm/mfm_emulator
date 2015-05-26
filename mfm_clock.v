module MFM_clock(clk50, clk5);
	input wire clk50;
	output reg clk5;
	
	reg [3:0] counter;
	
	initial begin
		counter <= 0;
		clk5 <= 0;
	end
	
	always @(posedge clk50) begin
		if (counter < 9) begin
			counter = counter + 1;
		end else begin
			counter = 0;
		end
	end
	
	always @(negedge clk50) begin
		if (counter < 5)
			clk5 <= 1;
		else
			clk5 <= 0;
	end
endmodule
