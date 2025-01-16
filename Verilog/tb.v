`include "cla.v"

module tb;
    reg clk,cin;
    reg [3:0] a,b;

    wire [3:0] s;
    wire cout;

    final uut(a,b,cin,s,cout,clk);
    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);

        clk = 0; cin=0; a=4'b0000; b=4'b0000;
        #3 a=4'b1001; b=4'b1001;
        #10;
        $monitor("a=%4b b=%4b \t cout=%b s=%4b",a,b,cout,s);
        a=4'b1100; b=4'b0011;
        #10;
        $monitor("a=%4b b=%4b \t cout=%b s=%4b",a,b,cout,s);
        a=4'b0000; b=4'b0000;
        #12;
        $monitor("a=%4b b=%4b \t cout=%b s=%4b",a,b,cout,s);
        $finish;
    end
    always #5 clk=~clk;
endmodule
