package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.RespostaRisco;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface RespostaRiscoService {

    RespostaRisco save(RespostaRisco respostaRisco);

    List<RespostaRisco> findByPlano(Integer planoId);

    Optional<RespostaRisco> findById(Integer id);

    RespostaRisco update(RespostaRisco respostaRisco);

    void delete(RespostaRisco respostaRisco);
}
