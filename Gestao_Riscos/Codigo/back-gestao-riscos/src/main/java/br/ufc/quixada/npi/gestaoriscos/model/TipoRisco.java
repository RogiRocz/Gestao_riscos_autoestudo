package br.ufc.quixada.npi.gestaoriscos.model;

public enum TipoRisco {
	AMEACA("Ameaça"),
	OPORTUNIDADE("Oportunidade");


	private final String tipo;

	TipoRisco(String tipo){
		this.tipo = tipo;
	}

	public String getTipo() {
		return tipo;
	}



}
