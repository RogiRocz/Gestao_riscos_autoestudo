package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoControle;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.service.AvaliacaoControleService;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/avaliacoesControle")
public class AvaliacaoControleController {

	@Autowired
	private AvaliacaoControleService avaliacaoControleService;

	@Autowired
	private PlanoService planoService;

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<AvaliacaoControle>> findByPlano(@RequestParam(name = "plano", required = false) Plano plano) {
		if (plano == null) {
			plano = planoService.findVigente();
		}
		return ResponseEntity.ok(avaliacaoControleService.findByPlano(plano.getId()));
	}

	@PostMapping
	public ResponseEntity<AvaliacaoControle> cadastrar(@RequestBody AvaliacaoControle avaliacao){
		return ResponseEntity.status(HttpStatus.CREATED).body(avaliacaoControleService.save(avaliacao));
	}

	@ApiOperation(value = "Lista de Avaliações de Controle de um Plano")
	@GetMapping("/listar/{id}")
	public ResponseEntity<List<AvaliacaoControle>> listarAvaliacoesControle(@PathVariable("id") Integer planoId) {
		List<AvaliacaoControle> avaliacoesControle = avaliacaoControleService.findByPlano(planoId);

		return new ResponseEntity<>(avaliacoesControle, HttpStatus.OK);
	}

	@ApiOperation(value="Retorna uma avaliação de controle com base no id")
	@GetMapping(value = "/{id}")
	public ResponseEntity<AvaliacaoControle> find(@PathVariable(value="id") Integer id){
		Optional<AvaliacaoControle> avaliacaoControle = avaliacaoControleService.findById(id);
		if(avaliacaoControle.isPresent()){
			return new ResponseEntity<>(avaliacaoControle.get(), HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

	@ApiOperation(value="Atualiza uma Avaliação de Controle")
	@PutMapping("/{id}")
	public ResponseEntity<AvaliacaoControle> atualizar(@PathVariable("id") AvaliacaoControle currentAvaliacao, @RequestBody AvaliacaoControle avaliacaoControle){
		if(currentAvaliacao == null) {
			return ResponseEntity.notFound().build();
		}
		currentAvaliacao.setDescricao(avaliacaoControle.getDescricao());
		currentAvaliacao.setFator(avaliacaoControle.getFator());
		currentAvaliacao.setNome(avaliacaoControle.getNome());
		return ResponseEntity.ok(avaliacaoControleService.save(currentAvaliacao));
	}

	@DeleteMapping(value = "/{id}")
	public ResponseEntity<AvaliacaoControle> delete(@PathVariable("id") AvaliacaoControle avaliacaoControle) {
		avaliacaoControleService.delete(avaliacaoControle);
		return new ResponseEntity<>(HttpStatus.OK);
	}

}
