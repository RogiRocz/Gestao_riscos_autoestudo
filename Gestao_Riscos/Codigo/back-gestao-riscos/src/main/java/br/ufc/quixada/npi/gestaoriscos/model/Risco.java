package br.ufc.quixada.npi.gestaoriscos.model;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Risco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotEmpty
    private String nome;

    @Enumerated(EnumType.STRING)
    private TipoRisco tipo;

    @Column(columnDefinition="TEXT")
    private String causa;

    @Column(columnDefinition="TEXT")
    private String consequencia;

    @Column(columnDefinition="TEXT")
    private String controles;

    @ManyToMany
    private List<CategoriaRisco> categorias;

    @ManyToOne
    private Plano plano;

    @ManyToOne
    private Usuario responsavel;

    @ManyToOne
    private Unidade unidade;

    @JsonIgnore
    @OneToMany(mappedBy = "risco", cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<AvaliacaoRisco> avaliacoes;

    @JsonIgnore
    @OneToMany(mappedBy = "risco", cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<Ocorrencia> ocorrencias;

    @JsonIgnore
    @OneToMany(mappedBy = "risco", cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<PlanoContingencia> contingencias;

    @ManyToMany
    private List<Acao> acoes;

    @JsonIgnore
    @OneToMany(mappedBy = "risco", cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<PlanoTratamento> tratamentos;

    public Risco() {}

    public Risco(String nome, TipoRisco tipo, List<CategoriaRisco> categorias, Plano plano,
                 Usuario responsavel, Unidade unidade, List<AvaliacaoRisco> avaliacoes, List<Ocorrencia> ocorrencias,
                 List<PlanoContingencia> contingencias, List<Acao> acoes, List<PlanoTratamento> tratamentos) {
        this.nome = nome;
        this.tipo = tipo;
        this.categorias = categorias;
        this.plano = plano;
        this.responsavel = responsavel;
        this.unidade = unidade;
        addAllAvaliacoes(avaliacoes);
        this.ocorrencias = ocorrencias;
        this.contingencias = contingencias;
        this.acoes = acoes;
        this.tratamentos = tratamentos;
    }

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

    public TipoRisco getTipo() {
        return tipo;
    }

    public void setTipo(TipoRisco tipo) {
        this.tipo = tipo;
    }

    public String getCausa() {
        return causa;
    }

    public void setCausa(String causa) {
        this.causa = causa;
    }

    public String getConsequencia() {
        return consequencia;
    }

    public void setConsequencia(String consequencia) {
        this.consequencia = consequencia;
    }

    public String getControles() {
        return controles;
    }

    public void setControles(String controles) {
        this.controles = controles;
    }

    public void setCategorias(List<CategoriaRisco> categorias) {
        this.categorias = categorias;
    }

    public List<CategoriaRisco> getCategorias() {
        return categorias;
    }

    public void addCategoria(CategoriaRisco categoria) {
        if (categorias == null) {
            categorias = new ArrayList<>();
        }
        this.categorias.add(categoria);
    }

    public void addAllCategorias(List<CategoriaRisco> categorias) {
        if (this.categorias == null) {
            this.categorias = new ArrayList<>();
        }
        this.categorias.addAll(categorias);
    }

    public void removeCategoria(CategoriaRisco categoria) {
        if (this.categorias != null) {
            this.categorias.remove(categoria);
        }
    }

    public Usuario getResponsavel() {
        return responsavel;
    }

    public void setResponsavel(Usuario responsavel) {
        this.responsavel = responsavel;
    }

    public Unidade getUnidade() {
        return unidade;
    }

    public void setUnidade(Unidade unidade) {
        this.unidade = unidade;
    }


    public void setAvaliacoes(List<AvaliacaoRisco> avaliacoes) {
        addAllAvaliacoes(avaliacoes);
    }

    public void addAvaliacao(AvaliacaoRisco avaliacao) {
        if (avaliacoes == null) {
            avaliacoes = new ArrayList<>();
        }
        avaliacoes.add(avaliacao);
        avaliacao.setRisco(this);
    }

    public void addAllAvaliacoes(List<AvaliacaoRisco> avaliacoes) {

        if (this.avaliacoes == null) {
            this.avaliacoes = new ArrayList<>();
        }
        this.avaliacoes.addAll(avaliacoes);
        for (AvaliacaoRisco avaliacao: avaliacoes) {
            avaliacao.setRisco(this);
        }

    }

    public void removeAvaliacaoRisco(AvaliacaoRisco avaliacao) {
        if (avaliacoes != null) {
            avaliacoes.remove(avaliacao);
        }
    }

    public List<AvaliacaoRisco> getAvaliacoes() {
        return avaliacoes;
    }

    public List<Ocorrencia> getOcorrencias() {
        return ocorrencias;
    }

    public void addOcorrencia(Ocorrencia ocorrencia) {
        if (ocorrencias == null) {
            ocorrencias = new ArrayList<>();
        }
        ocorrencias.add(ocorrencia);
        ocorrencia.setRisco(this);
    }

    public void addAllOcorrencias(List<Ocorrencia> ocorrencias) {
        if (this.ocorrencias == null) {
            this.ocorrencias = new ArrayList<>();
        }
        this.ocorrencias.addAll(ocorrencias);
        for (Ocorrencia ocorrencia : ocorrencias) {
            ocorrencia.setRisco(this);
        }

    }

    public void removeOcorrencia(Ocorrencia ocorrencia) {
        if (ocorrencias != null) {
            ocorrencias.remove(ocorrencia);
        }
    }

    public List<PlanoContingencia> getContingencias() {
        return contingencias;
    }

    public void addContingencia(PlanoContingencia contingencia) {
        if (contingencias == null) {
            contingencias = new ArrayList<>();
        }
        contingencias.add(contingencia);
        contingencia.setRisco(this);
    }

    public void addAllContingencias(List<PlanoContingencia> contingencias) {
        if (this.contingencias == null) {
            this.contingencias = new ArrayList<>();
        }
        this.contingencias.addAll(contingencias);
        for (PlanoContingencia contingencia: contingencias) {
            contingencia.setRisco(this);
        }

    }

    public void removeContingencia(PlanoContingencia contingencia) {
        if (contingencias != null) {
            contingencias.remove(contingencia);
        }
    }

    public List<Acao> getAcoes() {
        return acoes;
    }

    public void addAcao(Acao acao) {
        if (acoes == null) {
            acoes = new ArrayList<>();
        }
        acoes.add(acao);
    }

    public void addAcoes(List<Acao> acoes) {
        if (this.acoes == null) {
            this.acoes = new ArrayList<>();
        }
        this.acoes.addAll(acoes);

    }

    public void removeAcao(Acao acao) {
        if (acoes != null) {
            acoes.remove(acao);
        }
    }

    public void setAcoes(List<Acao> acoes) {
        this.addAcoes(acoes);
    }


    public void setOcorrencias(List<Ocorrencia> ocorrencias) {
        this.ocorrencias = ocorrencias;
    }


    public void setContingencias(List<PlanoContingencia> contingencias) {
        this.contingencias = contingencias;
    }

    public Plano getPlano() {
        return plano;
    }

    public void setPlano(Plano plano) {
        this.plano = plano;
    }

    public List<PlanoTratamento> getTratamentos() {
        return tratamentos;
    }

    public void setTratamentos(List<PlanoTratamento> tratamentos) {
        this.tratamentos = tratamentos;
    }
}
