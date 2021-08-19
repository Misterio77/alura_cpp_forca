#include <string>
#include <iostream>
#include <vector>

#include "le_arquivo.hpp"
#include "salva_arquivo.hpp"

void adiciona_palavra() {
    std::cout << "Digite a palavra(letras maiúsculas): " << std::endl;
    std::string nova_palavra;
    std::cin >> nova_palavra;

    std::vector<std::string> lista_palavras = le_arquivo();
    lista_palavras.push_back(nova_palavra);

    salva_arquivo(lista_palavras);
}
