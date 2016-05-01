module ffd (input d, clk,
              output q);
  
  wire d1, d2;
  assign d1 = d ~& clk;
  assign d2 = (~d) ~& clk;
  assign q = d1 ~& (d2 ~& (~q));
  
endmodule
