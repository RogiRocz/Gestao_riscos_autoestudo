package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.ufc.quixada.npi.gestaoriscos.model.AreaAtuacao;
import java.util.List;


@Repository
public interface AreaAtuacaoRepository extends JpaRepository<AreaAtuacao, Integer>{

    List<AreaAtuacao> findByPlano(Plano plano);

}
