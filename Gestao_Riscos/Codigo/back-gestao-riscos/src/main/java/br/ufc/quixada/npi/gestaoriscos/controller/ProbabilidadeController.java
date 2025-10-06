package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.Probabilidade;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import br.ufc.quixada.npi.gestaoriscos.service.ProbabilidadeService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/probabilidades")
public class ProbabilidadeController {

	@Autowired
	private ProbabilidadeService  probabilidadeService;
	@Autowired
	private PlanoService planoService;

	@GetMapping({"", "/"})
	public ResponseEntity<List<Probabilidade>> findByPlano(@RequestParam(name = "plano", required = false) Plano plano) {
		if (plano == null) {
			plano = planoService.findVigente();
		}
		return ResponseEntity.ok(probabilidadeService.findByPlano(plano.getId()));
	}

	@PostMapping
	public ResponseEntity<Probabilidade> cadastrar(@RequestBody Probabilidade probabilidade){
		return ResponseEntity.status(HttpStatus.CREATED).body(probabilidadeService.save(probabilidade));
	}

	@ApiOperation(value="Retorna uma probabilidade com base no id")
	@GetMapping(value = "/{id}")
	public ResponseEntity<Probabilidade> find(@PathVariable(value="id") Integer id){
		Optional<Probabilidade> probabilidade = probabilidadeService.findById(id);
		if(probabilidade.isPresent()){
			return new ResponseEntity<>(probabilidade.get(), HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

	
	@PutMapping("/{id}")
	public ResponseEntity<Probabilidade> atualizar(@PathVariable("id") Probabilidade currentProbabilidade, @RequestBody Probabilidade probabilidade){
		if(currentProbabilidade == null) {
			return ResponseEntity.notFound().build();
		}
		currentProbabilidade.setNome(probabilidade.getNome());
		currentProbabilidade.setPeso(probabilidade.getPeso());
		currentProbabilidade.setDescricao(probabilidade.getDescricao());
		return ResponseEntity.ok(probabilidadeService.save(currentProbabilidade));
	}

	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Probabilidade> delete(@PathVariable("id") Probabilidade probabilidade) {
		probabilidadeService.delete(probabilidade);
		return new ResponseEntity<>(HttpStatus.OK);
	}

}

