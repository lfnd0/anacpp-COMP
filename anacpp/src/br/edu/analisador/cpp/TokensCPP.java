package br.edu.analisador.cpp;

public class TokensCPP {
	public String nome;
	public String valor;
	public Integer linha;

	public TokensCPP(String nome, String valor, Integer linha) {
		this.nome = nome;
		this.valor = valor;
		this.linha = linha;
	}
}