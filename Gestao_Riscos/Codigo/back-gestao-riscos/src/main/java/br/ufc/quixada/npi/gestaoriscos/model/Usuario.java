package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Entity
public class Usuario implements UserDetails {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@NotEmpty
	private String nome;

	@NotEmpty
	private String cargo;

	@NotEmpty
	@Column(unique = true)
	private String email;

	@JsonIgnore
	@NotEmpty
	private String password;

	private boolean habilitado;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name = "unidade_id")
	private Unidade unidade;

	@ElementCollection(fetch = FetchType.EAGER)
	@CollectionTable(name = "usuario_roles", joinColumns = @JoinColumn(name = "usuario_id"))
	@Column(name = "role")
	private List<String> roles;

	public Usuario() {
	}

	public Usuario(String nome, String cargo, String email, String password, boolean habilitado) {
		this.nome = nome;
		this.cargo = cargo;
		this.email = email;
		this.password = password;
		this.habilitado = habilitado;
	}

	public String getCargo() {
		return cargo;
	}

	public void setCargo(String cargo) {
		this.cargo = cargo;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Unidade getUnidade() {
		return unidade;
	}

	public void setUnidade(Unidade unidade) {
		this.unidade = unidade;
	}

	public boolean isHabilitado() {
		return habilitado;
	}

	public void setHabilitado(boolean habilitado) {
		this.habilitado = habilitado;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		if (this.roles == null) {
			return Collections.emptyList();
		}
		return this.roles.stream()
				.map(SimpleGrantedAuthority::new)
				.collect(Collectors.toList());
	}

	@Override
	public String getPassword() {
		return this.password;
	}

	@Override
	public String getUsername() {
		return this.email;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return this.habilitado;
	}

	public List<String> getRoles() {
		return roles;
	}

	public void setRoles(List<String> roles) {
		this.roles = roles;
	}

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nome='" + nome + '\'' +
                ", cargo='" + cargo + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", habilitado=" + habilitado +
                ", unidade=" + unidade +
                ", roles=" + roles +
                '}';

    }

}