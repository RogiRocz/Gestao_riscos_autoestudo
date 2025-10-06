**Como configurar o projeto para desenvolvimento**

**1.**  Primeiramente é necessário estar com o docker instalado em sua máquina.

**2.**  Em seguida, na pasta `dev` do repositório deve ser executado o seguinte comando: `docker compose up -d`. Dessa forma será instanciado o container do banco de dados (Postgres). A verificação dos containers que estão executando pode ser feita através do comando `docker ps` ou através da interface gráfica com o Docker Desktop.

**3.**  Será necessário ter a **JDK 8** e o **NPM** instalados na máquina para executar o back-end e o front-end, respectivamente.

**4.**  Depois será necessário importar o back-end do projeto (`Codigo/back-gestao-riscos`) em uma IDE (IntelliJ, Eclipse ou STS, poe exemplo) e abrir o front-end do projeto (`Codigo/front-gestao-riscos`) em uma IDE voltada para front-end (VSCode ou Web Storm, por exemplo).

**5.**  No caso do back-end, as dependências serão baixadas baixadas automaticamente já para o front-end será necessário executar o comando `npm install`.

**6.**  O último passo consiste na execução do sistema (para executar o front-end é preciso utilizar o comando `npm run serve`).

As duas tabelas a seguir contém as portas de acesso aos serviços e os usuários pré cadastrados no banco de dados, respectivamente.

| SERVIÇO | PORTA | OBSERVAÇÕES |
| ------ | ------ | ------|
| Front-end | 8080 | - |
| Back-end | 8090 | - |
| Postgres | 5532 | O banco se chama `riscos_db`, usuário é `postgres` e senha `postgres` |

| NOME | LOGIN | SENHA |
| ------ | ------ | ------ |
| Andréia Libório Sampaio | `andreia@ufc.br` | `123` |
| Geovana Maria Cartaxo de Arruda Freire | `geovana@ufc.br` | `123` |
| Elizabeth De Francesco Daher | `elizabeth@ufc.br` | `123` |
| Marcus Vinicius Veras Machado | `marcus@ufc.br` | `123` |
| Ana Paula de Medeiros Ribeiro | `anapaula@ufc.br` | `123` |
| Jorge Herbert Soares de Lira | `jorge@ufc.br` | `123` |
| Almir Bittencourt da Silva | `almir@ufc.br` | `123` |
| Brunna Grasiella Matias Silveira | `brunna@ufc.br` | `123` |
| Virginia Farias de Sousa | `virginia@ufc.br` | `123` |
| Marcela Rocha Studart Gurgel | `marcela@ufc.br` | `123` |
| Wildner Lins de Souza | `wildner@ufc.br` | `123` |
| Francisco José Albuquerque Cruz | `jose@ufc.br` | `123` |
| Lara Capelo Cavalcante | `lara@ufc.br` | `123` |
| Nadja Glheuca da Silva Dutra Montenegro | `nadja@ufc.br` | `123` |
| Daniela Gardano Bucharles Mont’Alverne | `daniela@ufc.br` | `123` |
| Alysson Andrade Amorim | `alysson@ufc.br` | `123` |
| Rogério Teixeira Masih | `rogerio@ufc.br` | `123` |
| Bernardo Diniz Coutinho | `bernardo@ufc.br` | `123` |
| Cledson Alexandre Nogueira Nobre | `cledson@ufc.br` | `123` |
| Luzimar Araújo de Oliveira | `luzimar@ufc.br` | `123` |
| Ana Paula Oliveira de Carvalho | `anapaulaoliveira@ufc.br` | `123` |
| Vicente Aguiar | `vicente@ufc.br` | `123` |
| Francisco Paceli Luna Gomes | `paceli@ufc.br` | `123` |
| Francisco Jonatan Soares | `jonatan@ufc.br` | `123` |
| Karla Raquel de Brito Bezerra | `karla@ufc.br` | `123` |
| Rebecca Maria de Freitas Sousa Oliveira | `rebecca@ufc.br` | `123` |
| Yane Nóbrega de Aguiar | `yane@ufc.br` | `123` |
| Cláudio de Albuquerque Marques | `claudio@ufc.br` | `123` |
| Rafael Bráz Azevedo Farias | `rafael@ufc.br` | `123` |
| Francisco Ari de Andrade | `ari@ufc.br` | `123` |
| Aline Batista de Andrade | `aline@ufc.br` | `123` |
| Maria do Socorro de Sousa Rodrigues | `mariadosocorro@ufc.br` | `123` |
| Simone da Silveira Sá Borges | `simone@ufc.br` | `123` |
| Thelma Leite de Araújo | `thelma@ufc.br` | `123` |
| Geanne Matos de Andrade | `geanne@ufc.br` | `123` |
| Jorge Herbert Soares de Lira | `herbert@ufc.br` | `123` |
| Francisco Rodrigo Porto Cavalcanti’s | `rodrigo@ufc.br` | `123` |
| Pedro Carlos Gomes de Lima | `pedrocarlos@ufc.br` | `123` |
| Luana Claudio Sombra | `luana@ufc.br` | `123` |
| José Adriano Pinto | `joseadriano@ufc.br` | `123` |
| Francisco Álcimo de Andrade | `alcimo@ufc.br` | `123` |
| Marcos Antônio Barbosa de Lima | `marcosantonio@ufc.br` | `123` |
| Horácio Luiz de Souza | `horacio@ufc.br` | `123` |
| Kécia Maria Mendes Carneiro | `kecia@ufc.br `| 1`23 `| 
| Augusto Cézar Moura de Macedo | `augusto@ufc.br` | `123` |
| Joaquim Melo de Albuquerque | `joaquim@ufc.br` | `123` |
