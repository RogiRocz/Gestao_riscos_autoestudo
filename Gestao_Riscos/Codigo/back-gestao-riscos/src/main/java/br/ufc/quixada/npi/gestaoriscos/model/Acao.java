package br.ufc.quixada.npi.gestaoriscos.model;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Acao {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotEmpty
    private String titulo;

    @Column(columnDefinition="TEXT")
    private String objetivoGeral;

    @Column(columnDefinition="TEXT")
    private String objetivosEspecificos;

    @ManyToOne
    private Plano plano;

    @ManyToMany
    private List<AreaAtuacao> areas;

    @ManyToOne
    private Usuario gestor;

    @ManyToOne
    private Unidade unidade;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getObjetivoGeral() {
        return objetivoGeral;
    }

    public void setObjetivoGeral(String objetivoGeral) {
        this.objetivoGeral = objetivoGeral;
    }

    public String getObjetivosEspecificos() {
        return objetivosEspecificos;
    }

    public void setObjetivosEspecificos(String objetivosEspecificos) {
        this.objetivosEspecificos = objetivosEspecificos;
    }

    public Usuario getGestor() {
        return gestor;
    }

    public void setGestor(Usuario gestor) {
        this.gestor = gestor;
    }

    public void addAllAreas(List<AreaAtuacao> areas) {
        if (this.areas == null) {
            this.areas = new ArrayList<>();
        }
        this.areas.addAll(areas);
    }

    public void addArea(AreaAtuacao area) {
        if (this.areas == null) {
            this.areas = new ArrayList<>();
        }
        this.areas.add(area);
    }

    public void removeArea(AreaAtuacao area) {
        if (this.areas != null) {
            this.areas.remove(area);
        }
    }

    public Unidade getUnidade() {
        return unidade;
    }

    public void setUnidade(Unidade unidade) {
        this.unidade = unidade;
    }

    public Plano getPlano() {
        return plano;
    }

    public void setPlano(Plano plano) {
        this.plano = plano;
    }

    public List<AreaAtuacao> getAreas() {
        return areas;
    }

    public void setAreas(List<AreaAtuacao> areas) {
        this.areas = areas;
    }
}
