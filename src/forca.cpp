#include <iostream>
#include <string>
#include <map>
#include <vector>

#include "acertou-enforcou.hpp"
#include "letra_existe.hpp"
#include "cabeçalho.hpp"
#include "erros.hpp"
#include "palavra.hpp"
#include "chute.hpp"
#include "le_arquivo.hpp"
#include "sorteia_palavra.hpp"
#include "salva_arquivo.hpp"
#include "adiciona_palavra.hpp"

//using namespace std; // Tira a necessidade de ficar colocando "std::"

// Declarado fora de funções, se torna global
std::string palavra_secreta;
std::map<char, bool> chutou;
std::vector<char> chutes_errados;

int main() {

    std::cout << "Irineu" << std::endl;
    std::cout << "O que deseja fazer?" << std::endl;
    std::cout << "Jogar(1) ou Adicionar palavra ao banco de dados(2)." << std::endl;
    int escolha;
    std::cin >> escolha;


    if (escolha == 1){
        cabeçalho();

        palavra_secreta = sorteia_palavra();

        while (!acertou(palavra_secreta, chutou) && chutes_errados.size() < 5){
            erros(chutes_errados);

            palavra(palavra_secreta, chutou);

            chute(chutou, chutes_errados);
        }

        std::cout << "Fim de jogo!" << std::endl;
        if (acertou(palavra_secreta, chutou)){
            std::cout << "Parabéns! você acertou!" << std::endl;
        } else{
            std::cout << "Você perdeu! tente novamente!" << std::endl;
            std::cout << "a palavra era: " << palavra_secreta << std::endl;
        }
    } else if (escolha == 2){
        adiciona_palavra();
    } else {
        std::cout << "Não é uma escolha válida." << std::endl << std::endl;
        main();
    }
    std::cin.get();
}
