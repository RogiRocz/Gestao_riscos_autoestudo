package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.PlanoTratamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlanoDeTratamentoRepository extends JpaRepository<PlanoTratamento, Integer> {

    List<PlanoTratamento> findByRiscoIdOrderByStatusDescDataPlanejamentoDesc(Integer risco);
}
