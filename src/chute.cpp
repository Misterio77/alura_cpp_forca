#include <iostream>
#include "chute.hpp"

#include "letra_existe.hpp"


void chute(std::map<char, bool>& chutou, std::vector<char>& chutes_errados) {
    std::cout << "Seu chute: ";
    char chute;
    std::cin >> chute;

    chutou[chute] = true;

    if (letra_existe(chute)){
        std::cout << "O chute está contido na palavra." << std::endl;
    } else{
        std::cout << "O chute não está contido na palavra." << std::endl;
        chutes_errados.push_back(chute);
    }
    std::cout << std::endl;
}