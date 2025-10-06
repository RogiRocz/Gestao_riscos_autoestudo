package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.Ocorrencia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OcorrenciaRepository extends JpaRepository<Ocorrencia, Integer> {

    List<Ocorrencia> findByRiscoId(Integer riscoId);
}
