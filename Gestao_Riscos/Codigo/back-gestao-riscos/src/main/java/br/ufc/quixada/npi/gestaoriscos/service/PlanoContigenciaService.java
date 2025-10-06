package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.PlanoContingencia;
import br.ufc.quixada.npi.gestaoriscos.repository.PlanoContigenciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PlanoContigenciaService {

	@Autowired
	private PlanoContigenciaRepository planoContigenciaRepository;
	
	public PlanoContingencia save(PlanoContingencia planoContigencia) {
		return planoContigenciaRepository.save(planoContigencia);
	}

	public List<PlanoContingencia> findAll() {
		return planoContigenciaRepository.findAll();
	}

	public Optional<PlanoContingencia> findById(Integer id) {
		return planoContigenciaRepository.findById(id);
	}

	public PlanoContingencia update(PlanoContingencia planoContigencia) {
		return planoContigenciaRepository.save(planoContigencia);
	}

	public void delete(PlanoContingencia planoContingencia) {
		planoContigenciaRepository.delete(planoContingencia);
	}

	public List<PlanoContingencia> find(Integer riscoId) {
		return planoContigenciaRepository.findPlanoByRiscoId(riscoId);
	}

}
