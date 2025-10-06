package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import br.ufc.quixada.npi.gestaoriscos.model.Usuario;

import br.ufc.quixada.npi.gestaoriscos.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuarios")
public class UsuarioController {
	
	@Autowired
	private UsuarioService usuarioService;

	@GetMapping({"", "/"})
	public ResponseEntity<List<Usuario>> findAll(@RequestParam("unidade") Unidade unidade) {
		return ResponseEntity.ok(usuarioService.findByUnidade(unidade));
	}

	@GetMapping("/unidade")
	public ResponseEntity<Unidade> findUnidade(@AuthenticationPrincipal Usuario usuario) {
		return ResponseEntity.ok(usuario.getUnidade());
	}

	@GetMapping("/email")
	public ResponseEntity<Usuario> findByEmail(@RequestParam("email") String email) {
		return ResponseEntity.ok(usuarioService.findByEmail(email));
	}

}
