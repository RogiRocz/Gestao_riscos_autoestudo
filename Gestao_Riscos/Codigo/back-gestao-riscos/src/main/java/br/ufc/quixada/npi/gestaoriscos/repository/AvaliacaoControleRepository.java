package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoControle;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface AvaliacaoControleRepository extends JpaRepository<AvaliacaoControle, Integer> {

    @Query("SELECT new AvaliacaoControle(f.id, f.nome, f.descricao, f.fator) FROM AvaliacaoControle f WHERE f.plano.id = :id ORDER BY f.fator ASC")
    List<AvaliacaoControle> findByPlanoId(@Param("id") Integer planoId);

}
