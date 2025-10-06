package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import br.ufc.quixada.npi.gestaoriscos.model.Risco;
import br.ufc.quixada.npi.gestaoriscos.repository.RiscoRepository;
import java.util.List;
import java.util.Optional;

@Service
public class RiscoService {

	@Autowired
	private RiscoRepository riscoRepository;

	public Risco save(Risco risco) {
		return riscoRepository.save(risco);
	}

	public List<Risco> findAll() {
		return riscoRepository.findAll();
	}

	public Risco update(Risco risco) {
		return riscoRepository.save(risco);
	}

	public Risco findById(Integer id) {
		return riscoRepository.findById(id).get();
	}

	public void delete(Risco risco) {
		riscoRepository.delete(risco);
	}

	public List<Risco> findAll(Plano plano, Unidade unidade) {
		return riscoRepository.findByPlanoAndUnidade(plano, unidade);
	}

	public List<Risco> findByUnidade(Plano plano, Unidade unidade) {
		return riscoRepository.findByPlanoAndUnidade(plano, unidade);
	}

	public List<Risco> findByAcoes(Acao acao) {
    		return riscoRepository.findByAcoes(acao);
    	}

}

