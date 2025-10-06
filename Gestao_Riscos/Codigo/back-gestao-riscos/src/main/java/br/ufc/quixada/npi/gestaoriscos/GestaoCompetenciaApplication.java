package br.ufc.quixada.npi.gestaoriscos;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.env.Environment;

import java.net.InetAddress;
import java.net.UnknownHostException;

@SpringBootApplication
public class GestaoCompetenciaApplication {
    private final Environment env;

    public GestaoCompetenciaApplication(Environment env){
        this.env = env;
    }

    public static void main(String[] args) {
        SpringApplication.run(GestaoCompetenciaApplication.class, args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationReady(){
        String port = env.getProperty("server.port");
        String hostAdress = null;
        try {
            hostAdress = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            throw new RuntimeException(e);
        }
        System.out.println("==================================================");
        System.out.println("  Servidor pronto! Acesse em: https://" + hostAdress + ":" + port);
        System.out.println("==================================================");
    }
}
