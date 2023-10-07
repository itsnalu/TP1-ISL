module Tsasdas;
    reg a, b, c, d, rt, rd;
    
    inout o3, o2, o1, o0;
    /* wire a1;
    wire b2;
    wire c3;
    wire d4; */
    
    modSaidas conversao(a, b, c, d, rt, rd, o3, o2, o1, o0);
    //c0c6 display1(o3, o2, o1, o0, disp1, disp2, disp3, disp4);
    
    initial begin
        
        $dumpfile("testada.vcd");
        $dumpvars(1);

        #10 a = 1'b0;
        
        #10 b = 1'b0;
        
        #10 c = 1'b1;
        
        #10 d = 1'b1;

        #10 rd = 1;
        
        $finish;
    end
endmodule


module  modSaidas (
    input A, B, C, D;
    input reg reset, ready,
    output reg S[3:0];
);

    assign S[0] = ((C&D)|(~A&B&C)|(~A&B&C)|(A&~B&C))&ready;
    assign S[1] = ((~A&C)|(B&C)|(~A&B&~D)|(A&~B&~C&~D))&ready;
    assign S[2] = ((~A&~B&~D)|(~B&~C&~D)|(~A&C&D)|(~B&C&D)|(B&~C&D))&ready;
    assign S[3] = ((~C&~D)|(~A&~B&D)|(A&B&D))&ready;
    
endmodule

module modSaidas_tb (
    input A, B, C, D, reset, ready,
    inout S[3:0].(S),
    output reg[6:0] a;

);



    always @* begin


        if (S3 == 0) begin
            assign a[0] = 1;
            assign a[1] = 1;   
            assign a[2] = 1;
            assign a[3] = 1;
            assign a[4] = 1;
            assign a[5] = 1;
            assign a[6] = 0;
        end else if (S3 == 1'b1) begin
            assign a[0] = 1;
            assign a[1] = 1;   
            assign a[2] = 0;
            assign a[3] = 0;
            assign a[4] = 0;
            assign a[5] = 0;
            assign a[6] = 0;
        end 

        if (S2 == 1'b0) begin
            assign b[0] = 1;
            assign b[1] = 1;   
            assign b[2] = 1;
            assign b[3] = 1;
            assign b[4] = 1;
            assign b[5] = 1;
            assign b[6] = 0;

        end else if (S2 == 1'b1) begin
            assign b[0] = 1;
            assign b[1] = 1;   
            assign b[2] = 0;
            assign b[3] = 0;
            assign b[4] = 0;
            assign b[5] = 0;
            assign b[6] = 0;
        end

        if (S1 == 1'b0) begin
            assign c[0] = 1;
            assign c[1] = 1;   
            assign c[2] = 1;
            assign c[3] = 1;
            assign c[4] = 1;
            assign c[5] = 1;
            assign c[6] = 0;

        end else if (S1 == 1'b1) begin
            assign c[0] = 1;
            assign c[1] = 1;   
            assign c[2] = 0;
            assign c[3] = 0;
            assign c[4] = 0;
            assign c[5] = 0;
            assign c[6] = 0;
        end

        if (S0 == 1'b0) begin
            assign d[0] = 1;
            assign d[1] = 1;   
            assign d[2] = 1;
            assign d[3] = 1;
            assign d[4] = 1;
            assign d[5] = 1;
            assign d[6] = 0;

        end else if (S0 == 1'b1) begin
            assign d[0] = 1;
            assign d[1] = 1;   
            assign d[2] = 0;
            assign d[3] = 0;
            assign d[4] = 0;
            assign d[5] = 0;
            assign d[6] = 0;
        end
        
    end
    

endmodule

/*
module c0c6 (
    input wire S3, S2, S1, S0,
    wire[6:0] a,
    wire[6:0] b,
    wire[6:0] c,
    wire[6:0] d
);
    always @* begin
        if (S3 == 0) begin
            assign a[0] = 1;
            assign a[1] = 1;   
            assign a[2] = 1;
            assign a[3] = 1;
            assign a[4] = 1;
            assign a[5] = 1;
            assign a[6] = 0;

        end else if (S3 == 1'b1) begin
            assign a[0] = 1;
            assign a[1] = 1;   
            assign a[2] = 0;
            assign a[3] = 0;
            assign a[4] = 0;
            assign a[5] = 0;
            assign a[6] = 0;
        end

        if (S2 == 1'b0) begin
            assign b[0] = 1;
            assign b[1] = 1;   
            assign b[2] = 1;
            assign b[3] = 1;
            assign b[4] = 1;
            assign b[5] = 1;
            assign b[6] = 0;

        end else if (S2 == 1'b1) begin
            assign b[0] = 1;
            assign b[1] = 1;   
            assign b[2] = 0;
            assign b[3] = 0;
            assign b[4] = 0;
            assign b[5] = 0;
            assign b[6] = 0;
        end

        if (S1 == 1'b0) begin
            assign c[0] = 1;
            assign c[1] = 1;   
            assign c[2] = 1;
            assign c[3] = 1;
            assign c[4] = 1;
            assign c[5] = 1;
            assign c[6] = 0;

        end else if (S1 == 1'b1) begin
            assign c[0] = 1;
            assign c[1] = 1;   
            assign c[2] = 0;
            assign c[3] = 0;
            assign c[4] = 0;
            assign c[5] = 0;
            assign c[6] = 0;
        end

        if (S0 == 1'b0) begin
            assign d[0] = 1;
            assign d[1] = 1;   
            assign d[2] = 1;
            assign d[3] = 1;
            assign d[4] = 1;
            assign d[5] = 1;
            assign d[6] = 0;

        end else if (S0 == 1'b1) begin
            assign d[0] = 1;
            assign d[1] = 1;   
            assign d[2] = 0;
            assign d[3] = 0;
            assign d[4] = 0;
            assign d[5] = 0;
            assign d[6] = 0;
        end
        
    end
   
endmodule
*/