# Компилятор
CC = clang

# Исходные файлы
SOURCES = start.c game.c app.c

# Флаги компиляции
CFLAGS = -Wall -Wextra
LIBS = -lSDL2

# Имя выходного файла
OUTPUT = a.out

# Основная цель
all: build

# Сборка приложения
build:
	$(CC) $(SOURCES) $(LIBS) -o $(OUTPUT)

# Запуск приложения (сначала собирает, потом запускает)
run: build
	./$(OUTPUT)

# Очистка собранных файлов
clean:
	rm -f $(OUTPUT)

# Псевдонимы
.PHONY: all build run clean