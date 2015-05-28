//
// Produce MFM data
//
module MFM_data(clk50, index_l, data_h);
	input wire clk50;
	input wire index_l;

	output reg data_h;

	// A bit-cell is 200ns wide (10 50MHz cycles)
	reg [7:0] bit_cell_delay;
	// An MFM pulse is 100ns wide (5 50MHz cycles)
	reg [7:0] mfm_pulse_delay;
	
	// Buffer that (for now) holds our MFM data
	reg [15:0] mfm_data;
	// The number of charactrs in our MFM data buffer
	reg [7:0] char_count;

	initial begin
		data_h <= 0;

		bit_cell_delay <= 8'd8;
		mfm_pulse_delay <= 8'h84;
		char_count <= 8'd14; // 16 wide, set counter for 14 (16 - 2)
		mfm_data <= 16'h24A9;
	end
	
	always @(posedge clk50) begin
		if (bit_cell_delay[7]) begin
			// We've reached the start of a new bit cell. Set up the
			// delay for this cell.
			bit_cell_delay <= 8'd8;

			// We've also reached the start of a new mfm pulse. Set 
			// up the delay for the pulse. We'll mask against the high
			// bit of this delay, so we set the value so that the high
			// bit goes low after exactly 5 ticks, and will stay low
			// through the whole bit cell.
			mfm_pulse_delay <= 8'h84;

			// Shift out the next position in the bufer
			mfm_data <= mfm_data << 1;
			char_count <= char_count - 8'd1;

			if (char_count[7]) begin
				char_count <= 8'd14;
				mfm_data <= 16'h24A9;
			end
		end else begin
			bit_cell_delay <= bit_cell_delay - 8'd1;
			mfm_pulse_delay <= mfm_pulse_delay - 8'd1;
		end

		data_h <= mfm_data[15] & mfm_pulse_delay[7];
	end
 
endmodule
