package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.*;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoTratamentoService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import java.util.Collection;
import java.util.Optional;

@RestController
@RequestMapping("/tratamentos")
public class PlanoTratamentoController {
	
	@Autowired
	private PlanoTratamentoService planoTratamentoService;

	@PostMapping("{risco}")
	public ResponseEntity<PlanoTratamento> cadastrarPlanoDeTratamento(@PathVariable Risco risco, @RequestBody PlanoTratamento planoTratamento,
																	  @AuthenticationPrincipal Usuario usuario){
		if (risco == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
		planoTratamento.setRisco(risco);
		planoTratamento.setUnidade(usuario.getUnidade());
		planoTratamentoService.save(planoTratamento);
		return ResponseEntity.status(HttpStatus.CREATED).body(planoTratamento);
	}

	@GetMapping({"", "/"})
	public ResponseEntity<Collection<PlanoTratamento>> findByRisco(@RequestParam("risco") Integer riscoId) {
		return ResponseEntity.ok(planoTratamentoService.find(riscoId));
	}

	@GetMapping(value = "/{id}")
	public ResponseEntity<PlanoTratamento> find(@PathVariable("id") PlanoTratamento tratamento){
		if(tratamento != null){
			return new ResponseEntity<>(tratamento, HttpStatus.OK);
		}
		return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	}

    @GetMapping("/acoesPreventivas/{id}")
    public ResponseEntity<AcaoPreventiva> findAcaoPreventiva(@PathVariable("id") AcaoPreventiva acaoPreventiva) {
        if (acaoPreventiva == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        return ResponseEntity.status(HttpStatus.OK).body(acaoPreventiva);
    }

	@PostMapping("/acoesPreventivas/{id}/monitoramentos")
	public ResponseEntity<MonitoramentoAcao> cadastrarMonitoramento(@PathVariable("id") AcaoPreventiva acaoPreventiva,
			@RequestBody MonitoramentoAcao monitoramento){
		if (acaoPreventiva == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
		monitoramento.setAcaoPreventiva(acaoPreventiva);
		return ResponseEntity.status(HttpStatus.CREATED).body(planoTratamentoService.save(monitoramento));
	}

	@PostMapping("/acoesPreventivas/{id}/finalizar")
    public ResponseEntity<AcaoPreventiva> finalizarAcaoPreventiva(@PathVariable("id") AcaoPreventiva acaoPreventiva) {
        if (acaoPreventiva == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        acaoPreventiva.setStatus(AcaoPreventiva.Status.FINALIZADA);
        return ResponseEntity.status(HttpStatus.OK).body(planoTratamentoService.save(acaoPreventiva));
    }

    @PostMapping("/acoesPreventivas/{id}/cancelar")
    public ResponseEntity<AcaoPreventiva> cancelarAcaoPreventiva(@PathVariable("id") AcaoPreventiva acaoPreventiva) {
        if (acaoPreventiva == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        acaoPreventiva.setStatus(AcaoPreventiva.Status.CANCELADA);
        return ResponseEntity.status(HttpStatus.OK).body(planoTratamentoService.save(acaoPreventiva));
    }

	@ApiOperation(value="Edita um Plano de Tratamento com base no id")
	@PutMapping("/{id}")
	public ResponseEntity<PlanoTratamento> update(@RequestBody PlanoTratamento plano, @PathVariable Integer id) {
		Optional<PlanoTratamento> planoOptional = planoTratamentoService.findById(id);
		if (!planoOptional.isPresent()) {
			return ResponseEntity.notFound().build();
		}
		PlanoTratamento planoOriginal = planoOptional.get();
		planoOriginal.setJustificativa((planoOriginal.getJustificativa() != null) ? plano.getJustificativa() : planoOriginal.getJustificativa());
		planoOriginal.setMonitoramento((planoOriginal.getMonitoramento() != null) ? plano.getMonitoramento() : planoOriginal.getMonitoramento());
		planoOriginal.setInicio((planoOriginal.getInicio() != null) ? plano.getInicio() : planoOriginal.getInicio());
		planoOriginal.setTermino((planoOriginal.getTermino() == null) ? plano.getTermino() : planoOriginal.getTermino());
		planoOriginal.setDataPlanejamento((planoOriginal.getDataPlanejamento() != null) ? plano.getDataPlanejamento() : planoOriginal.getDataPlanejamento());
		planoOriginal.setResposta((planoOriginal.getResposta() != null) ? plano.getResposta() : planoOriginal.getResposta());

		planoTratamentoService.update(planoOriginal);
		return ResponseEntity.noContent().build();

	}

	@ApiOperation(value="Deleta um plano de tratamento com base no id")
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<PlanoTratamento> delete(@PathVariable("id") PlanoTratamento plano) {
		planoTratamentoService.delete(plano);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
