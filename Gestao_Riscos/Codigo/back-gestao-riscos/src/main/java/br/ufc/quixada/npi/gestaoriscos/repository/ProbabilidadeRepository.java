package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.Probabilidade;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProbabilidadeRepository extends JpaRepository<Probabilidade, Integer> {

    @Query("SELECT new Probabilidade(p.id, p.nome, p.descricao, p.peso) FROM Probabilidade p WHERE p.plano.id = :id ORDER BY p.peso ASC")
    List<Probabilidade> findByPlano(@Param("id") Integer planoId);

    @Query("SELECT new Probabilidade(p.id, p.nome, p.descricao, p.peso) FROM Probabilidade p ORDER BY p.peso ASC")
    List<Probabilidade> findAll();
}
