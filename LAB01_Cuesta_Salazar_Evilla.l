%option yylineno

%{
	#include<stdio.h>
	#include <string.h>
	#include "y.tab.h"
	
    int linenum = 1;
	extern char* yylval;
%}
DIGITO [0-9]+
LETRA  [a-zA-Z]+
VARIABLE [a-zA-Z_][a-zA-Z0-9_]*
VALOR [0-9]+
%%
"include"|"main"|"void"								{return P_RESERVADA;}
"define"											{return P_DEFINE;}
"return"											{return P_RETURN;}
"+"|"-"|"*"|"/"										{return OPERADOR;}
"++"|"--"											{return P_INCREMENTO;}
"{"													{return A_LLAVE;}
"}"													{return C_LLAVE;}
"("													{return A_PARENTESIS;}
")"													{return C_PARENTESIS;}
"]"													{return C_CORCHETE;}
"["													{return A_CORCHETE;}
";"													{return FIN_SENTENCIA;}
"int"|"double"										{return TIPO_DATO;}
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
"stdio.h"|"stdlib.h"|"string.H"						{return LIBRERIAS;}
"if"             									{return P_IF;}
"else"             									{return P_ELSE;}
{VARIABLE}											{ return NOMBRE_VARIABLE;}
{VALOR}												{return VALOR_NUMERICO;}
^(.|\n)   											 {++linenum; }

%%