package br.edu.analisador.cpp;

%%

%{
    StringBuilder stringBuilder = new StringBuilder();
    private TokensCPP createTokensCPP(String nome, String valor) {
        return new TokensCPP(nome, valor, yyline);
    }
%}

%public
%class DefinicoesAnalisadorLexicoCPP
%type TokensCPP
%line
%state STRING

/* Comentarios e espacos vazios */
BLANK = [\n| |\t|\r]
COMMENTS = "//".*|"/*"~"*/"

/* Identificadores */
NON_DIGIT = [a-z|[A-Z]|_]
DIGIT = [0-9]
IDENTIFIER = {NON_DIGIT}+{DIGIT}*

/* Numeros */
NUMBER = {INTEGER} | {FLOAT}
INTEGER = ("0"|{INT_DEC}|{INT_HEX}|{INT_BIN})({INT_SUFFIX}?)
INT_DEC = [1-9]{DIGIT}*
HEX_DIG = [0-9|A-F|A-F]
INT_HEX = ("0x"|"0X"){HEX_DIG}+
INT_BIN = ("0b"|"0B")[0-1]+
INT_SUFFIX = ({L_SUFFIX}?{U_SUFFIX})|({U_SUFFIX}?{L_SUFFIX})
L_SUFFIX = "l"|"L"|"ll"|"LL"
U_SUFFIX = "u"|"U"
FLOAT = ({FRACTIONAL_CONSTANT}{EXPONENT_PART}?{FLOAT_SUFFIX}?)|{DIGIT_SEQUENCE}{EXPONENT_PART}{FLOAT_SUFFIX}?
DIGIT_SEQUENCE = {DIGIT}+
FRACTIONAL_CONSTANT = {DIGIT_SEQUENCE}?"."{DIGIT_SEQUENCE}
EXPONENT_PART = ("e"|"E")("+"|"-")?{DIGIT_SEQUENCE}
FLOAT_SUFFIX = "f"|"l"|"F"|"L"

/* Operadores */
BRACES_LEFT = "<%"|"{"
BRACES_RIGHT = "%>"|"}"
BRACKETS_LEFT = "<:"|"["
BRACKETS_RIGHT = ":>"|"]"
PRE_PROCESSOR = "%:"|"#"
MACRO = "%:%:":"##"
AND = "and"|"&&"
OR = "or"|"||"
XOR = "xor"|"^"
NOT = "not"|"!"
BIT_AND = "bitand"|"&"
BIT_OR = "bitor"|"|"
BIT_NOT = "compl"|"~"
AND_EQ = "and_eq"|"&="
OR_EQ = "or_eq"|"!="
XOR_EQ = "xor_eq"|"^="
NOT_EQ = "not_eq"|"!="

/* Palavras reservadas */
KEYWORD = "alignas"|"alignof"|"asm"|"auto"|"bool"|"break"|"case"|"catch"|"char"|"char16_t"|"char32_t"|"class"|"const"|"constexpr"|
"const_cast"|"continue"|"decltype"|"default"|"delete"|"do"|"double"|"dynamic_cast"|"else"|"enum"|"explicit"|"export"|"extern"|"false"|
"float"|"for"|"friend"|"goto"|"if"|"inline"|"int"|"long"|"mutable"|"namespace"|"new"|"noexcept"|"nullptr"|"operator"|"private"|"protected"|
"public"|"register"|"reinterpret_cast"|"return"|"short"|"signed"|"sizeof"|"static"|"static_assert"|"static_cast"|"struct"|"switch"|"template"|
"this"|"thread_local"|"throw"|"true"|"try"|"typedef"|"typeid"|"typename"|"union"|"unsigned"|"using"|"virtual"|"void"|"volatile"|"wchar_t"|"while"

SINGLECHARACTER = [^\r\n\'\\]
STRINGCHARACTER = [^\r\n\"\\]

%%

<YYINITIAL> {
    {BLANK} {}
    {NUMBER} {return createTokensCPP("number", yytext());}
    {COMMENTS} {return createTokensCPP("comment", yytext());}

    /* Simbolos especiais */
    {BRACES_LEFT} {return createTokensCPP("operator", "{");}
    {BRACES_RIGHT} {return createTokensCPP("operator", "}");}
    "(" {return createTokensCPP("operator", "(");}
    ")" {return createTokensCPP("operator", ")");}
    {BRACKETS_LEFT} {return createTokensCPP("operator", "[");}
    {BRACKETS_RIGHT} {return createTokensCPP("operator", "]");}
    "," {return createTokensCPP("operator", ",");}
    ":" {return createTokensCPP("operator", ":");}
    ";" {return createTokensCPP("operator", ";");}
    {PRE_PROCESSOR} {return createTokensCPP("operator", "preProcessor");}
    {MACRO} {return createTokensCPP("operator", "macro");}
    "..." {return createTokensCPP("operator", "...");}

    /* Operadores aritmeticos */
    "+" {return createTokensCPP("operator", "+");}
    "-" {return createTokensCPP("operator", "-");}
    "*" {return createTokensCPP("operator", "*");}
    "/" {return createTokensCPP("operator", "/");}
    "%" {return createTokensCPP("operator", "%");}
    "++" {return createTokensCPP("operator", "++");}
    "--" {return createTokensCPP("operator", "--");}

    /* Operadores relacionais */
    "==" {return createTokensCPP("operator", "==");}
    {NOT_EQ} {return createTokensCPP("operator", "notEqualsTo");}
    "<=" {return createTokensCPP("operator", "<=");}
    ">=" {return createTokensCPP("operator", ">=");}
    "<" {return createTokensCPP("operator", "<");}
    ">" {return createTokensCPP("operator", ">");}

    /* Operadores logicos */
    {AND} {return createTokensCPP("operator", "&&");}
    {OR} {return createTokensCPP("operator", "||");}
    {NOT} {return createTokensCPP("operator", "!");}

    /* Operadores bitwise */
    {BIT_AND} {return createTokensCPP("operator", "bitAnd");}
    {BIT_OR} {return createTokensCPP("operator", "bitOr");}
    {BIT_NOT} {return createTokensCPP("operator", "bitNot");}
    {XOR} {return createTokensCPP("operator", "xor");}
    ">>" {return createTokensCPP("operator", ">>");}
    "<<" {return createTokensCPP("operator", "<<");}

    /* Operadores de atribuicao */
    "=" {return createTokensCPP("operator", "=");}
    "+=" {return createTokensCPP("operator", "+=");}
    "*=" {return createTokensCPP("operator", "*=");}
    "/=" {return createTokensCPP("operator", "/=");}
    "-=" {return createTokensCPP("operator", "-=");}
    "%=" {return createTokensCPP("operator", "%=");}
    {AND_EQ} {return createTokensCPP("operator", "andAssign");}
    {XOR_EQ} {return createTokensCPP("operator", "xorAssign");}
    {OR_EQ} {return createTokensCPP("operator", "orAssign");}
    "<<=" {return createTokensCPP("operator", "<<=");}
    ">>=" {return createTokensCPP("operator", ">>=");}

    /* Operadores booleanos */
    "true" {return createTokensCPP("boolean", yytext());}
    "false" {return createTokensCPP("boolean", yytext());}
    
    /* Caracteres diversos */
    \'{SINGLECHARACTER}\' {return createTokensCPP("character", yytext());}
    \" {yybegin(STRING); stringBuilder.setLength(0);}
    
    /* Palavras reservadas */
    {KEYWORD} {return createTokensCPP("keyword", yytext());}
    
    /* Identificadores */
    {IDENTIFIER} {return createTokensCPP("identifier", yytext());}
    
    /* Caracteres invalidos */
    . {throw new RuntimeException("invalid character" + yytext());}
}

<STRING> {
    \" {yybegin(YYINITIAL); return createTokensCPP("string", stringBuilder.toString());}
    {STRINGCHARACTER}+ {stringBuilder.append(yytext());}
    "\\b" {stringBuilder.append('\b');}
    "\\t" {stringBuilder.append('\t');}
    \r|\n|\r\n {yybegin(YYINITIAL);}
}