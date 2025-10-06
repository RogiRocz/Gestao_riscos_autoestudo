package br.ufc.quixada.npi.gestaoriscos.service.impl;

import br.ufc.quixada.npi.gestaoriscos.model.*;
import br.ufc.quixada.npi.gestaoriscos.repository.PlanoRepository;
import br.ufc.quixada.npi.gestaoriscos.service.PlanoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PlanoServiceImpl implements PlanoService {

    @Autowired
    private PlanoRepository planoRepository;

    @Override
    public List<Plano> findAll() {
        return planoRepository.findAll();
    }
    
    @Override
    public Plano findVigente() {
        return planoRepository.findFirstByOrderByDataFimDesc();
    }

    @Override
    public Plano save(Plano plano) {
        return planoRepository.save(plano);
    }

    @Override
    public Optional<Plano> findById (Integer id){
    	return planoRepository.findById(id);
    }

    @Override
    public Plano update(Plano plano) {
        return planoRepository.save(plano);
    }

    @Override
    public void delete(Plano plano) {
    	planoRepository.delete(plano);
   }


}
