package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.MonitoramentoAcao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MonitoramentoAcaoRepository extends JpaRepository<MonitoramentoAcao, Integer> {

    Integer countByAcaoPreventivaId(Integer acaoPreventiva);

}
