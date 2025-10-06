package br.ufc.quixada.npi.gestaoriscos.service;

import br.ufc.quixada.npi.gestaoriscos.model.Unidade;
import br.ufc.quixada.npi.gestaoriscos.model.Usuario;
import br.ufc.quixada.npi.gestaoriscos.repository.UnidadeRepository;
import br.ufc.quixada.npi.gestaoriscos.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private UnidadeRepository unidadeRepository;

    public Usuario findById(Integer id) {
        return usuarioRepository.findById(id).get();
    }

    public Usuario findByEmail(String email) {
        return usuarioRepository.findByEmail(email);
    }

    public List<Usuario> findAll() {
        return usuarioRepository.findAll();
    }

    public List<Usuario> findByUnidade(Unidade unidade) {
        List<Unidade> unidades = unidadeRepository.findByUnidadePai(unidade);
        unidades.add(unidade);
        return usuarioRepository.findByUnidade(unidades);
    }

}
