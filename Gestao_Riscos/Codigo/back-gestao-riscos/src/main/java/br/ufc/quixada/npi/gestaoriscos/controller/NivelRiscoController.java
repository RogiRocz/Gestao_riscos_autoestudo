package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.NivelRisco;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.service.NivelRiscoService;
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
@RequestMapping("/niveisRisco")
public class NivelRiscoController {

    @Autowired
    private NivelRiscoService nivelRiscoService;

    @Autowired
    private PlanoService planoService;

    @GetMapping({"", "/"})
    public ResponseEntity<Collection<NivelRisco>> findByPlano(@RequestParam(name = "plano", required = false) Plano plano) {
        if (plano == null) {
            plano = planoService.findVigente();
        }
        return ResponseEntity.ok(nivelRiscoService.findByPlano(plano.getId()));
    }

    @PostMapping
    public ResponseEntity<NivelRisco> cadastrar(@RequestBody NivelRisco impacto){
    	if(nivelRiscoService.checkConflitoIntervalo(impacto)) {
    		return ResponseEntity.badRequest().build();
    	}
        return ResponseEntity.status(HttpStatus.CREATED).body(nivelRiscoService.save(impacto));
    }

    @ApiOperation(value = "Lista Niveis de Risco de uma Política")
    @GetMapping("/listar/{id}")
    public ResponseEntity<List<NivelRisco>> listarNiveisRiscoPlano(@PathVariable("id") Integer planoId) {
        List<NivelRisco> niveisRisco = nivelRiscoService.findByPlano(planoId);

        return new ResponseEntity<>(niveisRisco, HttpStatus.OK);
    }

    @ApiOperation(value="Retorna um nível de risco com base no id")
    @GetMapping(value = "/{id}")
    public ResponseEntity<NivelRisco> find(@PathVariable(value="id") Integer id){
        Optional<NivelRisco> nivelRisco = nivelRiscoService.findById(id);
        if(nivelRisco.isPresent()){
            return new ResponseEntity<>(nivelRisco.get(), HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<NivelRisco> delete(@PathVariable("id") NivelRisco nivelRisco) {
        nivelRiscoService.delete(nivelRisco);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<NivelRisco> atualizar(@PathVariable("id") NivelRisco currentNivelRisco, @RequestBody NivelRisco nivelRisco){
    	if(currentNivelRisco == null) {
    		return ResponseEntity.notFound().build();
    	}
    	currentNivelRisco.setCor(nivelRisco.getCor());
    	currentNivelRisco.setNome(nivelRisco.getNome());
    	currentNivelRisco.setDescricao(nivelRisco.getDescricao());
    	currentNivelRisco.setPeriodicidade(nivelRisco.getPeriodicidade());
    	currentNivelRisco.setValorInicial(nivelRisco.getValorInicial());
    	currentNivelRisco.setValorFinal(nivelRisco.getValorFinal());
    	currentNivelRisco.removeAllRespostaRisco();
    	currentNivelRisco.addAllRespostasRisco(nivelRisco.getRespostasRisco());

    	return ResponseEntity.ok(nivelRiscoService.save(currentNivelRisco));
    }
}
