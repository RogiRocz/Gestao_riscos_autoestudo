package br.ufc.quixada.npi.gestaoriscos.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.util.List;

@Entity
public class AcaoPreventiva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(columnDefinition="TEXT")
    private String descricao;

    @Enumerated(EnumType.STRING)
    private Status status;

    @JsonIgnore
    @ManyToOne
    private PlanoTratamento planoTratamento;

    @OrderBy("data ASC")
    @OneToMany(mappedBy = "acaoPreventiva", cascade =  CascadeType.ALL, orphanRemoval = true)
    private List<MonitoramentoAcao> monitoramentos;

    public enum Status {
        NAO_INICIADA("Não iniciada"),
        EM_ANDAMENTO("Em andamento"),
        FINALIZADA("Finalizada"),
        CANCELADA("Cancelada");


        private final String descricao;

        Status(String descricao){
            this.descricao = descricao;
        }

        public String getDescricao() {
            return descricao;
        }
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Status getStatus() {
        return status;
    }

    public PlanoTratamento getPlanoTratamento() {
        return planoTratamento;
    }

    public void setPlanoTratamento(PlanoTratamento planoTratamento) {
        this.planoTratamento = planoTratamento;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public List<MonitoramentoAcao> getMonitoramentos() {
        return monitoramentos;
    }

    public void setMonitoramentos(List<MonitoramentoAcao> monitoramentos) {
        this.monitoramentos = monitoramentos;
    }
}
