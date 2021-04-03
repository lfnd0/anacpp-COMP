package br.edu.analisador.cpp;

import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Paths;

public class AnalisadorLexicoCPP {

	public static void main(String[] args) throws IOException {
		String rootPath = Paths.get("").toAbsolutePath().toString();
		String subPath = "/src/br/edu/analisador/cpp/";

		String inputCPP = rootPath + subPath + "input.cpp";

		TokensCPP tokensCPP;

		DefinicoesAnalisadorLexicoCPP definicoesAnalisadorLexicoCPP = new DefinicoesAnalisadorLexicoCPP(
				new FileReader(inputCPP));

		while ((tokensCPP = definicoesAnalisadorLexicoCPP.yylex()) != null) {
			System.out.println("(" + tokensCPP.linha+ ", " + tokensCPP.nome + ", \"" + tokensCPP.valor + "\")");
		}
	}
}