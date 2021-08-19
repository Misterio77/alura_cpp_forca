# Nome do executavel
TARGET_EXEC := forca

# Pasta onde vai os objetos compilados
BUILD_DIR := ./build
# Pasta onde tem o código fonte
SRC_DIRS := ./src

# Pegar todos os .cpp ou .c pra compilarmos
SRCS := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c)

# Substituir cada arquivo por um equivalente em build e terminado com .o
# Por exemplo, oi.cpp vira ./build/oi.cpp
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

# Colocar .d de sufixo nas .o, essas serão makefiles auxiliares
DEPS := $(OBJS:.o=.d)

# Listas as subpastas dentro de ./src para passarmos ao GCC onde ele pode buscar os headers.hpp
INC_DIRS := $(shell find $(SRC_DIRS) -type d)
# Adicionar -I de prefixo nas subpastas, pra passar pro GCC
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

# Essas flags vão fazer o gcc gerar Makefiles pra nois
CPPFLAGS := $(INC_FLAGS) -MMD -MP

# Mandar o linker usar std do c++
LDFLAGS := -lstdc++

# Passo de linkagem (juntar as .o num executavel)
# Esse passo diz, pra fazer o executavel ./build/forca, precisamos de todos os objetos (tipo ./build/oi.cpp.o)
# E para isso, a gente chama g++ ./build/oi.cpp.o ./build/irineu.cpp.o -o ./forca FLAGS
$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Compilar os arquivos .C
# Esse passo diz, para cada arquivo .c.o, ele pega o .c correspondente
# E chama tipo, gcc FLAGS -c ./src/exemplo.c -o ./build/exemplo.c.o
$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# Compilar os arquivos .CPP
# Esse passo diz, para cada arquivo .cpp.o, ele pega o .cpp correspondente
# E chama tipo, g++ FLAGS -c ./src/exemplo.cpp -o ./build/exemplo.cpp.o
$(BUILD_DIR)/%.cpp.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@


# Apaga o diretorio de build
clean:
	rm -r $(BUILD_DIR)

run: $(BUILD_DIR)/$(TARGET_EXEC)
	./$<

# Incluir os makefiles gerados
-include $(DEPS)
