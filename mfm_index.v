//
// Generate index timing pulses.
//
module MFM_index (clk50, index_l, led);
   
   input wire clk50;
   output reg index_l = 1;
   output reg led = 1;
    
   reg [31:0] delay = -1;
    
   always @(posedge clk50) begin
      if (delay[31]) begin
         if (index_l) begin
            // We're ready for a new index pulse.
            // Pull the index line low.
            index_l <= 0;               
            led <= 0;
            
            // And keep it low for 200 us
            delay <= 10_000 - 2;            
         end
         else begin
            // We're coming out of an index pulse.
            // Reset the index line to high.
            index_l <= 1;
            led <= 1;
            
            // And keep it high for 16.47 ms
            // (1 revolution, minus one index pulse)
            delay <= 823_335 - 2;           
         end
      end
      else begin
         delay <= delay - 1;
      end
   end
endmodule
