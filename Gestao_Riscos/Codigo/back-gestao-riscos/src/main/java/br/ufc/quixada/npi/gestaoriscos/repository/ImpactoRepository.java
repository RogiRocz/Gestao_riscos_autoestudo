package br.ufc.quixada.npi.gestaoriscos.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import br.ufc.quixada.npi.gestaoriscos.model.Impacto;

import java.util.List;

@Repository
public interface ImpactoRepository extends JpaRepository<Impacto, Integer> {

    @Query("SELECT new Impacto(i.id, i.nome, i.descricao, i.peso) FROM Impacto i WHERE i.plano.id = :id ORDER BY i.peso ASC")
    List<Impacto> findByPlano(@Param("id") Integer planoId);

    @Query("SELECT new Impacto(i.id, i.nome, i.descricao, i.peso) FROM Impacto i ORDER BY i.peso ASC")
    List<Impacto> findAll();

}
