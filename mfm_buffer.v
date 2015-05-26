module MFM_buffer(clk5, track_sync, mfm_out);
   input wire clk5;
   input wire track_sync;
   output reg mfm_out;

   reg [15:0] buffer;
   reg [7:0] count = 16 - 2;

   initial begin
      buffer = 16'h24A9;
   end

   always @(posedge clk5) begin
      if (count[7]) begin
         buffer = 16'h24A9;
         count = 15 - 2;
      end

      mfm_out = buffer[15];
      buffer = buffer << 1;
      count = count - 1;
   end
   
endmodule
