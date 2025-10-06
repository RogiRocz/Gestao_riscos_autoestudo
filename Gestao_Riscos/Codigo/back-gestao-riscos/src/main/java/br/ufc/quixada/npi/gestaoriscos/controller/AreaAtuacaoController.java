package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.AreaAtuacao;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.service.AreaAtuacaoService;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;

@RestController
@RequestMapping("/areas-atuacao")
public class AreaAtuacaoController {

	@Autowired
	private AreaAtuacaoService areaAtuacaoService;

	@Autowired
	private PlanoService planoService;
	
	@GetMapping({"", "/"})
	public ResponseEntity<Collection<AreaAtuacao>> findByPlano(@RequestParam(required = false, name = "plano") Plano plano) {
		if (plano == null) {
			plano = planoService.findVigente();
		}
		return ResponseEntity.ok(areaAtuacaoService.find(plano));
	}
	
	@PostMapping
	public ResponseEntity<AreaAtuacao> save(@RequestBody AreaAtuacao areaAtuacao){
		return ResponseEntity.status(HttpStatus.CREATED).body(areaAtuacaoService.save(areaAtuacao));
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<AreaAtuacao> delete(@PathVariable("id") AreaAtuacao areaAtuacao) {
		areaAtuacaoService.delete(areaAtuacao);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<AreaAtuacao> atualizar(@PathVariable("id") AreaAtuacao currentArea, @RequestBody AreaAtuacao areaAtuacao){
		if(currentArea == null) {
			return ResponseEntity.notFound().build();
		}
		currentArea.setNome(areaAtuacao.getNome());
		currentArea.setDescricao(areaAtuacao.getDescricao());
		return ResponseEntity.ok(areaAtuacaoService.save(currentArea));
	}
}
