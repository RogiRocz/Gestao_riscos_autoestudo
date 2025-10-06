package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Risco;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;

import java.util.List;

public interface UnidadeService {

	Unidade save(Unidade unidade);

	List<Unidade> findAll();

	Unidade findOne(Integer id);
	
	Unidade update(Unidade unidade);
		
	Boolean delete(Integer id);
	
	List<Risco> listarRiscosUnidade(Integer id);

	List<Acao> findAcoes(Integer id);

}
