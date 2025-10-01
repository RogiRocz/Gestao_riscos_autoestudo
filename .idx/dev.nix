{ pkgs, ... }: {
  # Canal do nixpkgs a ser utilizado.
  channel = "stable-24.05";

  # Pacotes de sistema para o ambiente de desenvolvimento.
  packages = [
    # Dependências do Backend (Java/Maven)
    pkgs.jdk11
    pkgs.maven
    
    # Dependências do Frontend (Vue.js)
    pkgs.nodejs_20
    
    # Dependência para o Banco de Dados
    pkgs.postgresql
    pkgs.git
    pkgs.docker-compose

  ];

  # Extensões do VS Code para melhorar a experiência de desenvolvimento.
  idx.extensions = [
    # Suporte para Java
    "vscjava.vscode-java-pack"
    # Suporte para Vue.js (Volar)
    "vue.volar"
    # Linter para JavaScript/TypeScript
    "dbaeumer.vscode-eslint"
  ];

  # Configurações do espaço de trabalho e ciclo de vida.
  idx.workspace = {
    # Comandos a serem executados na criação do workspace.
    onCreate = {
      # Instala as dependências do backend.
      backend-install = "(cd Gestao_Riscos/Codigo/back-gestao-riscos && mvn install)";
      # Instala as dependências do frontend.
      frontend-install = "(cd Gestao_Riscos/Codigo/front-gestao-riscos && npm install)";
    };
    
    # Comandos a serem executados toda vez que o workspace for iniciado.
    onStart = {
      # Inicia o container do banco de dados PostgreSQL.
      start-db = "(cd Gestao_Riscos/dev && docker-compose up -d)";
      # Inicia a aplicação backend Spring Boot.
      start-backend = "(cd Gestao_Riscos/Codigo/back-gestao-riscos && mvn spring-boot:run)";
      # O frontend será iniciado pelo serviço de preview abaixo.
    };
  };

  # Configuração do preview da aplicação web.
  idx.previews = {
    enable = true;
    previews = {
      # Preview para o frontend em Vue.js.
      web = {
        # Comando para iniciar o servidor de desenvolvimento do frontend.
        command = [
          "sh"
          "-c"
          "(cd Gestao_Riscos/Codigo/front-gestao-riscos && npm run serve -- --port $PORT)"
        ];
        manager = "web";
      };
    };
  };
}
