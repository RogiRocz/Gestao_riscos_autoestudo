package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoControle;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.repository.AvaliacaoControleRepository;
import br.ufc.quixada.npi.gestaoriscos.service.AvaliacaoControleService;

import java.util.List;
import java.util.Optional;

@Service
public class AvaliacaoControleServiceImpl implements AvaliacaoControleService {

	@Autowired
	private AvaliacaoControleRepository avaliacaoControleRepository;

	@Autowired
	private PlanoService planoService;

	@Override
	public AvaliacaoControle save(AvaliacaoControle avaliacaoControle) {
		avaliacaoControle.setPlano(planoService.findVigente());
		return avaliacaoControleRepository.save(avaliacaoControle);
	}

	@Override
	public List<AvaliacaoControle> findByPlano(Integer planoId) {
		return avaliacaoControleRepository.findByPlanoId(planoId);
	}

	@Override
	public List<AvaliacaoControle> findAll() {
		return avaliacaoControleRepository.findAll();
	}

	@Override
	public AvaliacaoControle update(AvaliacaoControle avaliacaoControle) {
		return avaliacaoControleRepository.save(avaliacaoControle);
	}

	@Override
	public Optional<AvaliacaoControle> findById(Integer id) {
		return avaliacaoControleRepository.findById(id);
	}

	@Override
	public void delete(AvaliacaoControle avaliacaoControle) {
		avaliacaoControleRepository.delete(avaliacaoControle);
	}

}
