package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.Objects;

@Entity
public class RespostaRisco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotEmpty
    private String nome;

    @Column(columnDefinition="TEXT")
    private String descricao;

    private boolean planoTratamento;

    private boolean ameaca;

    private boolean oportunidade;

    private boolean compartilhavel;

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

    public boolean isPlanoTratamento() {
        return planoTratamento;
    }

    public void setPlanoTratamento(boolean planoTratamento) {
        this.planoTratamento = planoTratamento;
    }

    public boolean isAmeaca() {
        return ameaca;
    }

    public void setAmeaca(boolean ameaca) {
        this.ameaca = ameaca;
    }

    public boolean isOportunidade() {
        return oportunidade;
    }

    public void setOportunidade(boolean oportunidade) {
        this.oportunidade = oportunidade;
    }

    public Plano getPlano() {
        return plano;
    }

    public void setPlano(Plano plano) {
        this.plano = plano;
    }

    public boolean isCompartilhavel() {
        return compartilhavel;
    }

    public void setCompartilhavel(boolean compartilhavel) {
        this.compartilhavel = compartilhavel;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RespostaRisco that = (RespostaRisco) o;
        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
