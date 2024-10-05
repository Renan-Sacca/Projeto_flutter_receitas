# Meal App

O **Meal App** é um aplicativo desenvolvido em **Flutter** que permite aos usuários explorar uma variedade de receitas culinárias. O app consome dados da API [TheMealDB](https://www.themealdb.com) e oferece funcionalidades como listagem de receitas, visualização detalhada dos ingredientes e instruções, além de favoritar receitas para fácil acesso posterior.

## Funcionalidades Principais

- **Listagem de Receitas**: Exibe uma lista de receitas obtidas da API do TheMealDB, com imagens e nomes de pratos.
- **Detalhes de Receitas**: Ao clicar em uma receita, o usuário é levado à tela de detalhes, onde pode ver os ingredientes (com quantidades) e as instruções.
- **Favoritar Receitas**: O usuário pode favoritar suas receitas preferidas e acessá-las rapidamente na aba de favoritos.
- **Busca de Receitas**: Permite buscar receitas por nome e exibir os resultados diretamente na tela.

## Telas do Aplicativo

### 1. Tela Inicial
A tela inicial permite que o usuário navegue entre a **listagem de receitas** e os **favoritos**.

![Tela Inicial](/imagens/inicio.png)

### 2. Tela de Receitas
Exibe a lista de receitas obtidas da API, com nome e imagem de cada prato. Ao clicar em uma receita, o usuário é redirecionado para a tela de detalhes.

![Tela de Receitas](/imagens/listar.png)

### 3. Tela de Detalhes
Exibe o nome do prato, imagem, ingredientes (com quantidades) e instruções de preparo. Também permite favoritar a receita.

![Tela de Detalhes](/imagens/detalhes.png)

### 4. Tela de Favoritos
Lista as receitas que foram favoritas pelo usuário, permitindo o acesso rápido a elas. Ao clicar em uma receita favorita, o usuário é levado para a tela de detalhes.

![Tela de Favoritos](/imagens/favoritos.png)

## Como Rodar o Aplicativo

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/meal-app.git

2. Navegue até o diretório do projeto:
    cd meal-app

3. Instale as dependências do Flutter:
    flutter pub get

4. Execute o projeto:
    flutter run

5. Criar o apk
    flutter build apk --release

## Tecnologias Utilizadas

Flutter: Framework para desenvolvimento mobile.
TheMealDB API: API usada para buscar receitas e detalhes.
SharedPreferences: Para armazenar localmente as receitas favoritas.
