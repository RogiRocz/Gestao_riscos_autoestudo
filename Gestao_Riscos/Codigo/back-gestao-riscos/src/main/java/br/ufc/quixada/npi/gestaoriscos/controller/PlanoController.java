package br.ufc.quixada.npi.gestaoriscos.controller;

import br.ufc.quixada.npi.gestaoriscos.model.*;
import br.ufc.quixada.npi.gestaoriscos.service.*;
import br.ufc.quixada.npi.gestaoriscos.utils.UriLocationBuilder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.Collection;
import java.util.Optional;

@RestController
@RequestMapping("/planos")
public class PlanoController {

    @Autowired
    private PlanoService planoService;

    @ApiOperation(value="Busca todas as políticas cadastradas")
    @GetMapping({"", "/"})
    public ResponseEntity<Collection<Plano>> findAll() {
        return ResponseEntity.ok(planoService.findAll());
    }
    
    
    @GetMapping({"/vigente"})
    public ResponseEntity<Plano> findPlanoVigente() {
    	return ResponseEntity.ok(planoService.findVigente());
    }

    @GetMapping(value = "/{id}")
    public ResponseEntity<Plano> find(@PathVariable(value = "id") Plano plano) {
        if (plano != null) {
            return new ResponseEntity<>(plano, HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    @ApiOperation(value="Salva uma Plano")
    @PostMapping
    public ResponseEntity<Plano> cadastrarPlano(@RequestBody @Valid Plano plano){
        Plano plano2 = planoService.save(plano);
        if(plano2 != null) {
            return ResponseEntity.status(HttpStatus.CREATED)
                    .header(HttpHeaders.LOCATION, UriLocationBuilder.builder(plano2.getId()).toString())
                    .body(plano2);
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @ApiOperation(value="Atualiza uma Plano")
    @PutMapping("/{id}")
    public ResponseEntity<Plano> update(@PathVariable Integer id, @RequestBody Plano plano) {
        Optional<Plano> planoOptional = planoService.findById(id);
        if (!planoOptional.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        Plano planoOriginal = planoOptional.get();
        planoOriginal.setNome((plano.getNome() != null) ? plano.getNome() : planoOriginal.getNome());
        planoOriginal.setDescricao((plano.getDescricao() != null) ? plano.getDescricao() : planoOriginal.getDescricao());
        planoOriginal.setDataInicio((plano.getDataInicio() != null) ? plano.getDataInicio() : planoOriginal.getDataInicio());
        planoOriginal.setDataFim((plano.getDataFim() != null) ? plano.getDataFim() : planoOriginal.getDataFim());
        planoService.save(planoOriginal);
        return ResponseEntity.noContent().build();

    }

    @ApiOperation(value="Deleta uma Política com base no id")
    @DeleteMapping(value = "/{id}")
    public ResponseEntity<Plano> delete(@PathVariable("id") Plano plano) {
        planoService.delete(plano);
        return new ResponseEntity<>(HttpStatus.OK);
    }



}
