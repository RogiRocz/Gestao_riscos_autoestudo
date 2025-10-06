package br.ufc.quixada.npi.gestaoriscos.service;

import org.springframework.stereotype.Service;

import br.ufc.quixada.npi.gestaoriscos.model.CategoriaRisco;

import java.util.List;
import java.util.Optional;

@Service
public interface CategoriaRiscoService {

	CategoriaRisco save(CategoriaRisco categoriaRisco);

	List<CategoriaRisco> findByPlano(Integer planoId);

	List<CategoriaRisco> findAll();

	CategoriaRisco update(CategoriaRisco categoriaRisco);

	Optional<CategoriaRisco> findById(Integer id);

	void delete(CategoriaRisco categoriaRisco);


}
