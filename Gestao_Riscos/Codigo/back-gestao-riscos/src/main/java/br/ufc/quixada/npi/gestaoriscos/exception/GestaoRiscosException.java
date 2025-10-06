package br.ufc.quixada.npi.gestaoriscos.exception;

import org.springframework.http.HttpStatus;

public class GestaoRiscosException extends Exception {
    private final String message;
    private final HttpStatus status;

    public GestaoRiscosException(String message) {
        this.message = message;
        this.status = HttpStatus.BAD_REQUEST;
    }

    public GestaoRiscosException(String message, HttpStatus status) {
        this.message = message;
        this.status = status;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public HttpStatus getStatus() {
        return status;
    }

}
