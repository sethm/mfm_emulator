//
// Produce MFM data
//
module MFM_data(clk5, mfm_out, index_l, data_h, track_sync);
   input wire clk5;
   input wire mfm_out;
   input wire index_l;

   output reg data_h;
   output reg track_sync;
   
   reg last_index_l;

   initial begin
      last_index_l <= index_l;
   end
   
   always @(clk5) begin
      if (~index_l && last_index_l) begin
         // We just saw the falling edge of index_l, so we
         // have to start streaming the start of the
         // current track.
         // ...
         track_sync <= 1;
      end else begin
         track_sync <= 0;
      end

      data_h <= mfm_out & clk5;
   end
 
endmodule
