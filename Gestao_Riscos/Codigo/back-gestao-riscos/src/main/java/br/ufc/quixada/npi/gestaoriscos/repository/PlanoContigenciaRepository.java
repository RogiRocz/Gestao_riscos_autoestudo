package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.PlanoContingencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PlanoContigenciaRepository extends JpaRepository<PlanoContingencia, Integer> {

    List<PlanoContingencia> findPlanoByRiscoId(@Param("id") Integer riscoId);
}
