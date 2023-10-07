module Tsasdas();
    reg a, b, c, d, rt, rd;
    
    wire o3, o2, o1, o0, d0, d1, d2, d3, d4, d5, d6;
    
    modSaidas conversao(a, b, c, d, rt, rd, o3, o2, o1, o0);
    c0c6 display(o3, d0, d1, d2, d3, d4, d5, d6);
    
    initial begin
        
        #10 a = 1'b0;
        
        #10 b = 1'b0;
        
        #10 c = 1'b1;
        
        #10 d = 1'b1;
        
        $finish;
    end
endmodule

module modSaidas (
    input A, B, C, D, reset, ready,
    output wire S3,S2,S1,S0
);

    assign S3 = ((C&D)|(~A&B&C)|(~A&B&C)|(A&~B&C))&ready;
    assign S2 = ((~A&C)|(B&C)|(~A&B&~D)|(A&~B&~C&~D))&ready;
    assign S1 = ((~A&~B&~D)|(~B&~C&~D)|(~A&C&D)|(~B&C&D)|(B&~C&D))&ready;
    assign S0 = ((~C&~D)|(~A&~B&D)|(A&B&D))&ready;
    
endmodule

module c0c6 (
    input wire S3,
    output wire C0, C1, C2, C3, C4, C5, C6
);
    always @* begin
        if (S3 == 1'b0) begin
            assign C0 = 1;
            assign C1 = 0;
            assign C2 = 0;
            assign C3 = 0;
            assign C4 = 1;
            assign C5 = 1;
            assign C6 = 0;
        end
    end
   
endmodule
