package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.model.Probabilidade;
import br.ufc.quixada.npi.gestaoriscos.repository.ProbabilidadeRepository;
import br.ufc.quixada.npi.gestaoriscos.service.ProbabilidadeService;

import java.util.List;
import java.util.Optional;

@Service
public class ProbabilidadeServiceImpl implements ProbabilidadeService {

	@Autowired
	private ProbabilidadeRepository probabilidadeRepository;

	@Autowired
	private PlanoService planoService;

	@Override
	public Probabilidade save(Probabilidade probabilidade) {
		probabilidade.setPlano(planoService.findVigente());
		return probabilidadeRepository.save(probabilidade);
	}

	@Override
	public List<Probabilidade> findByPlano(Integer planoId) {
		return probabilidadeRepository.findByPlano(planoId);
	}

	@Override
	public List<Probabilidade> findAll() {
		return probabilidadeRepository.findAll();
	}

	@Override
	public Probabilidade update(Probabilidade probabilidade) {
		return probabilidadeRepository.save(probabilidade);
	}

	@Override
	public Optional<Probabilidade> findById(Integer id) {
		return probabilidadeRepository.findById(id);
	}

	@Override
	public void delete(Probabilidade probabilidade) {
		probabilidadeRepository.delete(probabilidade);
	}

}
