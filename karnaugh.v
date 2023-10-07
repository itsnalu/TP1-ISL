module  modSaidas (
    input A, B, C, D, reset, ready,
    output S3,S2,S1,S0
);

    assign S3 = ((C&D)|(~A&B&C)|(~A&B&C)|(A&~B&C))&ready;
    assign S2 = ((~A&C)|(B&C)|(~A&B&~D)|(A&~B&~C&~D))&ready;
    assign S1 = ((~A&~B&~D)|(~B&~C&~D)|(~A&C&D)|(~B&C&D)|(B&~C&D))&ready;
    assign S0 = ((~C&~D)|(~A&~B&D)|(A&B&D))&ready;
    
endmodule

module c0c6 (
    input S3, S2, S1, S0,
    output C0, C1, C2, C3, C4, C5, C6
);
    assign C0 = S3|(S2&S0)|S1|(~S2&~S0);
    assign C1 = (~S1&~S0)|(S1&S0)|~S2;
    assign C2 = S2|~S1|S0;
    assign C3 = (~S2&~S0)|(S1&~S0)|(S2&~S1&S0)|(~S2&S1);
    assign C4 = (~S2&~S0)|(S1&~S0);
    assign C5 = S3|(~S1&~S0)|(S2&~S0)|(S2&~S1);
    assign C6 = S3|(S1&~S0)|(S2&~S1)|(~S2&S1);
    
   
endmodule
