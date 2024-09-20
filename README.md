# Atv 11
## Ariel T Leventhal

### Introducao
Nesse projeto foram criado diversos codigos em cuda para fazer operacoes com arrays (codigos disponiveis no repo).

### Discussao
Observamos um desenpenho muito melhor em cuda em relacao a cpu. Utilizando as funcoes de transfomacao de arrays do thrust, conseguimos fazer operacoe em arrays grande de maneira paralela. Alem disso usando iteradores constantes e outros tipos de iteradores, conseguimos fazer operacoes usando menos VRAM. A diferença não é tao grande nos exemplos de aula ja que os arrays sao relativamente pequenos mas em datasets grandes que seriam a principal para uso de gpu, a diferença seria mais perceptivel.