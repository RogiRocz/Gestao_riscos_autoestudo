package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PlanoRepository extends JpaRepository<Plano, Integer> {

    @Query("SELECT new Plano(p.id, p.nome, p.descricao, p.dataInicio, p.dataFim) FROM Plano p")
    List<Plano> findAll();

    Plano findFirstByOrderByDataFimDesc();

    Optional<Plano> findById(Integer id);
}
