package br.edu.analisador.cpp;

import java.io.File;
import java.nio.file.Paths;

public class GeradorAnaliseLexicaCPP {

	public static void main(String[] args) {
		String rootPath = Paths.get("").toAbsolutePath().toString();
		String subPath = "src/br/edu/analisador/cpp/";

		String flexCPP = rootPath + subPath + "cpp.flex";

		File file = new File(flexCPP);

		jflex.Main.generate(file);
	}
}