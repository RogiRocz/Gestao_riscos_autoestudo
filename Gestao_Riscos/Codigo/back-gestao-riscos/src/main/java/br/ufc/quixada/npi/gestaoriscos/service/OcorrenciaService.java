package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.Ocorrencia;
import br.ufc.quixada.npi.gestaoriscos.repository.OcorrenciaRepository;
import br.ufc.quixada.npi.gestaoriscos.repository.PlanoContigenciaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class OcorrenciaService {

    @Autowired
    private OcorrenciaRepository ocorrenciaRepository;

    @Autowired
    private PlanoContigenciaRepository planoContigenciaRepository;

    public Ocorrencia save(Ocorrencia ocorrencia) {
        ocorrencia.setPlanoContingencia(planoContigenciaRepository.findById(ocorrencia.getPlanoContingencia().getId()).get());
        return ocorrenciaRepository.save(ocorrencia);
    }

    public List<Ocorrencia> findAll() {
        return ocorrenciaRepository.findAll();
    }

    public Optional<Ocorrencia> findById(Integer id) {
        return ocorrenciaRepository.findById(id);
    }

    public void delete(Ocorrencia ocorrencia) {
        ocorrenciaRepository.delete(ocorrencia);
    }

    public List<Ocorrencia> find(Integer riscoId) {
        return ocorrenciaRepository.findByRiscoId(riscoId);
    }

}
