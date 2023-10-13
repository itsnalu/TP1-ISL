`include "modulo.v"

module Testbench ();
    //Define as variáveis para integer, regs e wires que serão utilizados nas funções
    integer i;
    reg [0:3] entrada;
    reg reset, ready;
    wire S3, S2, S1, S0;
    //Define a variável para o clock
    wire clk;
    //Define reset e ready para os displays e também os wires para cada segmento do display para cada numero
    reg resetDisp, readyDisp;
    wire [6:0] displayDisp3;
    wire [6:0] displayDisp2;
    wire [6:0] displayDisp1;
    wire [6:0] displayDisp0;


    //Instancia as funções dando nome para elas e também conectando as entradas e saídas com as regs e wires criadas anteriormente
    Clks clock(.clk(clk));
    mod_Saidas saidas(.A(entrada[0]), .B(entrada[1]), .C(entrada[2]), .D(entrada[3]), .reset(reset), .ready(ready), .S3(S3), .S2(S2), .S1(S1), .S0(S0));
    Display display3(.clk(clk), .reset(resetDisp), .ready(readyDisp), .entrada(S3), .display(displayDisp3));
    Display display2(.clk(clk), .reset(resetDisp), .ready(readyDisp), .entrada(S2), .display(displayDisp2));
    Display display1(.clk(clk), .reset(resetDisp), .ready(readyDisp), .entrada(S1), .display(displayDisp1));
    Display display0(.clk(clk), .reset(resetDisp), .ready(readyDisp), .entrada(S0), .display(displayDisp0));
    
    //TestBench começa aqui
    initial begin
        $dumpfile("teste.vcd"); //Começa a criação do arquivo de ondas
        $dumpvars(0); //Dumpvars com o argumento 0 vai dar registrar todas as variáveis relacionadas ao programa
    
        $display("____________________________");
        $display("| A  B  C  D | S3 S2 S1 S0 |"); //Organiza o display
        $display("|____________|_____________|");
        
        //Inicializa o código dando reset no codificador e no display (para não exibir valores com x ao invés de números legíveis)
        reset = 1;
        reset = 0;
        resetDisp = 1;
        resetDisp = 0;

        ready = 1; // Ready para começar a codificar
        readyDisp = 1; // Ready para começar o display
        entrada = 4'b0000; //Define os valores da entrada anteriormente definidas
        #2;

        // Um laço de for é criado para mostrar e adicionar cada valor da entrada, até adicionar 15 vezes na entrada e ter um vetor 4'b1111
        for (i = 0; i < 16; i = i + 1) begin
            $display("| %0t  %0t  %0t  %0t |  %0t  %0t  %0t  %0t |", entrada[0], entrada[1], entrada[2], entrada[3], S3, S2, S1, S0); // Dá display no terminal a cada vez que o for é percorrido
            #1;
            entrada = entrada + 1;
            #3;
        end
        $display("|____________|_____________|"); //Termina a formatação da tabela verdade no terminal

        //Esta era uma outra forma de adicionar cada valor e dar o display para exibir no terminal
        //Contudo, foi decidido que seria melhor usar o for, já que o mesmo não utiliza tantas linhas
        /*
        //0 -> 11
        A = 0;
        B = 0;
        C = 0; 
        D = 0;
        $display("| A  B  C  D | S1 S2 S3 S4 |");
        $display("| %0t %0t %0t %0t | %0t %0t %0t %0t", A, B, C, D, S3, S2, S1, S0);
        #2;
        //1 -> 9
        A = 0;
        B = 0;
        C = 0;
        D = 1;
        #2;
        //2 -> 6
        A = 0;
        B = 0;
        C = 1;
        D = 0; 
        #2;
        //3 -> 15
        A = 0;
        B = 0;
        C = 1;
        D = 1;
        #2;
        //4 -> 5
        A = 0;
        B = 1;
        C = 0; 
        D = 0;
        #2;
        //5 -> 2
        A = 0;
        B = 1;
        C = 0;
        D = 1;
        #2;
        //6 -> 12
        A = 0;
        B = 1;
        C = 1;
        D = 0; 
        #2;
        //7 -> 14
        A = 0;
        B = 1;
        C = 1;
        D = 1;
        #2;
        //8 -> 7
        A = 1;
        B = 0;
        C = 0; 
        D = 0;
        #2;
        //9 -> 0
        A = 1;
        B = 0;
        C = 0;
        D = 1;
        #2;
        //10 -> 8
        A = 1;
        B = 0;
        C = 1;
        D = 0; 
        #2;
        //11 -> 10
        A = 1;
        B = 0;
        C = 1;
        D = 1;
        #2;
        //12 -> 1
        A = 1;
        B = 1;
        C = 0; 
        D = 0;
        #2;
        //13 -> 3
        A = 1;
        B = 1;
        C = 0;
        D = 1;
        #2;
        //14 -> 4
        A = 1;
        B = 1;
        C = 1;
        D = 0; 
        #2;
        //15 -> 13
        A = 1;
        B = 1;
        C = 1;
        D = 1;
        */
        #10;
        $finish; //Termina o dump das variáveis e cria o arquivo .vcd ao executar o .vvp

    end //Termina o Initial Begin
    
endmodule //Termina o módulo de simulação
