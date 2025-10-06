package br.ufc.quixada.npi.gestaoriscos.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import br.ufc.quixada.npi.gestaoriscos.model.CategoriaRisco;

import java.util.List;

@Repository
public interface CategoriaRiscoRepository extends JpaRepository<CategoriaRisco, Integer> {

    List<CategoriaRisco> findByPlanoId(Integer planoId);

}
