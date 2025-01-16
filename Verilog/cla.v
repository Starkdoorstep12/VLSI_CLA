module d_flipflop(d,q,clk);
    input clk;
    input d;
    output reg q;
    always @(posedge clk)
    begin
        q <= d;
    end
endmodule

module cla(a,b,cin,s,cout);
    input [3:0] a,b;
    input cin;

    output [3:0] s;
    output cout;

    wire [3:0] g,p;
    wire c1,c2,c3;
    wire w1,w21,w22,w31,w32,w33,w41,w42,w43,w44;
    
    and g0(g[0],a[0],b[0]);
    and g1(g[1],a[1],b[1]);
    and g2(g[2],a[2],b[2]);
    and g3(g[3],a[3],b[3]);

    xor p0(p[0],a[0],b[0]);
    xor p1(p[1],a[1],b[1]);
    xor p2(p[2],a[2],b[2]);
    xor p3(p[3],a[3],b[3]);

    and a1(w1,p[0],cin);
    or o1(c1,g[0],w1);

    and a2(w21,p[1],g[0]);
    and a3(w22,p[1],p[0],cin);
    or o2(c2,g[1],w21,w22);

    and a4(w31,p[2],g[1]);
    and a5(w32,p[2],p[1],g[0]);
    and a6(w33,p[2],p[1],p[0],cin);
    or o3(c3,g[2],w31,w32,w33);

    and a7(w41,p[3],g[2]);
    and a8(w42,p[3],p[2],g[1]);
    and a9(w43,p[3],p[2],p[1],g[0]);
    and a10(w44,p[3],p[2],p[1],p[0],cin);
    or o4(cout,g[3],w41,w42,w43,w44); 

    xor s0(s[0],p[0],cin);
    xor s1(s[1],p[1],c1);
    xor s2(s[2],p[2],c2);
    xor s3(s[3],p[3],c3);
endmodule

module final(a,b,cin,s,cout,clk);
    input [3:0] a,b;
    input cin,clk;

    output [3:0] s;
    output cout;

    wire [3:0] a_ff,b_ff;
    wire [3:0] s_ff;
    wire c_ff;

    d_flipflop d_flipflop1(a[0],a_ff[0],clk);
    d_flipflop d_flipflop2(a[1],a_ff[1],clk);
    d_flipflop d_flipflop3(a[2],a_ff[2],clk);
    d_flipflop d_flipflop4(a[3],a_ff[3],clk);

    d_flipflop d_flipflop5(b[0],b_ff[0],clk);
    d_flipflop d_flipflop6(b[1],b_ff[1],clk);
    d_flipflop d_flipflop7(b[2],b_ff[2],clk);
    d_flipflop d_flipflop8(b[3],b_ff[3],clk);

    cla cla(a_ff,b_ff,cin,s_ff,c_ff);

    d_flipflop d_flipflop10(s_ff[0],s[0],clk);
    d_flipflop d_flipflop11(s_ff[1],s[1],clk);
    d_flipflop d_flipflop12(s_ff[2],s[2],clk);
    d_flipflop d_flipflop13(s_ff[3],s[3],clk);

    d_flipflop d_flipflop9(c_ff,cout,clk);
endmodule
