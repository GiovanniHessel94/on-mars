# Project-OnMars
[![codecov](https://codecov.io/gh/GiovanniHessel94/project-on-mars/branch/main/graph/badge.svg?token=3SU9DYKHWA)](https://codecov.io/gh/GiovanniHessel94/project-on-mars)

O projeto OnMars foi desenvolvido para a conclusão de um desafio de conhecimentos gerais sobre o desenvolvimento back end e para colocar em prática alguns dos conhecimentos adquiridos no curso [Ignite da Rocketseat](https://rocketseat.com.br/ignite).

## O Desafio

O desafio consiste na implementação de uma API que tem como objetivo controlar uma sonda especial. A sonda está em marte, como o nome do projeto sugere, e possui uma área onde ela pode se movimentar, consistindo de um quadrado 5x5. A posição da sonda é representada pelos eixo x e y, e sua direção pela inicial, podendo ser `E - Esquerda`, `D - Direita`, `C - Cima` ou `B - Baixo`. Para se movimentar a sonda recebe três comandos, sendo eles `GE - Girar 90 graus a esquerda`, `GD - Girar 90 graus a direita` e `M - Mover uma posição na direção que está apontada`.

A API deve possuir três endpoints, sendo eles:
* Um endpoint que recebe os comandos de movimentos e retorna a nova posição, caso a posição se encontre dentro do quadrante ou um erro indicando que a posição é inválida.
* Um endpoint que deve retornar a posição atual da sonda.
* Um endpoint que envia a sonda para a posição inicial.

## Executando localmente

### Pré-requisitos

Antes de começar, existem alguns pré-requisitos que devem ser atendidos:
* Você possui a versão `23.0` ou superior do erlang instalado.
* Você possui a versão `1.11.0` ou superior do elixir instalado.

Caso ainda não atenda estes requisitos, você pode encontrar o tutorial de instalação de ambos neste [link](https://elixir-lang.org/install.html).

### Comandos

Instalando as dependências:
```
mix deps.get
```
Iniciando o servidor localmente:
```
mix phx.server
```

## Endpoints

A documentação dos endpoints desenvolvidos nesse projeto pode ser encontrada neste [link](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/GiovanniHessel94/project-on-mars/main/swagger.yaml). 

Através da documentação é possível realizar requisições ao servidor local e ao [servidor "produção"](https://project-on-mars.gigalixirapp.com/api/) sendo executado na [plataforma gigalixir](https://www.gigalixir.com/).

## Autor

Giovanni Hessel\
[@Linkedin](https://www.linkedin.com/in/giovanni-garcia-hessel-137b1393/)