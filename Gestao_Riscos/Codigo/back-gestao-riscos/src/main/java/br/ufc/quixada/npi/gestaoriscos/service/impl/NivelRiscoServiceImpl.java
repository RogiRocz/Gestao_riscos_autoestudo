package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.model.NivelRisco;
import br.ufc.quixada.npi.gestaoriscos.repository.NivelRiscoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.NivelRiscoService;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class NivelRiscoServiceImpl implements NivelRiscoService {

    @Autowired
    private NivelRiscoRepository nivelRiscoRepository;

    @Autowired
    private PlanoService planoService;

    @Override
    public NivelRisco save(NivelRisco nivelRisco) {
        nivelRisco.setPlano(planoService.findVigente());
        return nivelRiscoRepository.save(nivelRisco);
    }

    @Override
    public List<NivelRisco> findByPlano(Integer planoId) {
        return nivelRiscoRepository.findByPlano(planoId);
    }

    @Override
    public List<NivelRisco> findAll() {
        return nivelRiscoRepository.findAll();
    }

    @Override
    public Optional<NivelRisco> findById (Integer id){ return nivelRiscoRepository.findById(id); }

    @Override
    public void delete(NivelRisco nivelRisco) {
        nivelRiscoRepository.delete(nivelRisco);
    }

    @Override
    public Integer countNiveis(Float riscoInerente) {
        return nivelRiscoRepository.findAll(riscoInerente);
    }

	@Override
	public boolean checkConflitoIntervalo(NivelRisco nivelRisco) {
		return nivelRiscoRepository.checkConflitoIntervalo(nivelRisco.getValorInicial(), nivelRisco.getValorFinal());
	}

}
