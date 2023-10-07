module mod_Saidas (
    input A, B, C, D, reset, ready,
	 wire [6:0] display,
    output reg S3, S2, S1, S0
);

		
    always @* begin
        // Lógica de atribuição normal
        if (ready) begin
            S3 = ((C&D)|(~A&B&C)|(~A&B&C)|(A&~B&C));
            S2 = ((~A&C)|(B&C)|(~A&B&~D)|(A&~B&~C&~D));
            S1 = ((~A&~B&~D)|(~B&~C&~D)|(~A&C&D)|(~B&C&D)|(B&~C&D));
            S0 = ((~C&~D)|(~A&~B&D)|(A&B&D));
        end else begin
            // Lógica de atribuição para estado inicial quando ready não está ativo
            S3 = 1'b0;
            S2 = 1'b0;
            S1 = 1'b0;
            S0 = 1'b0;
        end
    end

    // Lógica de reset para zerar saídas quando o sinal de reset é acionado
    always @(posedge reset) begin
        if (reset) begin
            S3 <= 1'b0;
            S2 <= 1'b0;
            S1 <= 1'b0;
            S0 <= 1'b0;
        end
    end

endmodule

