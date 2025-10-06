package br.ufc.quixada.npi.gestaoriscos.service.impl;

import java.util.List;
import java.util.Optional;

import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.model.AreaAtuacao;
import br.ufc.quixada.npi.gestaoriscos.repository.AreaAtuacaoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.AreaAtuacaoService;

@Service
public class AreaAtuacaoServiceImpl implements AreaAtuacaoService{

	@Autowired
	private AreaAtuacaoRepository areaAtuacaoRepository;

	@Autowired
	private PlanoService planoService;
	
	@Override
	public AreaAtuacao save(AreaAtuacao areaAtuacao) {
		areaAtuacao.setPlano(planoService.findVigente());
		return areaAtuacaoRepository.save(areaAtuacao);
	}

	@Override
	public List<AreaAtuacao> find(Plano plano) {
		return areaAtuacaoRepository.findByPlano(plano);
	}

	@Override
	public AreaAtuacao update(AreaAtuacao areaAtuacao) {
		
		return areaAtuacaoRepository.save(areaAtuacao);
	}

	@Override
	public Optional<AreaAtuacao> findById(Integer id) {
		return areaAtuacaoRepository.findById(id);
	}

	@Override
	public void delete(AreaAtuacao areaAtuacao) {
		areaAtuacaoRepository.delete(areaAtuacao);
		
	}

}
