package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import br.ufc.quixada.npi.gestaoriscos.model.Usuario;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AcaoRepository extends JpaRepository<Acao, Integer> {

	List<Acao> findByPlanoAndUnidade(Plano plano, Unidade unidade);

}
