//Criação do módulo de clock para o sistema
module Clks (
    output reg clk
);
    always @* begin
        #1 //Local para setar o clock (O clk vai ser de x segundos para cada sinal)
        clk <= ~clk; //Após x segundos, o valor do clock vai ser invertido
    end
    initial begin
        clk <= 0; // Inicializa o reg do clk como 0 para ter um valor inicial para o clock
    end
endmodule



//Este será o módulo de codificação das entradas
//Ele vai receber 4 entradas, um sinal de reset e um de ready e vai retornar os valores codificados para cada bit
module mod_Saidas (
    input A, B, C, D, reset, ready,
    output reg S3, S2, S1, S0
);

//Tabelas verdade relacionadas ao grupo 30 (O nosso):
//s3 = CD + A'B'C' + A'BC + AB'C
//s2 = A'C + BC + A'BD' + AB'C'D'
//s1 = A'B'D' + B'C'D' + A'CD + B'CD + BC'D
//s0 = C'D' + A'B'D + ABD

    always @* begin
        // Logica de atribuicao normal
        if (ready) begin
            S3 = ((C&D)|(~A&~B&~C)|(~A&B&C)|(A&~B&C));
            S2 = ((~A&C)|(B&C)|(~A&B&~D)|(A&~B&~C&~D));
            S1 = ((~A&~B&~D)|(~B&~C&~D)|(~A&C&D)|(~B&C&D)|(B&~C&D));
            S0 = ((~C&~D)|(~A&~B&D)|(A&B&D));
        end else begin
            // Logica de atribuicao para estado inicial quando ready nao esta ativo
            S3 = 1'b0;
            S2 = 1'b0;
            S1 = 1'b0;
            S0 = 1'b0;
        end
    end

    // Logica de reset para zerar saidas quando o sinal de reset e acionado
    always @(posedge reset) begin
        if (reset) begin
            S3 <= 1'b0;
            S2 <= 1'b0;
            S1 <= 1'b0;
            S0 <= 1'b0;
            
        end
    end

endmodule




//Modulo responsável pela lógica do Display 
//Recebe o clock do sistema (para atualizar o display), um sinal de reset e de ready
//Uma entrada de um bit e a saída de 7 bits (para o display de 7 segmentos)
module Display(
    input clk, reset, ready,
    input entrada,
    output reg [6:0] display
);

always @(clk or posedge reset) begin // Inicia o laço always para verificar sempre que o clock atualiza ou o reset é ativado
    if (reset) begin
        display = 7'b0000000;        // Se o reset for ativado o display será desligado até o reset ser desligado
    end
    else if (ready) begin            // Caso contrário, quando o ready estiver ativo, ele verifica se a entrada é 0 ou 1
        case (entrada)
            1'b0: display = 7'b0111111; // Se for 0, o display liga os segmentos relacionados ao 0: A, B, C, D, E, F
            1'b1: display = 7'b0000110; // Se for 1, o display liga os segmentos relacionados ao 1: B, C
        endcase
    end
end

endmodule