package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.AcaoPreventiva;
import br.ufc.quixada.npi.gestaoriscos.model.MonitoramentoAcao;
import br.ufc.quixada.npi.gestaoriscos.model.PlanoTratamento;
import br.ufc.quixada.npi.gestaoriscos.repository.AcaoPreventivaRepository;
import br.ufc.quixada.npi.gestaoriscos.repository.MonitoramentoAcaoRepository;
import br.ufc.quixada.npi.gestaoriscos.repository.PlanoDeTratamentoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class PlanoTratamentoService {

	@Autowired
	private PlanoDeTratamentoRepository planoDeTratamentoRepository;

	@Autowired
	private MonitoramentoAcaoRepository monitoramentoAcaoRepository;

	@Autowired
	private AcaoPreventivaRepository acaoPreventivaRepository;

	@Autowired
	private UsuarioService usuarioService;

	public PlanoTratamento save(PlanoTratamento planoTratamento) {
		planoTratamento.setResponsavel(usuarioService.findById(planoTratamento.getResponsavel().getId()));
		planoTratamento.setDataPlanejamento(LocalDate.now());
		planoTratamento.setStatus(true);
		for (AcaoPreventiva acao : planoTratamento.getAcoesPreventivas()) {
			acao.setPlanoTratamento(planoTratamento);
			acao.setStatus(AcaoPreventiva.Status.NAO_INICIADA);
		}
		return planoDeTratamentoRepository.save(planoTratamento);
	}

    public List<PlanoTratamento> findAll() {
		return planoDeTratamentoRepository.findAll();
	}

    public Optional<PlanoTratamento> findById(Integer id) {
        return planoDeTratamentoRepository.findById(id);
    }

	public PlanoTratamento findOne(Integer id) {
		return planoDeTratamentoRepository.getOne(id);
	}

	public PlanoTratamento update(PlanoTratamento planoDeTratamento) {
		if(planoDeTratamentoRepository.getOne(planoDeTratamento.getId()) != null) {
			return planoDeTratamentoRepository.save(planoDeTratamento);
		}
		return null;
	}

	public void delete(PlanoTratamento planoTratamento) {
		planoDeTratamentoRepository.delete(planoTratamento);
	}

	public List<PlanoTratamento> find(Integer riscoId) {
		return planoDeTratamentoRepository.findByRiscoIdOrderByStatusDescDataPlanejamentoDesc(riscoId);
	}


    public MonitoramentoAcao save(MonitoramentoAcao monitoramento) {
		if (monitoramentoAcaoRepository.countByAcaoPreventivaId(monitoramento.getAcaoPreventiva().getId()) == 0) {
			monitoramento.getAcaoPreventiva().setStatus(AcaoPreventiva.Status.EM_ANDAMENTO);
			acaoPreventivaRepository.save(monitoramento.getAcaoPreventiva());
		}
		monitoramento.setDataCadastro(LocalDate.now());
		return monitoramentoAcaoRepository.save(monitoramento);
    }

	public AcaoPreventiva save(AcaoPreventiva acaoPreventiva) {
		return acaoPreventivaRepository.save(acaoPreventiva);
	}
}
