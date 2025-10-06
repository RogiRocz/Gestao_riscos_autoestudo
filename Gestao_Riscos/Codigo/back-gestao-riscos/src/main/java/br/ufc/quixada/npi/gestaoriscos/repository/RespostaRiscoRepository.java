package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.RespostaRisco;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RespostaRiscoRepository extends JpaRepository<RespostaRisco, Integer> {

    List<RespostaRisco> findByPlanoId(Integer planoId);

}
