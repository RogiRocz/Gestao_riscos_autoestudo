package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Risco;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import br.ufc.quixada.npi.gestaoriscos.service.UnidadeService;
import br.ufc.quixada.npi.gestaoriscos.utils.UriLocationBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Collection;
import java.util.List;

@RestController
@RequestMapping("/unidades")
public class UnidadeController {

	@Autowired
	private UnidadeService unidadeService;
	
	@ApiOperation(value="Salva um Unidade")
	@PostMapping
	public ResponseEntity<Unidade> cadastraUnidade(@RequestBody @Valid Unidade unidade) {
		Unidade unidad = unidadeService.save(unidade);
		if(unidad != null) {
			return ResponseEntity.status(HttpStatus.CREATED)
					.header(HttpHeaders.LOCATION, UriLocationBuilder.builder(unidad.getId()).toString())
					.body(unidad);
		}
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	@GetMapping
	public ResponseEntity<Collection<Unidade>> findAll(){
		return ResponseEntity.ok(unidadeService.findAll());
	}
	
	@ApiOperation(value="Retorna um Unidade com base no id")
	@GetMapping(value = "/{id}")
	public ResponseEntity<Unidade> listaUnidade(@PathVariable(value="id") Integer id){
		Unidade unidade = unidadeService.findOne(id);
		if(unidade != null){
			return new ResponseEntity<>(unidade, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

	@ApiOperation(value = "Atualiza um Unidade")
	@PutMapping
	public ResponseEntity<Unidade> atualizaUnidade(@RequestBody @Valid Unidade unidade){
		Unidade unidad = unidadeService.update(unidade);
		if(unidad != null) {
			return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.LOCATION, UriLocationBuilder.builder(unidad.getId()).toString())
					.body(unidad);
		}
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	@ApiOperation(value="Deleta um Unidade com base no id")
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Unidade> deletaUnidade(@PathVariable("id") Integer id) {
		if (unidadeService.delete(id)) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<>(HttpStatus.NO_CONTENT);
	}
	
	@ApiOperation(value="Retorna todos os RISCOS de uma Unidade com base no id_unidade")
	@GetMapping(value = "/{id}/riscos")
	public ResponseEntity<List<Risco>> listaRiscosUnidade(@PathVariable(value="id") Integer id){
		List<Risco> riscos = unidadeService.listarRiscosUnidade(id);
		if(riscos != null){
			return new ResponseEntity<>(riscos, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	@ApiOperation(value="Retorna todos as ações de uma unidade")
	@GetMapping(value = "/{id}/acoes")
	public ResponseEntity<List<Acao>> listaAcoesUnidade(@PathVariable(value="id") Integer id){
		List<Acao> acoes = unidadeService.findAcoes(id);
		if(acoes != null){
			return new ResponseEntity<>(acoes, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	
}
