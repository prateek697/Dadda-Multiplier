module halfadder 
  (
  a,
  b,
  s,
  c
   );
 
  input  a;
  input  b;
  output s;
  output c;
 
  assign s   = a ^ b;  
  assign c = a & b; 
 
endmodule 

module fulladder(a,b,c,s,co);
input a,b;
input c;
output s,co;
wire out4;
wire out6;
and k1(out1,a,b);
xor k2(out2,a,b);
and k3(out3,out2,c);
or k4(out4,out3,out1);
assign co = out4;
xor k5(out5,a,b);
xor k6(out6,out5,c);
assign s = out6;
endmodule


module daddamultiply4 
	
(
	input [3:0] x,
	input [3:0] y,
	output [7:0] z
);


wire t00,t01,t02,t03,t11,t12,t13,t20,t21,t22,t23,t30,t31,t32,t33;


assign  t00 = x[0] & y[0];
assign  t01 = x[0] & y[1];
assign  t02 = x[0] & y[2];
assign  t03 = x[0] & y[3];
assign  t10 = x[1] & y[0];
assign  t11 = x[1] & y[1];
assign  t12 = x[1] & y[2];
assign  t13 = x[1] & y[3];
assign  t20 = x[2] & y[0];
assign  t21 = x[2] & y[1];
assign  t22 = x[2] & y[2];
assign  t23 = x[2] & y[3];
assign  t30 = x[3] & y[0];
assign  t31 = x[3] & y[1];
assign  t32 = x[3] & y[2];
assign  t33 = x[3] & y[3];

wire [12:0] s;
wire [12:0] cout;
halfadder HA1 ( t03,  t12, s[1], cout[1]);
halfadder HA2 ( t13,  t22, s[2], cout[2]);
halfadder HA3 ( t02,  t11, s[3], cout[3]);
 fulladder FA1 ( t21,  t30, s[1], s[4], cout[4]);
 fulladder FA2 ( t31, cout[1], s[2], s[5], cout[5]);
 fulladder FA3 ( t23,  t32, cout[2], s[6], cout[6]);
halfadder HA4 ( t01,  t10, s[0], cout[0]);
 fulladder FA4 ( t20, s[3], cout[0], s[7], cout[7]);
 fulladder FA5 (cout[3], s[4], cout[7], s[8], cout[8]);
 fulladder FA6 (cout[4], s[5], cout[8], s[9], cout[9]);
 fulladder FA7 (cout[5], s[6], cout[9], s[10], cout[10]);
 fulladder FA8 ( t33, cout[6], cout[10], s[11], cout[11]);

assign z[7] = cout[11];
assign z[6] = s[11];
assign z[5] = s[10];
assign z[4] = s[9];
assign z[3] = s[8];
assign z[2] = s[7];
assign z[1] = s[0];
assign z[0] =  t00;

endmodule


module eightbitadder
(
input [7:0]a,
input [7:0]b,
output [7:0]s
);
wire cx0,cx1,cx2,cx3,cx4,cx5,cx6,co;
FA c1(a[0],b[0],1'b0,s[0],cx0);
FA c2(a[1],b[1],cx0,s[1],cx1);
FA c3(a[2],b[2],cx1,s[2],cx2);
FA c4(a[3],b[3],cx2,s[3],cx3);
FA c5(a[4],b[4],cx3,s[4],cx4);
FA c6(a[5],b[5],cx4,s[5],cx5);
FA c7(a[6],b[6],cx5,s[6],cx6);
FA c8(a[7],b[7],cx6,s[7],co);

endmodule


module fulladder(a,b,c,s,co);
input a,b;
input c;
output s,co;
wire out4;
wire out6;
and k1(out1,a,b);
xor k2(out2,a,b);
and k3(out3,out2,c);
or k4(out4,out3,out1);
assign co = out4;
xor k5(out5,a,b);
xor k6(out6,out5,c);
assign s = out6;
endmodule


module sixteenbitadder(a,b,s);

input [15:0]a,b;

output [15:0]s;


wire cx0,cx1,cx2,cx3,cx4,cx5,cx6,cx7,cx8,cx9,cx10,cx12,cx13,cx14,co;
FA c1(a[0],b[0],1'b0,s[0],cx0);
FA c2(a[1],b[1],cx0,s[1],cx1);
FA c3(a[2],b[2],cx1,s[2],cx2);
FA c4(a[3],b[3],cx2,s[3],cx3);
FA c5(a[4],b[4],cx3,s[4],cx4);
FA c6(a[5],b[5],cx4,s[5],cx5);
FA c7(a[6],b[6],cx5,s[6],cx6);
FA c8(a[7],b[7],cx6,s[7],cx7);
FA c9(a[8],b[8],1'b0,s[8],cx8);
FA c10(a[9],b[9],cx0,s[9],cx9);
FA c11(a[10],b[10],cx1,s[10],cx10);
FA c12(a[11],b[11],cx2,s[11],cx11);
FA c13(a[12],b[12],cx3,s[12],cx12);
FA c14(a[13],b[13],cx4,s[13],cx13);
FA c15(a[14],b[14],cx5,s[14],cx14);
FA c16(a[15],b[15],cx6,s[15],co);
endmodule


module sixteenbitmultiplier
(
input [15:0]x,
input [15:0]y,
output [31:0]z
);

wire [15:0]p,q,r,s;
wire [7:0]g,h;

daddamultiply n1(x[7:0],y[7:0],p[15:0]);
daddamultiply n2(x[15:8],y[7:0],q[15:0]);
daddamultiply n3(x[7:0],y[15:8],r[15:0]);
daddamultiply n4(x[15:8],y[15:8],s[15:0]);
assign z[7:0]=p[7:0];
assign z[31:24]=s[15:8];
eightbitadder m1(s[7:0],r[15:8],g[7:0]);
eightbitadder m2(g[7:0],q[15:8],z[23:16]);
eightbitadder m3(p[15:8],q[7:0],h[7:0]);
eightbitadder m4(h[7:0],r[15:8],z[15:8]);

endmodule


module thirtytwobitmultiplier
(
input [31:0]x,
input [31:0]y,
output [63:0]z
);

wire [31:0]p,q,r,s;
wire [15:0]g,h;

sixteenbitmultiplier n1(x[15:0],y[15:0],p[31:0]);
sixteenbitmultiplier n2(x[31:16],y[15:0],q[31:0]);
sixteenbitmultiplier n3(x[15:0],y[31:16],r[31:0]);
sixteenbitmultiplier n4(x[31:16],y[31:16],s[31:0]);

assign z[15:0]=p[15:0];
assign z[63:48]=s[31:16];

sixteenbitadder m1(s[15:0],r[31:16],g[15:0]);
sixteenbitadder m2(g[15:0],q[31:16],z[47:32]);
sixteenbitadder m3(p[31:16],q[15:0],h[15:0]);
sixteenbitadder m4(h[15:0],r[31:16],z[31:16]);

endmodule

module daddamultiply
(
input [7:0]x,
input [7:0]y,
output [15:0]z
);

wire [7:0]p,q,r,s;
wire [3:0]g,h;

daddamultiply4 n1(x[3:0],y[3:0],p[7:0]);
daddamultiply4 n2(x[7:4],y[3:0],q[7:0]);
daddamultiply4 n3(x[3:0],y[7:4],r[7:0]);
daddamultiply4 n4(x[7:4],y[7:4],s[7:0]);
assign z[3:0]=p[3:0];
assign z[15:12]=s[7:4];
fourbitadder m1(s[3:0],r[7:4],g[3:0]);
fourbitadder m2(g[3:0],q[7:4],z[11:8]);
fourbitadder m3(p[7:4],q[3:0],h[3:0]);
fourbitadder m4(h[3:0],r[7:4],z[7:4]);

endmodule


module fourbitadder(a,b,s);
input [3:0]a,b;

output [3:0]s;

wire cx0,cx1,cx2,co;
FA c1(a[0],b[0],1'b0,s[0],cx0);
FA c2(a[1],b[1],cx0,s[1],cx1);
FA c3(a[2],b[2],cx1,s[2],cx2);
FA c4(a[3],b[3],cx2,s[3],co);


endmodule
