module series ( 
	clk,
	clr,
	s,
	shiftload,
	d,
	q
	) ;

input  clk;
input  clr;
input  s;
input  shiftload;
input [3:0] d;
inout  q;
