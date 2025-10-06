package br.ufc.quixada.npi.gestaoriscos.controller;

import java.util.Collection;
import java.util.Optional;
import javax.validation.Valid;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.Usuario;

import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import br.ufc.quixada.npi.gestaoriscos.service.AcaoService;
import br.ufc.quixada.npi.gestaoriscos.utils.UriLocationBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/acoes")
public class AcaoController {

	@Autowired
	private AcaoService acaoService;

	@Autowired
	private PlanoService planoService;

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<Acao>> findByUsuario(@RequestParam(required = false, name = "plano") Plano plano,
														  @AuthenticationPrincipal Usuario usuario){
		if (plano == null) {
			plano = planoService.findVigente();
		}
		return ResponseEntity.ok(acaoService.findByUnidade(plano, usuario.getUnidade()));
	}

	@PostMapping
	public ResponseEntity<Acao> cadastrar(@RequestBody Acao acao, @AuthenticationPrincipal Usuario usuario){
		acao.setGestor(usuario);
		acao.setUnidade(usuario.getUnidade());
		return ResponseEntity.status(HttpStatus.CREATED).body(acaoService.save(acao));
	}

	@GetMapping(value = "/{id}")
	public ResponseEntity<Acao> findById(@PathVariable("id") Acao acao){
		if (acao != null) {
			return ResponseEntity.ok(acao);
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
	}

	@PutMapping("")
	public ResponseEntity<Acao> atualizar(@RequestBody Acao acao) {
		Acao acaoAtual = acaoService.findById(acao.getId());
		if (acaoAtual == null) {
			return ResponseEntity.notFound().build();
		}
		acaoAtual.setTitulo(acao.getTitulo());
		acaoAtual.setObjetivoGeral(acao.getObjetivoGeral());
		acaoAtual.setObjetivosEspecificos(acao.getObjetivosEspecificos());
		acaoAtual.setAreas(acao.getAreas());
		acaoService.save(acaoAtual);
		return ResponseEntity.ok(acaoAtual);
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Acao> delete(@PathVariable("id") Acao acao) {
		acaoService.delete(acao);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
}