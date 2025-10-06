package br.ufc.quixada.npi.gestaoriscos.service;

import java.util.List;
import java.util.Optional;

import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.model.AreaAtuacao;

@Service
public interface AreaAtuacaoService {

	AreaAtuacao save(AreaAtuacao areaAtuacao); 
	
	List<AreaAtuacao> find(Plano plano);

	AreaAtuacao update(AreaAtuacao areaAtuacao);

	Optional<AreaAtuacao> findById(Integer id);
	
	void delete(AreaAtuacao areaAtuacao);
}
