package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.Objects;

@Entity
public class Impacto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotEmpty
    private String nome;

    @Column(columnDefinition="TEXT")
    private String descricao;

    private Integer peso;

    public Impacto(){

    }

    public Impacto(Integer id, String nome, String descricao, Integer peso){
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.peso = peso;
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

    public Integer getPeso() {
        return peso;
    }

    public void setPeso(Integer peso) {
        this.peso = peso;
    }

    public Plano getPlano() {
        return plano;
    }

    public void setPlano(Plano plano) {
        this.plano = plano;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Impacto impacto = (Impacto) o;
        return id.equals(impacto.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
