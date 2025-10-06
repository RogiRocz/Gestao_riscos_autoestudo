package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.NivelRisco;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface NivelRiscoService {

    Integer countNiveis(Float riscoInerente);

    List<NivelRisco> findAll();

    NivelRisco save(NivelRisco nivelRisco);

    List<NivelRisco> findByPlano(Integer planoId);

    Optional<NivelRisco> findById(Integer id);

    void delete(NivelRisco nivelRisco);
    
    boolean checkConflitoIntervalo(NivelRisco nivelRisco);
}
