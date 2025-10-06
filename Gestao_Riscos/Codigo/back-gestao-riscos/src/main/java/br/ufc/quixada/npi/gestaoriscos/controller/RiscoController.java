package br.ufc.quixada.npi.gestaoriscos.controller;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

import br.ufc.quixada.npi.gestaoriscos.exception.GestaoRiscosException;
import br.ufc.quixada.npi.gestaoriscos.model.*;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import br.ufc.quixada.npi.gestaoriscos.service.RiscoService;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/riscos")
public class RiscoController {

	@Autowired
	private RiscoService riscoService;

	@Autowired
	private PlanoService planoService;

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<Risco>> findAll(@RequestParam(required = false, name = "plano") Plano plano,
													 @RequestParam(required = false) Acao acao,
													 @AuthenticationPrincipal Usuario usuario) {
		if (plano == null) {
			plano = planoService.findVigente();
		}

		if(acao != null) {
			return ResponseEntity.ok(riscoService.findByAcoes(acao));
		}

		return ResponseEntity.ok(riscoService.findByUnidade(plano, usuario.getUnidade()));
	}


	@GetMapping(value = "/{id}")
	public ResponseEntity<Risco> find(@PathVariable("id") Risco risco){
		if (risco != null) {
			return ResponseEntity.ok(risco);
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
	}

	@PostMapping
	public ResponseEntity<Risco> cadastrar(@RequestBody Risco risco, @AuthenticationPrincipal Usuario usuario){
		risco.setResponsavel(usuario);
		risco.setUnidade(usuario.getUnidade());
		return ResponseEntity.status(HttpStatus.CREATED).body(riscoService.save(risco));
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Risco> update(@RequestBody Risco risco, @PathVariable Integer id,
												@AuthenticationPrincipal Usuario usuario) {
		Risco riscoOriginal = riscoService.findById(id);
		if (riscoOriginal == null) {
			return ResponseEntity.notFound().build();
		}

		riscoOriginal.getAcoes().clear();
		riscoOriginal.getCategorias().clear();
		riscoOriginal.setNome(risco.getNome());
		riscoOriginal.setTipo(risco.getTipo());
		riscoOriginal.addAllCategorias(risco.getCategorias());
		riscoOriginal.setAcoes(risco.getAcoes());
		riscoOriginal.setCausa(risco.getCausa());
		riscoOriginal.setConsequencia(risco.getConsequencia());
		riscoOriginal.setControles(risco.getControles());
		
		riscoOriginal.setResponsavel(usuario);

		return ResponseEntity.ok(riscoService.save(riscoOriginal));
	}
	

	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Risco> delete(@PathVariable("id") Risco risco, @AuthenticationPrincipal Usuario usuario) {
		if (risco == null) {
			return ResponseEntity.notFound().build();
		}

		if(usuario.getId().equals(risco.getResponsavel().getId())) {
			riscoService.delete(risco);
			return new ResponseEntity<>(HttpStatus.OK);
		}

		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}

	/*@PostMapping("/{riscoId}/compartilhar")
	public ResponseEntity<Risco> compartilhar(@PathVariable Integer riscoId, @RequestBody List<Unidade> unidades){
		Risco risco = riscoService.findById(riscoId).get();
		risco.setUnidades(unidades);
		return ResponseEntity.ok(riscoService.update(risco));
	}*/

}
