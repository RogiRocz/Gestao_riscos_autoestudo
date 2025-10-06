package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoRisco;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AvaliacaoRepository extends JpaRepository<AvaliacaoRisco, Integer> {

    List<AvaliacaoRisco> findByRiscoIdOrderByDataDesc(Integer risco);

    AvaliacaoRisco findFirstByRiscoIdOrderByDataDesc(@Param("id") Integer riscoId);

    @Query(value = "select * from\n" +
            "        (select risco_id, max(data) as d from avaliacao_risco group by risco_id) as x, avaliacao_risco \n" +
            "        where avaliacao_risco.risco_id = x.risco_id and avaliacao_risco.data = x.d", nativeQuery = true)
    List<AvaliacaoRisco> buscaAvalicoesRecentes();

    @Query(value = "select * from\n" +
            "        (select risco_id, max(data) as d from avaliacao_risco group by risco_id) as x, avaliacao_risco as a JOIN impacto as i ON a.impacto_id = i.id JOIN probabilidade as p ON a.probabilidade_id = p.id \n" +
            "        where a.risco_id = x.risco_id and a.data = x.d and  p.nome = :nomeProbabilidade and i.nome = :nomeImpacto", nativeQuery = true)
    List<AvaliacaoRisco> findRiscoValor(@Param("nomeProbabilidade") String nomeProbabilidade, @Param("nomeImpacto") String nomeImpacto);

}
