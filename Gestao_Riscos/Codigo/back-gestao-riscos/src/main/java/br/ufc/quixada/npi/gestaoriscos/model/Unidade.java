package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.util.List;

@Entity
public class Unidade {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@NotEmpty
	private String nome;

	private String sigla;

	private boolean excluida;

	@ManyToOne
	@JsonIgnore
	private Usuario chefe;

	@ManyToOne
	@JsonIgnore
	private Usuario viceChefe;

	@ManyToOne
	@JsonIgnore
	private Unidade unidadePai;

	@JsonIgnore
	@OneToMany
	private List<Usuario> equipe;

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

	public boolean isExcluida() {
		return excluida;
	}

	public void setExcluida(boolean excluida) {
		this.excluida = excluida;
	}

	public Usuario getChefe() {
		return chefe;
	}

	public void setChefe(Usuario chefe) {
		this.chefe = chefe;
	}

	public Unidade getUnidadePai() {
		return unidadePai;
	}

	public void setUnidadePai(Unidade unidadePai) {
		this.unidadePai = unidadePai;
	}

	public String getSigla() {
		return sigla;
	}

	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

	public Usuario getViceChefe() {
		return viceChefe;
	}

	public void setViceChefe(Usuario viceChefe) {
		this.viceChefe = viceChefe;
	}

	public List<Usuario> getEquipe() {
		return equipe;
	}

	public void setEquipe(List<Usuario> equipe) {
		this.equipe = equipe;
	}
}