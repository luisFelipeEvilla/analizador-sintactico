%{
	#include<stdio.h>
    #include<stdlib.h>
    #include<ctype.h>

    int yylex();
%}

%token P_RESERVADA
%token OPERADOR
%token A_LLAVE
%token C_LLAVE
%token A_PARENTESIS
%token C_PARENTESIS
%token A_CORCHETE
%token C_CORCHETE
%token FIN_SENTENCIA
%token TIPO_DATO
%token SIMBOLOS
%token P_FOR
%token P_DEFINE
%token P_RETURN
%token DIGITO
%token LETRA
%token P_INCREMENTO
%token P_DECREMENTO
%token NOMBRE_VARIABLE


%token NUMERO
%token S_COMA
%token S_MENOR
%token S_MAYOR
%token S_IGUAL
%token S_NUMERAL
%token LIBRERIAS
%start INICIO
%% 
	INICIO: INCLUDES FUNCION_PRINCIPAL;

	INCLUDES: S_NUMERAL P_RESERVADA S_MENOR LIBRERIAS S_MAYOR|S_NUMERAL P_DEFINE LETRA NUMERO;

	FUNCION_PRINCIPAL: TIPO_DATO P_RESERVADA A_PARENTESIS C_PARENTESIS A_LLAVE EXPRESIONES C_LLAVE;
	
	EXPRESIONES: DECLARACIONES_VARIABLES;
	
	DECLARACIONES_VARIABLES: VARIABLE FIN_SENTENCIA | VARIABLE DECLARACIONES_VARIABLES;
	
	VARIABLE: TIPO_DATO NOMBRE_VARIABLE | S_COMA NOMBRE_VARIABLE;

%%
extern int linenum;

int main(int argc, char **argv) {
    extern FILE *yyin, *yyout; 
    
	++argv, --argc;

    if ( argc > 0 ) {
        yyin = fopen( argv[0], "r" );

        yyout = fopen("salida.txt", "w"); 
    
        fprintf(yyout,"Prueba con el archivo de entrada  \n");

        if (yyparse() == 0) {
            fprintf(yyout,"Bien \n");
        } else { 
            fprintf(yyout,"Linea erronea. \n");  
        };

        return 0;
    } else
        printf("Error, debe pasar el nombre del archivo con codigo fuente como parametro asi: ./LAB01_Cuesta_Salazar_Evilla nombreArchivo.c \n");

        return 1;
}

int yywrap()
{
        return 1;
} 

void yyerror(char* mensaje){
	printf("\nAnalisis suspendido \n");
	printf("\nMensaje: %s en la linea %d \n",mensaje, linenum);
}