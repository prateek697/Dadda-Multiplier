module main();
reg [31:0]x,y;
wire [63:0]z;
thirtytwobitmultiplier k1(.x(x),.y(y),.z(z));

initial begin
 x=1;
 y=1;

end
always begin 
#30 x=x+1;

#50 y=y+1;
$display(x,y,z);
end
 
endmodule
