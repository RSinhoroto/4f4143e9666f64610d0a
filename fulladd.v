module fulladd (input a, b, cin,
		output sum, cout);
	
wire s1, c1, c2;

halfadd h1 (a, b, s1, c1);
halfadd h2 (s1, cin, sum, c2);
assign cout = c1 | c2;

endmodule
