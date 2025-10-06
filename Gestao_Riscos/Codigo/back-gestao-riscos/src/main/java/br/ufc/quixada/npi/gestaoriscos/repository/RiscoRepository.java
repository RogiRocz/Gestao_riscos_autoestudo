package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import br.ufc.quixada.npi.gestaoriscos.model.Risco;

import java.util.List;

@Repository
public interface RiscoRepository extends JpaRepository<Risco, Integer> {

    @Query(value = "SELECT * FROM risco as r JOIN unidade as u ON r.unidade_id = u.id WHERE u.sigla = :siglaUnidade", nativeQuery = true)
    List<Risco> buscaRiscoUnidade(@Param("siglaUnidade") String siglaUnidade);

    List<Risco> findByPlanoAndUnidade(Plano plano, Unidade unidade);

	List<Risco> findByAcoes(Acao acao);

}

