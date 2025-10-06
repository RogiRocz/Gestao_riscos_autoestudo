package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoRisco;
import br.ufc.quixada.npi.gestaoriscos.model.Risco;
import br.ufc.quixada.npi.gestaoriscos.model.Usuario;
import br.ufc.quixada.npi.gestaoriscos.service.AvaliacaoService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/avaliacoes")
public class AvaliacaoController {

	@Autowired
	private AvaliacaoService avaliacaoService;

	@PostMapping
	public ResponseEntity<AvaliacaoRisco> cadastraAvaliacao(@RequestBody AvaliacaoRisco avaliacaoRisco,
															@AuthenticationPrincipal Usuario usuario) {
		avaliacaoRisco.setResponsavel(usuario);
		return ResponseEntity.status(HttpStatus.CREATED).body(avaliacaoService.save(avaliacaoRisco));
	}

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<AvaliacaoRisco>> findByRisco(@RequestParam("risco") Integer riscoId) {
		return ResponseEntity.ok(avaliacaoService.find(riscoId));
	}

	@GetMapping("/last")
	public ResponseEntity<AvaliacaoRisco> findLastByRisco(@RequestParam("risco") Integer riscoId) {
		return ResponseEntity.ok(avaliacaoService.findLast(riscoId));
	}

	@GetMapping({"/avaliacoesRecentes"})
	public ResponseEntity<Map<Integer, AvaliacaoRisco>> buscaAvalicoesRecentes(@AuthenticationPrincipal UserDetails userDetails) {
		return ResponseEntity.ok(avaliacaoService.buscaAvalicoesRecentes());
	}


	@ApiOperation(value="Retorna uma Avaliacao com base no id")
	@GetMapping(value = "/{id}")
	public ResponseEntity<AvaliacaoRisco> find(@PathVariable(value="id") Integer id){
		Optional<AvaliacaoRisco> avaliacaoRisco = avaliacaoService.findById(id);
		if(avaliacaoRisco.isPresent()){
			return new ResponseEntity<>(avaliacaoRisco.get(), HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}


	/*@ApiOperation(value="Retorna uma Avaliacao com base no id do risco")
	@GetMapping(value = "/avaliacaoRecente/{id}")
	public ResponseEntity<AvaliacaoRisco> findAvaliacaoRecente(@PathVariable(value="id") Integer id){
		Optional<AvaliacaoRisco> avaliacaoRisco = avaliacaoService.findAvaliacaoRecente(id);
		if(avaliacaoRisco.isPresent()){
			return new ResponseEntity<>(avaliacaoRisco.get(), HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}*/

	@GetMapping("/listar/{id}")
	public ResponseEntity<List<AvaliacaoRisco>> buscarAvaliacoesRisco(@PathVariable("id") Integer riscoId) {
		List<AvaliacaoRisco> avaliacoesRisco = avaliacaoService.find(riscoId);
		return new ResponseEntity<>(avaliacoesRisco, HttpStatus.OK);
	}

	@PutMapping("/{id}")
	public ResponseEntity<AvaliacaoRisco> update(@RequestBody AvaliacaoRisco avaliacaoRisco, @PathVariable Integer id) {
		Optional<AvaliacaoRisco> avaliacaoOptional = avaliacaoService.findById(id);
		if (!avaliacaoOptional.isPresent()) {
			return ResponseEntity.notFound().build();
		}

		AvaliacaoRisco avaliacaoOriginal = avaliacaoOptional.get();
		avaliacaoOriginal.setProbabilidade((avaliacaoOriginal.getProbabilidade() != null) ? avaliacaoRisco.getProbabilidade() : avaliacaoOriginal.getProbabilidade());
		avaliacaoOriginal.setImpacto((avaliacaoOriginal.getImpacto() != null) ? avaliacaoRisco.getImpacto() : avaliacaoOriginal.getImpacto());
		avaliacaoOriginal.setAvaliacaoControle((avaliacaoOriginal.getAvaliacaoControle() != null) ? avaliacaoRisco.getAvaliacaoControle() : avaliacaoOriginal.getAvaliacaoControle());
		avaliacaoOriginal.setData((avaliacaoOriginal.getData() != null) ? avaliacaoRisco.getData() : avaliacaoOriginal.getData());
		avaliacaoService.save(avaliacaoOriginal);
		return ResponseEntity.noContent().build();

	}

	@ApiOperation(value="Deleta uma Avaliacao com base no id")
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<AvaliacaoRisco> delete(@PathVariable("id") AvaliacaoRisco avaliacaoRisco) {
		avaliacaoService.delete(avaliacaoRisco);
		return new ResponseEntity<>(HttpStatus.OK);
	}

	@ApiOperation(value = "Conta a quantidade de risco")
	@GetMapping({"/contarRiscos"})
	public ResponseEntity<Integer> countRiscos( @RequestParam("nomeProbabilidade") String nomeProbabilidade,  @RequestParam("nomeImpacto") String nomeImpacto) {
		return ResponseEntity.ok(avaliacaoService.countRiscos(nomeProbabilidade, nomeImpacto));
	}

}
