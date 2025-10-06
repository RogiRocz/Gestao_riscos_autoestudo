package br.ufc.quixada.npi.gestaoriscos.controller;

import java.util.List;
import java.util.Optional;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import br.ufc.quixada.npi.gestaoriscos.model.Impacto;
import br.ufc.quixada.npi.gestaoriscos.service.ImpactoService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/impactos")
public class ImpactoController {

	@Autowired
	private ImpactoService impactoService;

	@Autowired
	private PlanoService planoService;

	@GetMapping({"", "/"})
	public ResponseEntity<List<Impacto>> findByPlano(@RequestParam(value = "plano", required = false) Plano plano) {
		if (plano == null) {
			plano = planoService.findVigente();
		}
		return ResponseEntity.ok(impactoService.findByPlano(plano.getId()));
	}

	@PostMapping
	public ResponseEntity<Impacto> cadastrar(@RequestBody Impacto impacto){
		return ResponseEntity.status(HttpStatus.CREATED).body(impactoService.save(impacto));
	}

	@ApiOperation(value="Retorna um impacto com base no id")
	@GetMapping(value = "/{id}")
	public ResponseEntity<Impacto> find(@PathVariable(value="id") Integer id){
		Optional<Impacto> impacto = impactoService.findById(id);
		if(impacto.isPresent()){
			return new ResponseEntity<>(impacto.get(), HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}
	
	
	@PutMapping("/{id}")
	public ResponseEntity<Impacto> atualizar(@PathVariable("id") Impacto currentImpacto, @RequestBody Impacto impacto){
		if(currentImpacto == null) {
			return ResponseEntity.notFound().build();
		}
		currentImpacto.setNome(impacto.getNome());
		currentImpacto.setPeso(impacto.getPeso());
		currentImpacto.setDescricao(impacto.getDescricao());
		return ResponseEntity.ok(impactoService.save(currentImpacto));
	}



	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Impacto> delete(@PathVariable("id") Impacto impacto) {
		impactoService.delete(impacto);
		return new ResponseEntity<>(HttpStatus.OK);
	}

}
