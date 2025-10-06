package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoRisco;
import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface AvaliacaoService {

    Integer countRiscos(String nomeProbabilidade, String nomeImpacto);

    List<AvaliacaoRisco> findAll();

    AvaliacaoRisco save(AvaliacaoRisco avaliacaoRisco);

    Optional<AvaliacaoRisco> findById(Integer id);

    void delete(AvaliacaoRisco avaliacaoRisco);

    List<AvaliacaoRisco> find(Integer riscoId);

    AvaliacaoRisco findLast(Integer riscoId);

    Map<Integer, AvaliacaoRisco> buscaAvalicoesRecentes();

}
