package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.Probabilidade;

import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;


@Service
public interface ProbabilidadeService {

	Probabilidade save(Probabilidade probabilidade);

	List<Probabilidade> findByPlano(Integer planoId);

	List<Probabilidade> findAll();

	Probabilidade update(Probabilidade probabilidade);

	Optional<Probabilidade> findById(Integer id);

	void delete(Probabilidade probabilidade);


}
