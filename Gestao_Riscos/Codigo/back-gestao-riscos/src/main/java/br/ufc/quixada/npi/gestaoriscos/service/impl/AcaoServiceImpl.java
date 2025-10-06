package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.model.Acao;
import br.ufc.quixada.npi.gestaoriscos.model.Plano;
import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import br.ufc.quixada.npi.gestaoriscos.repository.AcaoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.AcaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AcaoServiceImpl implements AcaoService {

	@Autowired
	private AcaoRepository acaoRepository;


	@Override
	public Acao save(Acao acao){
		return acaoRepository.save(acao);
	}

	@Override
	public List<Acao> findAll() {
    	return acaoRepository.findAll();
	}

	@Override
	public Acao update(Acao acao) {
		return acaoRepository.save(acao);
	}
	
	@Override
    public Acao findById(Integer id) {
        return acaoRepository.findById(id).get();
    }

	@Override
	public void delete(Acao acao)
	{
		acaoRepository.delete(acao);
	}
	
	@Override
	public List<Acao> findByUnidade(Plano plano, Unidade unidade){
		return acaoRepository.findByPlanoAndUnidade(plano, unidade);
	}

}

