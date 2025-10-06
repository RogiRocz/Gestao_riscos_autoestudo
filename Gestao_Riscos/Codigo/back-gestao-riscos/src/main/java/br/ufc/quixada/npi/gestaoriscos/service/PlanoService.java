package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.Plano;

import java.util.List;
import java.util.Optional;

public interface PlanoService {

    List<Plano> findAll();

    Optional<Plano> findById(Integer id);

    Plano save(Plano plano);

    Plano update(Plano plano);

    void delete(Plano plano);

	Plano findVigente();

}
