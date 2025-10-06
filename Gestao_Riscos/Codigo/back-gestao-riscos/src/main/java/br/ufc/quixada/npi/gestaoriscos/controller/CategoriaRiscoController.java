package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.CategoriaRisco;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.service.CategoriaRiscoService;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;

@RestController
@RequestMapping("/categorias")
public class CategoriaRiscoController {

	@Autowired
	private CategoriaRiscoService categoriaRiscoService;

	@Autowired
	private PlanoService planoService;

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<CategoriaRisco>> findByPlano(@RequestParam(name = "plano", required = false) Plano plano) {
		if (plano == null) {
			plano = planoService.findVigente();
		}
		return ResponseEntity.ok(categoriaRiscoService.findByPlano(plano.getId()));
	}

	
	
	@ApiOperation(value = "Salva uma categoria")
	@PostMapping
	public ResponseEntity<CategoriaRisco> cadastrarUmaCategoria(@RequestBody CategoriaRisco categoriaRisco){
		return ResponseEntity.status(HttpStatus.CREATED).body(categoriaRiscoService.save(categoriaRisco));
	}


	
	@PutMapping("/{id}")
	public ResponseEntity<CategoriaRisco> atualizar(@PathVariable("id") CategoriaRisco currentCategoria, @RequestBody CategoriaRisco categoriaRisco){
		if(currentCategoria == null) {
			return ResponseEntity.notFound().build();
		}
		currentCategoria.setNome(categoriaRisco.getNome());
		currentCategoria.setDescricao(categoriaRisco.getDescricao());
		return ResponseEntity.ok(categoriaRiscoService.save(currentCategoria));
	}
	
	
	
	@ApiOperation(value="Deleta uma categoria")
	@DeleteMapping(value="/{id}")
	public ResponseEntity<CategoriaRisco> delete(@PathVariable("id") Integer id) {
		categoriaRiscoService.delete(categoriaRiscoService.findById(id).get());
		return new ResponseEntity<>(HttpStatus.OK);
	}

}
