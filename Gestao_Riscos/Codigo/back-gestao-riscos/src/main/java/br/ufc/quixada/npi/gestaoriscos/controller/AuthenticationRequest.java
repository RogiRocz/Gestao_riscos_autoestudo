package br.ufc.quixada.npi.gestaoriscos.controller;

import java.io.Serializable;

public class AuthenticationRequest implements Serializable {

    private String email;
    private String password;

    public AuthenticationRequest() {

    }

    public AuthenticationRequest(String email, String password) {
        this.email = email;
        this.password = password;
    }


    public String getUsername() {
        return email;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
