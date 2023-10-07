`default_nettype none
module c0c6 #(
    input A, B, C, D, output C0,C1,C2,C3,C4,C5,C6,
) (
    assign C0 = A|(B&D)|C|(~B&~D);
    assign C1 = (~C&~D)|(C&D)|~B;
    assign C2 = B|~C|D;
    assign C3 = (~B&~D)|(C&~D)|(B&~C&D)|(~B&C);
    assign C4 = (~B&~D)|(C&~D);
    assign C5 = A|(~C&~D)|(B&~D)|(B&~C);
    assign C6 = A|(C&~D)|(B&~C)|(~B&C);
    
);
    
endmodule