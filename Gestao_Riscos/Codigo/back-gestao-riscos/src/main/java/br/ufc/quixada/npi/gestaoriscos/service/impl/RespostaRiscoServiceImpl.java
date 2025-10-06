package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.model.RespostaRisco;
import br.ufc.quixada.npi.gestaoriscos.repository.RespostaRiscoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import br.ufc.quixada.npi.gestaoriscos.service.RespostaRiscoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RespostaRiscoServiceImpl implements RespostaRiscoService {

    @Autowired
    private RespostaRiscoRepository respostaRiscoRepository;

    @Autowired
    private PlanoService planoService;

    @Override
    public RespostaRisco save(RespostaRisco respostaRisco) {
        respostaRisco.setPlano(planoService.findVigente());
        return respostaRiscoRepository.save(respostaRisco);
    }

    @Override
    public List<RespostaRisco> findByPlano(Integer planoId) {
        return respostaRiscoRepository.findByPlanoId(planoId);
    }

    @Override
    public Optional<RespostaRisco> findById (Integer id){ return respostaRiscoRepository.findById(id); }


    @Override
    public RespostaRisco update(RespostaRisco respostaRisco) {
        return respostaRiscoRepository.save(respostaRisco);
    }

    public void delete(RespostaRisco respostaRisco) {
        respostaRiscoRepository.delete(respostaRisco);
    }
}
