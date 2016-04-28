module add4c (input a[3:0], b[3:0],
              output sum[3:0], cout);
              
  wire c01, c12, c23;
  
  assign {c01, sum[0]} = a[0] + b[0];
  assign {c12, sum[1]} = a[1] + b[1] + c01;
  assign {c23, sum[2]} = a[2] + b[2] + c12;
  assign {cout, sum[3]} = a[3] + b[3] + c23;

endmodule
