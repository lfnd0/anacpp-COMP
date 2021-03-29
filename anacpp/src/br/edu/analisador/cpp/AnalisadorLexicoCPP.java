package br.edu.analisador.cpp;

import java.nio.file.Paths;

public class AnalisadorLexicoCPP {

	public static void main(String[] args) {
		String rootPath = Paths.get("").toAbsolutePath().toString();
		String subPath = "src/br/edu/analisador/cpp/";
		
		String inputCPP = rootPath + subPath + "input.cpp";
		
		TokensCPP tokensCPP;
		
//		LexicalAnalyzer lexicalAnalyzer = new LexicalAnalyzer(new FileReader(inputCPP));
//		
//		while ((tokensCPP = lexicalAnalyzer.yylex()) != null) {
//			System.out.println("(" + tokensCPP.name + ", " + tokensCPP.value + tokensCPP.line + ")");
//		}
	}
}