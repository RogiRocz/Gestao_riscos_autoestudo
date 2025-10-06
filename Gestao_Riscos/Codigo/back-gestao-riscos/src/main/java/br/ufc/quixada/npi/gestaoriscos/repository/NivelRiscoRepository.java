package br.ufc.quixada.npi.gestaoriscos.repository;

import br.ufc.quixada.npi.gestaoriscos.model.NivelRisco;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface NivelRiscoRepository extends JpaRepository<NivelRisco, Integer> {

    @Query("FROM NivelRisco n WHERE n.plano.id = :id ORDER BY n.valorInicial ASC")
    List<NivelRisco> findByPlano(@Param("id") Integer planoId);

    //@Query(value = "SELECT COUNT(*) FROM nivel_risco as n WHERE n.valor_inicial >= 0 AND n.valor_final <= 100", nativeQuery = true)

    @Query("SELECT COUNT(*) FROM NivelRisco n WHERE :riscoInerente >= n.valorInicial AND :riscoInerente <= n.valorFinal")
    Integer findAll(@Param("riscoInerente") Float riscoInerente);
    
    @Query("select case when count(*)> 0 then true else false end FROM NivelRisco n WHERE (:valorInicial <= n.valorInicial AND :valorFinal >= n.valorInicial) OR"
    		+ ":valorInicial >= n.valorInicial AND :valorInicial <= n.valorFinal")
    boolean checkConflitoIntervalo(@Param("valorInicial") BigDecimal valorInicial, @Param("valorFinal") BigDecimal valorFinal);
}
