package br.ufc.quixada.npi.gestaoriscos.service.impl;


import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Risco;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import br.ufc.quixada.npi.gestaoriscos.repository.UnidadeRepository;
import br.ufc.quixada.npi.gestaoriscos.service.UnidadeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UnidadeServiceImp implements UnidadeService {
	
	@Autowired
	private UnidadeRepository unidadeRepository;
	
	@Override
	public Unidade save(Unidade unidade) {
		if(unidade.getId() != null){
			return null;
		}
		return unidadeRepository.save(unidade);
	}

	@Override
	public List<Unidade> findAll() {
		return unidadeRepository.findAll();
	}

	@Override
	public Unidade findOne(Integer id) {
		return unidadeRepository.getOne(id);
	}

	@Override
	public Unidade update(Unidade unidade) {
		if(unidade.getId() != null) {
			return unidadeRepository.save(unidade);
		}
		return null;
	}

	@Override
	public Boolean delete(Integer id) {
		Unidade unidade = unidadeRepository.getOne(id);
		if(unidade != null) {
			unidadeRepository.delete(unidade);
			return Boolean.TRUE;
		}
		return Boolean.FALSE;
	}

	@Override
	public List<Risco> listarRiscosUnidade(Integer id) {
		return new ArrayList<>();
	}

	@Override
	public List<Acao> findAcoes(Integer id) {
		return new ArrayList<>();
	}

	
}
