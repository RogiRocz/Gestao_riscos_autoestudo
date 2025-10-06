package br.ufc.quixada.npi.gestaoriscos.service;

import org.springframework.stereotype.Service;
import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoRisco;

import java.util.List;
import java.util.Optional;

@Service
public interface AvaliacaoRiscoService {

	AvaliacaoRisco save(AvaliacaoRisco avaliacaoRisco);

	List<AvaliacaoRisco> findAll();
	 
	List<AvaliacaoRisco> buscarAvaliacoesRisco(Integer riscoId);
	
	Optional<AvaliacaoRisco> findById(Integer id);

	AvaliacaoRisco update(AvaliacaoRisco avaliacaoRisco);

	void delete(AvaliacaoRisco avaliacaoRisco);
	
	List<AvaliacaoRisco> buscaAvalicoesRecentes();

	AvaliacaoRisco findAvaliacaoRecente(Integer id);

}
