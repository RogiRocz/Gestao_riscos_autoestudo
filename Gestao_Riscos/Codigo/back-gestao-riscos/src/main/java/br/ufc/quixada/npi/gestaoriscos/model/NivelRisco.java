package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
public class NivelRisco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotEmpty
    private String nome;

    @Column(columnDefinition="TEXT")
    private String descricao;

    private String cor;

    private BigDecimal valorInicial;

    private BigDecimal valorFinal;

    @Enumerated(EnumType.STRING)
    private Periodicidade periodicidade;

    @ManyToMany
    private List<RespostaRisco> respostasRisco;

    public NivelRisco(){

    }

    public NivelRisco(Integer id, String nome, String descricao, String cor, BigDecimal valorInicial,
                      BigDecimal valorFinal, Periodicidade periodicidade){
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.cor = cor;
        this.valorInicial = valorInicial;
        this.valorFinal = valorFinal;
        this.periodicidade = periodicidade;
    }

    @JsonIgnore
    @ManyToOne
    private Plano plano;

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

    public String getCor() {
        return cor;
    }

    public void setCor(String cor) {
        this.cor = cor;
    }

    public Plano getPlano() {
        return plano;
    }

    public void setPlano(Plano plano) {
        this.plano = plano;
    }

    public BigDecimal getValorInicial() {
        return valorInicial;
    }

    public void setValorInicial(BigDecimal valorInicial) {
        this.valorInicial = valorInicial;
    }

    public BigDecimal getValorFinal() {
        return valorFinal;
    }

    public void setValorFinal(BigDecimal valorFinal) {
        this.valorFinal = valorFinal;
    }

    public Periodicidade getPeriodicidade() {
        return periodicidade;
    }

    public void setPeriodicidade(Periodicidade periodicidade) {
        this.periodicidade = periodicidade;
    }

    public List<RespostaRisco> getRespostasRisco() {
        return respostasRisco;
    }

    public void addRespostaRisco(RespostaRisco respostaRisco) {
        if (respostasRisco == null) {
            respostasRisco = new ArrayList<>();
        }
        if (!respostasRisco.contains(respostaRisco)) {
            respostasRisco.add(respostaRisco);
        }
    }

    public void addAllRespostasRisco(List<RespostaRisco> respostasRisco) {
        if (this.respostasRisco == null) {
            this.respostasRisco = new ArrayList<>();
        }
        for (RespostaRisco resposta : respostasRisco) {
            if (!this.respostasRisco.contains(resposta)) {
                this.respostasRisco.add(resposta);
            }
        }
    }

    public void removeRespostaRisco(RespostaRisco respostaRisco) {
        if (respostasRisco != null) {
            respostasRisco.remove(respostaRisco);
        }
    }
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NivelRisco that = (NivelRisco) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    public void removeAllRespostaRisco() {
        this.respostasRisco = new ArrayList<>();
    }
}
