package br.ufc.quixada.npi.gestaoriscos.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.model.AvaliacaoRisco;
import br.ufc.quixada.npi.gestaoriscos.repository.AvaliacaoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.AvaliacaoService;

@Service
public class AvaliacaoServiceImpl implements AvaliacaoService {

	@Autowired
	private AvaliacaoRepository avaliacaoRepository;

	@Override
	public AvaliacaoRisco save(AvaliacaoRisco avaliacaoRisco) {
		return avaliacaoRepository.save(avaliacaoRisco);
	}

	@Override
	public List<AvaliacaoRisco> findAll() {
		return avaliacaoRepository.findAll();
	}

	@Override
	public List<AvaliacaoRisco> find(Integer riscoId) {
		return avaliacaoRepository.findByRiscoIdOrderByDataDesc(riscoId);
	}

	@Override
	public AvaliacaoRisco findLast(Integer riscoId) {
		return avaliacaoRepository.findFirstByRiscoIdOrderByDataDesc(riscoId);
	}

	@Override
	public Optional<AvaliacaoRisco> findById(Integer id) {
		return avaliacaoRepository.findById(id);
	}

	@Override
	public void delete(AvaliacaoRisco avaliacaoRisco) {
		avaliacaoRepository.delete(avaliacaoRisco);
	}

	@Override
	public Map<Integer, AvaliacaoRisco> buscaAvalicoesRecentes() {
		List <AvaliacaoRisco> avalicoesRecentes = avaliacaoRepository.buscaAvalicoesRecentes();
		Map<Integer, AvaliacaoRisco> mapAvalicoesRecentes = new HashMap<>();
		for (AvaliacaoRisco avaliacao: avalicoesRecentes) {
			mapAvalicoesRecentes.put(avaliacao.getRisco().getId(), avaliacao);
		}

		return mapAvalicoesRecentes;
	}

	@Override
	public Integer countRiscos(String nomeProbabilidade, String nomeImpacto) {
		return avaliacaoRepository.findRiscoValor(nomeProbabilidade, nomeImpacto).size();
	}



}
