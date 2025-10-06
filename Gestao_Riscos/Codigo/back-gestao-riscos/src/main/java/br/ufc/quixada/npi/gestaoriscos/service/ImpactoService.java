package br.ufc.quixada.npi.gestaoriscos.service;

import org.springframework.stereotype.Service;
import br.ufc.quixada.npi.gestaoriscos.model.Impacto;
import java.util.List;
import java.util.Optional;

@Service
public interface ImpactoService {

	List<Impacto> findAll();

	Impacto save(Impacto impacto);

	List<Impacto> findByPlano(Integer planoId);

	Impacto update(Impacto impacto);

	Optional<Impacto> findById(Integer id);

	void delete(Impacto impacto);


}
