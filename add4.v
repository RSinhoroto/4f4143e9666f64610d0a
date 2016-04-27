module add4 (input a[3:0], b[3:0], cin,
					output sum[3:0], cout);
	
	wire c01, c12, c23;				
	fulladd f0(a[0], b[0], cin, sum[0], c01);
	fulladd f1(a[1], b[1], c01, sum[1], c12);
	fulladd f2(a[2], b[2], c12, sum[2], c23);
	fulladd f3(a[3], b[3], c23, sum[3], cout);

endmodule