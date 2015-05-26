module MFM_emulator(clk50, led, index_l, data_h, track_sync, clk5);

   input wire clk50;
   output led, index_l, data_h, track_sync, clk5;

   wire mfm_out;
   wire track_sync;
   wire clk5;

   MFM_clock mfm_clock(.clk50 (clk50),
                       .clk5 (clk5));

   MFM_buffer mfm_buffer(.clk5 (clk5),
                         .track_sync (track_sync),
                         .mfm_out (mfm_out));
                         
   MFM_index mfm_index(.clk50 (clk50),
                       .index_l (index_l),
                       .led (led));

   MFM_data mfm_data(.clk5 (clk5),
                     .mfm_out (mfm_out),
                     .index_l (index_l),
                     .data_h (data_h),
                     .track_sync (track_sync));
endmodule
