package br.ufc.quixada.npi.gestaoriscos.utils;

import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import java.net.URI;

public class UriLocationBuilder {
    public static URI builder(Integer id){
        URI location = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(id)
                .toUri();
        return location;
    }
}
