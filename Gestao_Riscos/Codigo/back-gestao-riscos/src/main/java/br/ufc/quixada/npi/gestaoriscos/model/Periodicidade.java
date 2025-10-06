package br.ufc.quixada.npi.gestaoriscos.model;

public enum Periodicidade {
	
	DIARIA("Diária"),
	SEMANAL("Semanal"),
	QUINZENAL("Quinzenal"),
	MENSAL("Mensal"),
	BIMESTRAL("Bimestral"),
	TRIMESTRAL("Trimestral"),
	SEMESTRAL("Semestral"),
	ANUAL("Anual");
	
	private final String periocidadeAvaliacao;
	
	private Periodicidade(String periocidadeAvaliacao) {
		this.periocidadeAvaliacao = periocidadeAvaliacao;
	}

	public String getPeriocidadeAvaliacao() {
		return periocidadeAvaliacao;
	}
	

	
}