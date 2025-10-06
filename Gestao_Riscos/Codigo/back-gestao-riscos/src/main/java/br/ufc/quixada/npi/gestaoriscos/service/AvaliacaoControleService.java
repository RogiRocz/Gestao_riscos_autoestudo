package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoControle;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface AvaliacaoControleService {

	AvaliacaoControle save(AvaliacaoControle avaliacaoControle);

	List<AvaliacaoControle> findByPlano(Integer planoId);

	List<AvaliacaoControle> findAll();

	AvaliacaoControle update(AvaliacaoControle avaliacaoControle);

	Optional<AvaliacaoControle> findById(Integer id);

	void delete(AvaliacaoControle avaliacaoControle);


}
