package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.model.Impacto;
import br.ufc.quixada.npi.gestaoriscos.repository.ImpactoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.ImpactoService;

import java.util.List;
import java.util.Optional;

@Service
public class ImpactoServiceImpl implements ImpactoService {

	@Autowired
	private ImpactoRepository impactoRepository;

	@Autowired
	private PlanoService planoService;

	@Override
	public Impacto save(Impacto impacto) {
		impacto.setPlano(planoService.findVigente());
		return impactoRepository.save(impacto);
	}

	@Override
	public List<Impacto> findByPlano(Integer planoId) {
		return impactoRepository.findByPlano(planoId);
	}

	@Override
	public List<Impacto> findAll() {
		return impactoRepository.findAll();
	}

	@Override
	public Impacto update(Impacto impacto) {
		return impactoRepository.save(impacto);
	}

	@Override
	public Optional<Impacto> findById(Integer id) {
		return impactoRepository.findById(id);
	}

	@Override
	public void delete(Impacto impacto) {
		impactoRepository.delete(impacto);
	}

}
