package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.AcaoPreventiva;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AcaoPreventivaRepository extends JpaRepository<AcaoPreventiva, Integer> {
}
