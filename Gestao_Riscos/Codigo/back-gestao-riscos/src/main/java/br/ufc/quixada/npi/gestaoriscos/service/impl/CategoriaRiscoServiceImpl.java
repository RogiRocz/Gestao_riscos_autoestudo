package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.model.CategoriaRisco;
import br.ufc.quixada.npi.gestaoriscos.repository.CategoriaRiscoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.CategoriaRiscoService;

import java.util.List;
import java.util.Optional;

@Service
public class CategoriaRiscoServiceImpl implements CategoriaRiscoService {

	@Autowired
	private CategoriaRiscoRepository categoriaRiscoRepository;

	@Autowired
	private PlanoService planoService;

	@Override
	public CategoriaRisco save(CategoriaRisco categoriaRisco) {
		categoriaRisco.setPlano(planoService.findVigente());
		return categoriaRiscoRepository.save(categoriaRisco);
	}

	@Override
	public List<CategoriaRisco> findByPlano(Integer planoId) {
		return categoriaRiscoRepository.findByPlanoId(planoId);
	}

	@Override
	public List<CategoriaRisco> findAll() {
		return categoriaRiscoRepository.findAll();
	}

	@Override
	public CategoriaRisco update(CategoriaRisco categoriaRisco) {
		return categoriaRiscoRepository.save(categoriaRisco);
	}

	@Override
	public Optional<CategoriaRisco> findById(Integer id) {
		return categoriaRiscoRepository.findById(id);
	}

	@Override
	public void delete(CategoriaRisco categoriaRisco) {
		categoriaRiscoRepository.delete(categoriaRisco);
	}

}
