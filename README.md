# llvm_gameoflife

## Запуск
- `make run` - запустить приложение

- `make build` - собрать

## LLVM IR
находится в папке `IRGen`

`clang -S -emit-llvm -Os {filename}.c -o ./IRGen/{filename}.ll`
