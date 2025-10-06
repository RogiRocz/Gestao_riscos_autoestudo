package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.Ocorrencia;
import br.ufc.quixada.npi.gestaoriscos.model.Usuario;
import br.ufc.quixada.npi.gestaoriscos.service.OcorrenciaService;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoContigenciaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;

@RestController
@RequestMapping("/ocorrencias")
public class OcorrenciaController{
	
	@Autowired
	private OcorrenciaService ocorrenciaService;

	@Autowired
	private PlanoContigenciaService planoContigenciaService;

	@PostMapping
	public ResponseEntity<Ocorrencia> cadastrarOcorrencia(@RequestBody Ocorrencia ocorrencia, @AuthenticationPrincipal Usuario usuario){
		ocorrencia.setResponsavel(usuario);
		ocorrenciaService.save(ocorrencia);
		return ResponseEntity.status(HttpStatus.CREATED).body(ocorrencia);
	}

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<Ocorrencia>> findByRisco(@RequestParam("risco") Integer riscoId) {
		return ResponseEntity.ok(ocorrenciaService.find(riscoId));
	}
	
}
