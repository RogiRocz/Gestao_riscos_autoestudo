package br.ufc.quixada.npi.gestaoriscos.model;


import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;


import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Plano {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotEmpty
    private String nome;

    @Column(columnDefinition="TEXT")
    private String descricao;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", locale = "pt-BR", timezone = "Brazil/East")
    private LocalDate dataInicio;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", locale = "pt-BR", timezone = "Brazil/East")
    private LocalDate dataFim;

    public Plano() {}

    public Plano(Integer id, String nome, String descricao, LocalDate dataInicio, LocalDate dataFim) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
    }

    @OneToMany(cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<NivelRisco> niveisRisco;

    @OneToMany(cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<Impacto> impactos;

    @OneToMany(cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<Probabilidade> probabilidades;

    @OneToMany(cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<RespostaRisco> respostasRisco;

    @OneToMany(cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<CategoriaRisco> categoriasRisco;

    @OneToMany(cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<AreaAtuacao> areas;

    @OneToMany(cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<AvaliacaoControle> avaliacoesControle;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public List<NivelRisco> getNiveisRisco() {
        return niveisRisco;
    }

    public void addNivelRisco(NivelRisco nivelRisco) {
        if (this.niveisRisco == null) {
            this.niveisRisco = new ArrayList<>();
        }
        this.niveisRisco.add(nivelRisco);
        nivelRisco.setPlano(this);
    }

    public void addAllNivelRisco(List<NivelRisco> niveisRisco) {
        if (this.niveisRisco == null) {
            this.niveisRisco = new ArrayList<>();
        }
        this.niveisRisco.addAll(niveisRisco);
        for (NivelRisco nivel : niveisRisco) {
            nivel.setPlano(this);
        }
    }

    public void removeNivelRisco(NivelRisco nivelRisco) {
        if (this.niveisRisco != null) {
            this.niveisRisco.remove(nivelRisco);
        }
    }

    public List<Impacto> getImpactos() {
        return impactos;
    }

    public void addImpacto(Impacto impacto) {
        if (impactos == null) {
            impactos = new ArrayList<>();
        }
        impactos.add(impacto);
        impacto.setPlano(this);
    }

    public void addAllImpacto(List<Impacto> impactos) {
        if (this.impactos == null) {
            this.impactos = new ArrayList<>();
        }
        this.impactos.addAll(impactos);
        for (Impacto impacto: impactos) {
            impacto.setPlano(this);
        }

    }

    public void removeImpacto(Impacto impacto) {
        if (impactos != null) {
            impactos.remove(impacto);
        }
    }

    public List<Probabilidade> getProbabilidades() {
        return probabilidades;
    }

    public void addProbabilidade(Probabilidade probabilidade) {
        if (probabilidades == null) {
            probabilidades = new ArrayList<>();
        }
        probabilidades.add(probabilidade);
        probabilidade.setPlano(this);
    }

    public void addAllProbabilidade(List<Probabilidade> probabilidades) {
        if (this.probabilidades == null) {
            this.probabilidades = new ArrayList<>();
        }
        this.probabilidades.addAll(probabilidades);
        for (Probabilidade probabilidade: probabilidades) {
            probabilidade.setPlano(this);
        }

    }

    public void removeProbabilidade(Probabilidade probabilidade) {
        if (probabilidades != null) {
            probabilidades.remove(probabilidade);
        }
    }

    public List<RespostaRisco> getRespostasRisco() {
        return respostasRisco;
    }

    public void addRespostaRisco(RespostaRisco resposta) {
        if (respostasRisco == null) {
            respostasRisco = new ArrayList<>();
        }
        respostasRisco.add(resposta);
        resposta.setPlano(this);
    }

    public void addAllRespostasRisco(List<RespostaRisco> respostas) {
        if (this.respostasRisco == null) {
            this.respostasRisco = new ArrayList<>();
        }
        this.respostasRisco.addAll(respostas);
        for (RespostaRisco resposta: respostas) {
            resposta.setPlano(this);
        }
    }

    public void removeRespostaRisco(RespostaRisco resposta) {
        if (respostasRisco != null) {
            respostasRisco.remove(resposta);
        }
    }

    public List<CategoriaRisco> getCategoriasRisco() {
        return categoriasRisco;
    }

    public void addCategoriaRisco(CategoriaRisco categoria) {
        if (categoriasRisco == null) {
            categoriasRisco = new ArrayList<>();
        }
        categoriasRisco.add(categoria);
        categoria.setPlano(this);
    }

    public void addAllCategorias(List<CategoriaRisco> categorias) {
        if (this.categoriasRisco == null) {
            this.categoriasRisco = new ArrayList<>();
        }
        this.categoriasRisco.addAll(categorias);
        for (CategoriaRisco categoria: categorias) {
            categoria.setPlano(this);
        }

    }

    public void removeCategoriaRisco(CategoriaRisco categoria) {
        if (categoriasRisco != null) {
            categoriasRisco.remove(categoria);
        }
    }

    public List<AvaliacaoControle> getAvaliacoesControle() {
        return avaliacoesControle;
    }

    public void addAvaliacaoControle(AvaliacaoControle avaliacaoControle) {
        if (avaliacoesControle == null) {
            avaliacoesControle = new ArrayList<>();
        }
        avaliacoesControle.add(avaliacaoControle);
        avaliacaoControle.setPlano(this);
    }

    public void addAllAvaliacaoControle(List<AvaliacaoControle> avaliacoesControle) {
        if (this.avaliacoesControle == null) {
            this.avaliacoesControle = new ArrayList<>();
        }
        this.avaliacoesControle.addAll(avaliacoesControle);
        for (AvaliacaoControle avaliacaoControle : avaliacoesControle) {
            avaliacaoControle.setPlano(this);
        }

    }

    public void removeAvaliacaoControle(AvaliacaoControle avaliacaoControle) {
        if (avaliacoesControle != null) {
            avaliacoesControle.remove(avaliacaoControle);
        }
    }

    public NivelRisco getNivelRiscoByName(String nome) {
        for (NivelRisco n: this.niveisRisco) {
            if(n.getNome().equalsIgnoreCase(nome))
                return n;
        }
        return null;
    }

    public Probabilidade getProbabilidadeByName(String nome) {
        for (Probabilidade p: this.probabilidades) {
            if(p.getNome().equalsIgnoreCase(nome))
                return p;
        }
        return null;
    }

    public Impacto getImpactoByName(String nome) {
        for (Impacto i: this.impactos) {
            if(i.getNome().equalsIgnoreCase(nome))
                return i;
        }
        return null;
    }

    public LocalDate getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(LocalDate dataInicio) {
        this.dataInicio = dataInicio;
    }

    public LocalDate getDataFim() {
        return dataFim;
    }

    public void setDataFim(LocalDate dataFim) {
        this.dataFim = dataFim;
    }

    public List<AreaAtuacao> getAreas() {
        return areas;
    }

    public void addArea(AreaAtuacao area) {
        if (areas == null) {
            areas = new ArrayList<>();
        }
        areas.add(area);
        area.setPlano(this);
    }

    public void addAllAreas(List<AreaAtuacao> areas) {
        if (this.areas == null) {
            this.areas = new ArrayList<>();
        }
        this.areas.addAll(areas);
        for (AreaAtuacao area: areas) {
            area.setPlano(this);
        }
    }

    public void removeArea(AreaAtuacao area) {
        if (areas != null) {
            areas.remove(area);
        }
    }
}

