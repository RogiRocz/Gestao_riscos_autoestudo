package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import javax.persistence.*;

import java.time.LocalDate;

@Entity
public class AvaliacaoRisco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    private Probabilidade probabilidade;

    @ManyToOne
    private Impacto impacto;

    @ManyToOne
    private AvaliacaoControle avaliacaoControle;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", locale = "pt-BR", timezone = "Brazil/East")
    private LocalDate data;

    @Enumerated(EnumType.STRING)
    private Periodicidade periodicidade;

    @Column(columnDefinition="TEXT")
    private String justificativa;

    @ManyToOne
    private Usuario responsavel;

    @ManyToOne
    private Risco risco;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Probabilidade getProbabilidade() {
        return probabilidade;
    }

    public void setProbabilidade(Probabilidade probabilidade) {
        this.probabilidade = probabilidade;
    }

    public Impacto getImpacto() {
        return impacto;
    }

    public void setImpacto(Impacto impacto) {
        this.impacto = impacto;
    }

    public AvaliacaoControle getAvaliacaoControle() {
        return avaliacaoControle;
    }

    public void setAvaliacaoControle(AvaliacaoControle avaliacaoControle) {
        this.avaliacaoControle = avaliacaoControle;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public Usuario getResponsavel() {
        return responsavel;
    }

    public void setResponsavel(Usuario responsavel) {
        this.responsavel = responsavel;
    }

    public Risco getRisco() {
        return risco;
    }

    public void setRisco(Risco risco) {
        this.risco = risco;
    }

    public Periodicidade getPeriodicidade() {
        return periodicidade;
    }

    public void setPeriodicidade(Periodicidade periodicidade) {
        this.periodicidade = periodicidade;
    }

    public String getJustificativa() {
        return justificativa;
    }

    public void setJustificativa(String justificativa) {
        this.justificativa = justificativa;
    }
}
