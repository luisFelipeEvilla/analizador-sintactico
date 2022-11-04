%option yylineno

%{
	#include<stdio.h>
	#include <string.h>
	#include "y.tab.h"
	
    int linenum = 1;
	extern char* yylval;
%}
DIGITO [0-9]+
CADENA ["][^"]+["]
PALABRA [^"]+
LIBRERIA [a-zA-Z0-9]+["."][a-zA-Z0-9]
VARIABLE [a-zA-Z_][a-zA-Z0-9_]*
VALOR [0-9]+
%%
"void"												{return P_VOID;}
"main"												{return P_MAIN;}
"include"											{return P_INCLUDE;}
"define"											{return P_DEFINE;}
"return"											{return P_RETURN;}
"+"                                                 {return S_MAS;}
"-"													{return S_MENOS;}
"*"													{return S_MULTIPLICACION;}
"/"													{return S_DIVISION;}
"%"													{return S_MODULO;}
"++"|"--"											{return P_INCREMENTO;}
"{"													{return A_LLAVE;}
"}"													{return C_LLAVE;}
"("													{return A_PARENTESIS;}
")"													{return C_PARENTESIS;}
"]"													{return C_CORCHETE;}
"["													{return A_CORCHETE;}
";"													{return FIN_SENTENCIA;}
"int"|"double"|"float"|"string"							{return TIPO_DATO;}
"\""													{return S_COMILLAS;}
"#"													{return S_NUMERAL;}
"<"													{return S_MENOR;}
"<="												{return S_MENOR_IGUAL;}
">"													{return S_MAYOR;}
">="												{return S_MAYOR_IGUAL;}
"=="												{return S_COMPARAR;}
","													{return S_COMA;}
"="													{return S_IGUAL;}
"for"												{return P_FOR;}
"while"												{return P_WHILE;}
"do"												{return P_DO;}
"print"|"printf"|"scanf"							{return P_FUNCION;}	
"if"             									{return P_IF;}
"else"             									{return P_ELSE;}
{VARIABLE}											{ return NOMBRE_VARIABLE;}
{CADENA}											{return CADENA;}
{VALOR}												{return VALOR_NUMERICO;}
{LIBRERIA}											{return LIBRERIA;}
[.\n]   											 {++linenum; }
%%