package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.config.JwtTokenProvider;
import br.ufc.quixada.npi.gestaoriscos.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

import static org.springframework.http.ResponseEntity.ok;

@RestController
@RequestMapping("/")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @Autowired
    private UsuarioRepository usuarioRepository;

    @PostMapping("/login")
    public ResponseEntity<Map<Object, Object>> signin(@RequestBody AuthenticationRequest data) {
        System.out.println("\n Requisição crua: email: " + data.getUsername() + " password: " + data.getPassword() + "\n");
        try {
            String username = data.getUsername();
            String nome = this.usuarioRepository.findByEmail(username).getNome();
            System.out.println("\n usuario: " + this.usuarioRepository.findByEmail(username).toString()
                    + "\n");
            UsernamePasswordAuthenticationToken cred = new UsernamePasswordAuthenticationToken(username, data.getPassword());
            System.out.println("\n Credenciais: " + cred.getCredentials()
                    + " Principal: " + cred.getPrincipal() +
                    "\n");
            authenticationManager.authenticate(cred);
            String token = jwtTokenProvider.createToken(username, this.usuarioRepository.findByEmail(username).getRoles());


            System.out.println("\n nome: " + nome +
                    " token: " + token
                    + "\n");


            Map<Object, Object> model = new HashMap<>();
            model.put("nome", nome);
            model.put("username", username);
            model.put("token", "Bearer " + token);
            return ok(model);
        } catch (AuthenticationException e) {
            System.out.println("\n Erro nas credenciais do usuario: " + e.toString() + "\n");
            throw new BadCredentialsException("Invalid username/password supplied");
        }
    }



}
