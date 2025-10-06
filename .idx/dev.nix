{ pkgs, ... }: {
  # Canal do nixpkgs a ser utilizado.
  channel = "stable-24.05";

  # Pacotes de sistema para o ambiente de desenvolvimento.
  packages = [
    # Dependências do Backend (Java/Maven)
    pkgs.jdk8
    pkgs.maven
    
    # Dependências do Frontend (Vue.js)
    pkgs.nodejs_20
    
    # Dependência para o Banco de Dados
    pkgs.postgresql
    pkgs.git
    pkgs.docker-compose
  ];

  services.docker.enable = true;

  env = {
    SPRING_DATASOURCE_URL = "jdbc:postgresql://localhost:5532/riscos_db";
    SPRING_DATASOURCE_USERNAME = "postgres";
    SPRING_DATASOURCE_PASSWORD = "postgres";
  };


  # Extensões do VS Code para melhorar a experiência de desenvolvimento.
  idx.extensions = [
    # Suporte para Java
    "vscjava.vscode-java-pack"
    # Suporte para Vue.js (Volar)
    "vue.volar"
    # Linter para JavaScript/TypeScript
    "dbaeumer.vscode-eslint"
    # Formatador de código Prettier
    "esbenp.prettier-vscode"
    # Suporte do Gemini 
    "google.gemini-cli-vscode-ide-companion"
  ];

  # Configurações do espaço de trabalho e ciclo de vida.
  idx.workspace = {
    # Comandos a serem executados na criação do workspace.
    onCreate = {
      # Instala as dependências do backend.
      backend-install = "(cd Gestao_Riscos/Codigo/back-gestao-riscos && mvn install)";
      # Instala as dependências do frontend.
      frontend-install = "(cd Gestao_Riscos/Codigo/front-gestao-riscos-vue3 && npm install)";
    };
    
    # Comandos a serem executados toda vez que o workspace for iniciado.
    onStart = {
      # Inicia o docker para se conectar ao BD
      star-database = "(cd Gestao_Riscos/dev && docker compose up -d)";
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
          "(cd Gestao_Riscos/Codigo/front-gestao-riscos-vue3 && npm run dev -- --port $PORT)"
        ];
        manager = "web";
      };
    };
  };
}
