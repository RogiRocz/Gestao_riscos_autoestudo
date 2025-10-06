package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
public class PlanoTratamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    private RespostaRisco resposta;

    @ManyToOne
    private Usuario responsavel;

    @Column(columnDefinition="TEXT")
    private String descricao;

    @Column(columnDefinition="TEXT")
    private String justificativa;

    @Column(columnDefinition="TEXT")
    private String monitoramento;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate inicio;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate termino;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate dataPlanejamento;

    @Column(nullable = false, columnDefinition = "boolean default false")
    private boolean status;

    @OrderBy("status ASC")
    @OneToMany(mappedBy = "planoTratamento", cascade = CascadeType.ALL)
    private List<AcaoPreventiva> acoesPreventivas;

    @ManyToOne
    private AvaliacaoRisco avaliacao;

    @ManyToOne
    private Unidade unidade;

    @ManyToMany
    private List<Unidade> unidadesCompartilhadas;

    @JsonIgnore
    @ManyToOne
    private Risco risco;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public RespostaRisco getResposta() {
        return resposta;
    }

    public void setResposta(RespostaRisco resposta) {
        this.resposta = resposta;
    }

    public Usuario getResponsavel() {
        return responsavel;
    }

    public void setResponsavel(Usuario responsavel) {
        this.responsavel = responsavel;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getJustificativa() {
        return justificativa;
    }

    public void setJustificativa(String justificativa) {
        this.justificativa = justificativa;
    }

    public String getMonitoramento() {
        return monitoramento;
    }

    public void setMonitoramento(String monitoramento) {
        this.monitoramento = monitoramento;
    }

    public LocalDate getInicio() {
        return inicio;
    }

    public void setInicio(LocalDate inicio) {
        this.inicio = inicio;
    }

    public LocalDate getTermino() {
        return termino;
    }

    public void setTermino(LocalDate termino) {
        this.termino = termino;
    }

    public LocalDate getDataPlanejamento() {
        return dataPlanejamento;
    }

    public void setDataPlanejamento(LocalDate dataPlanejamento) {
        this.dataPlanejamento = dataPlanejamento;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Unidade getUnidade() {
        return unidade;
    }

    public void setUnidade(Unidade unidade) {
        this.unidade = unidade;
    }

    public Risco getRisco() {
        return risco;
    }

    public void setRisco(Risco risco) {
        this.risco = risco;
    }

    public AvaliacaoRisco getAvaliacao() {
        return avaliacao;
    }

    public void setAvaliacao(AvaliacaoRisco avaliacao) {
        this.avaliacao = avaliacao;
    }

    public List<AcaoPreventiva> getAcoesPreventivas() {
        return acoesPreventivas;
    }

    public void setAcoesPreventivas(List<AcaoPreventiva> acoesPreventivas) {
        this.acoesPreventivas = acoesPreventivas;
    }

    public List<Unidade> getUnidadesCompartilhadas() {
        return unidadesCompartilhadas;
    }

    public void setUnidadesCompartilhadas(List<Unidade> unidadesCompartilhadas) {
        this.unidadesCompartilhadas = unidadesCompartilhadas;
    }
}
