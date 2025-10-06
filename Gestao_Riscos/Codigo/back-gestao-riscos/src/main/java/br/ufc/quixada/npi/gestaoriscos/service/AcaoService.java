package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import br.ufc.quixada.npi.gestaoriscos.model.Usuario;

import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public interface AcaoService {

	Acao save(Acao acao);

	List<Acao> findAll();

	Acao update(Acao acao);

	Acao findById(Integer id);
	
	List<Acao> findByUnidade(Plano plano, Unidade unidade);

	void delete(Acao acao);


}
