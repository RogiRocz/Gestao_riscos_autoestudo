package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.PlanoContingencia;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoContigenciaService;
import br.ufc.quixada.npi.gestaoriscos.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;

@RestController
@RequestMapping("/contingencias")
public class PlanoContingenciaController {
	
	@Autowired
	private PlanoContigenciaService planoContingenciaService;

	@Autowired
	private UsuarioService usuarioService;

	@PostMapping
	public ResponseEntity<PlanoContingencia> cadastrarPlanoDeContigencia(@RequestBody PlanoContingencia planoContingencia){
		planoContingencia.setResponsavel(usuarioService.findById(planoContingencia.getResponsavel().getId()));
		return ResponseEntity.status(HttpStatus.CREATED).body(planoContingenciaService.save(planoContingencia));
	}

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<PlanoContingencia>> findByRisco(@RequestParam("risco") Integer riscoId) {
		return ResponseEntity.ok(planoContingenciaService.find(riscoId));
	}
}
