package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.exception.*;
import io.swagger.models.Response;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import static org.springframework.http.HttpStatus.UNAUTHORIZED;
import static org.springframework.http.ResponseEntity.status;

import org.springframework.http.HttpHeaders;

@RestControllerAdvice
public class ExceptionHandlingController extends ResponseEntityExceptionHandler {

    @ExceptionHandler(ResourceAlreadyExistsException.class)
    public ResponseEntity<ExceptionResponse> resourceAlreadyExist(ResourceAlreadyExistsException ex) {
        ExceptionResponse response = ExceptionResponse.ExceptionResponseBuilder.anExceptionResponseBuilder()
                .withStatus(HttpStatus.CONFLICT)
                .withError(HttpStatus.CONFLICT.name())
                .withMessage(ex.getMessage())
                .build();
        return new ResponseEntity<>(response, response.getStatus());
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ExceptionResponse> handleResourceNotFound(ResourceNotFoundException ex) {
        ExceptionResponse response = ExceptionResponse.ExceptionResponseBuilder.anExceptionResponseBuilder()
                .withStatus(HttpStatus.NOT_FOUND)
                .withError(HttpStatus.NOT_FOUND.name())
                .withMessage(ex.getMessage())
                .build();
        return new ResponseEntity<>(response, response.getStatus());
    }

    @ExceptionHandler(NotAllowedException.class)
    public ResponseEntity<ExceptionResponse> notAllowed(NotAllowedException ex) {
        ExceptionResponse response = ExceptionResponse.ExceptionResponseBuilder.anExceptionResponseBuilder()
                .withStatus(UNAUTHORIZED)
                .withError(HttpStatus.NOT_FOUND.name())
                .withMessage(ex.getMessage())
                .build();
        return new ResponseEntity<>(response, response.getStatus());
    }

    @ExceptionHandler(FileUploadException.class)
    public ResponseEntity<ExceptionResponse> fileUpload(FileUploadException ex) {
        ExceptionResponse response = ExceptionResponse.ExceptionResponseBuilder.anExceptionResponseBuilder()
                .withStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                .withError("File Upload Error")
                .withMessage(ex.getMessage())
                .build();
        return new ResponseEntity<>(response, response.getStatus());
    }

    @ExceptionHandler(Exception.class )
    public ResponseEntity<ExceptionResponse> handleAll(Exception ex) {
        ExceptionResponse response = ExceptionResponse.ExceptionResponseBuilder.anExceptionResponseBuilder()
                .withStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                .withError(HttpStatus.INTERNAL_SERVER_ERROR.name())
                .withMessage(ex.getMessage())
                .build();
        return new ResponseEntity<>(response, response.getStatus());
    }
    
    @ExceptionHandler(value = GestaoRiscosException.class)
    public ResponseEntity<ExceptionResponse> handleGestaoRiscosException(GestaoRiscosException ex) {
        ExceptionResponse response = ExceptionResponse.ExceptionResponseBuilder.anExceptionResponseBuilder()
                .withStatus(ex.getStatus())
                .withError(ex.getStatus().name())
                .withMessage(ex.getMessage())
                .build();
        return new ResponseEntity<>(response, response.getStatus());
    }

    @ExceptionHandler(value = {InvalidJwtAuthenticationException.class})
    public ResponseEntity<ExceptionResponse> invalidJwtAuthentication(InvalidJwtAuthenticationException ex, WebRequest request) {
        String requestURI = request.getDescription(false);

        ExceptionResponse response = ExceptionResponse.ExceptionResponseBuilder.anExceptionResponseBuilder()
                .withStatus(HttpStatus.UNAUTHORIZED)
                .withError("Invalid JWT")
                .withMessage(ex.getMessage())
                .withPath(requestURI)
                .build();
        return new ResponseEntity<>(response, response.getStatus());
    }



}
