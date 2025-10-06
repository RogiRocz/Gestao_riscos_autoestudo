package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.RespostaRisco;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import br.ufc.quixada.npi.gestaoriscos.service.RespostaRiscoService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/respostas")
public class RespostaRiscoController {

    @Autowired
    private RespostaRiscoService respostaRiscoService;

    @Autowired
    private PlanoService planoService;

    @GetMapping({"", "/"})
    public ResponseEntity<List<RespostaRisco>> findByPlano(@RequestParam(name = "plano", required = false) Plano plano) {
        if (plano == null) {
            plano = planoService.findVigente();
        }
        return ResponseEntity.ok(respostaRiscoService.findByPlano(plano.getId()));
    }

    @PostMapping
    public ResponseEntity<RespostaRisco> cadastrar(@RequestBody RespostaRisco resposta){
    	if(!(resposta.isAmeaca() || resposta.isOportunidade())) {
    		return ResponseEntity.badRequest().build();
    	}
        return ResponseEntity.status(HttpStatus.CREATED).body(respostaRiscoService.save(resposta));
    }

    @ApiOperation(value="Retorna um tratamento de risco com base no id")
    @GetMapping(value = "/{id}")
    public ResponseEntity<RespostaRisco> find(@PathVariable(value="id") Integer id){
        Optional<RespostaRisco> respostaRisco = respostaRiscoService.findById(id);
        if(respostaRisco.isPresent()){
            return new ResponseEntity<>(respostaRisco.get(), HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @PutMapping("/{id}")
    public ResponseEntity<RespostaRisco> atualizar(@PathVariable("id") RespostaRisco currentResposta, @RequestBody RespostaRisco respostaRisco){
    	if(currentResposta == null) {
    		return ResponseEntity.notFound().build();
    	}
    	currentResposta.setNome(respostaRisco.getNome());
    	currentResposta.setDescricao(respostaRisco.getDescricao());
    	currentResposta.setAmeaca(respostaRisco.isAmeaca());
    	currentResposta.setOportunidade(respostaRisco.isOportunidade());
    	currentResposta.setPlanoTratamento(respostaRisco.isPlanoTratamento());
    	currentResposta.setCompartilhavel(respostaRisco.isCompartilhavel());

    	return ResponseEntity.ok(respostaRiscoService.save(currentResposta));
    }

    @DeleteMapping(value = "/{id}")
    public ResponseEntity<RespostaRisco> delete(@PathVariable("id") RespostaRisco respostaRisco) {
        respostaRiscoService.delete(respostaRisco);
        return new ResponseEntity<>(HttpStatus.OK);
    }

}
