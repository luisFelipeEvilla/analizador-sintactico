%{
	#include<stdio.h>
    #include<stdlib.h>
    #include<ctype.h>

%}

%start INICIO

%token P_MAIN
%token P_VOID
%token P_INCLUDE
%token P_FUNCION
%token P_DEFINE
%token LIBRERIA
%token P_CADENA

%token A_LLAVE
%token C_LLAVE
%token A_PARENTESIS
%token C_PARENTESIS
%token A_CORCHETE
%token C_CORCHETE

%token P_DEFIN
%token P_RETURN

%token TIPO_DATO

%token DIGITO
%token PALABRA
%token CADENA

%token P_FOR
%token P_WHILE
%token P_DO
%token P_IF
%token P_ELSE

%token NOMBRE_VARIABLE
%token VALOR_NUMERICO

%token NUMERO
%token S_COMA
%token FIN_SENTENCIA
%token S_MENOR
%token S_MENOR_IGUAL
%token S_MAYOR
%token S_MAYOR_IGUAL
%token S_COMPARAR
%token S_IGUAL
%token S_NUMERAL
%token S_COMILLAS

%token S_MAS
%token S_MENOS
%token S_DIVISION
%token S_MULTIPLICACION
%token S_MODULO
%token P_INCREMENTO
%token P_DECREMENTO

%token ERROR_LOCO

%% 
	INICIO: INCLUDES FUNCION_PRINCIPAL | FUNCION_PRINCIPAL;

	INCLUDES: S_NUMERAL P_INCLUDE S_MENOR LIBRERIA S_MAYOR;

	FUNCION_PRINCIPAL: P_VOID P_MAIN A_PARENTESIS C_PARENTESIS A_LLAVE EXPRESIONES C_LLAVE;
	
	EXPRESIONES:
        DECLARACIONES_VARIABLES | EXPRESIONES DECLARACIONES_VARIABLES
        | ASIGNACION FIN_SENTENCIA | EXPRESIONES ASIGNACION FIN_SENTENCIA
        | INCREMENTO FIN_SENTENCIA | EXPRESIONES INCREMENTO FIN_SENTENCIA
        | FUNCION FIN_SENTENCIA | EXPRESIONES FUNCION FIN_SENTENCIA
        | CICLO_FOR | EXPRESIONES CICLO_FOR
        | CICLO_WHILE | EXPRESIONES CICLO_WHILE
        | CICLO_DO_WHILE | EXPRESIONES CICLO_DO_WHILE
        | IF | EXPRESIONES IF
        | FUNCIONES | EXPRESIONES FUNCIONES;
        | EXPRESIONES error {printf("\nError en la linea %d \n", linenum);}
        | EXPRESIONES ERROR_LOCO
        | ERROR_LOCO
        | ;
	
	DECLARACIONES_VARIABLES: VARIABLE FIN_SENTENCIA | VARIABLE DECLARACIONES_VARIABLES;

    VARIABLE: TIPO_DATO NOMBRE_VARIABLE 
            | TIPO_DATO ASIGNACION
            | S_COMA NOMBRE_VARIABLE;
            | S_COMA ASIGNACION;

    ASIGNACION:
        NOMBRE_VARIABLE SIMBOLO_ASIGNACION VALOR_NUMERICO
        | NOMBRE_VARIABLE SIMBOLO_ASIGNACION NOMBRE_VARIABLE
        | NOMBRE_VARIABLE SIMBOLO_ASIGNACION OPERACION;
        
    SIMBOLO_ASIGNACION: S_IGUAL | S_MAS S_IGUAL | S_MENOS S_IGUAL;

    OPERACION:
        NOMBRE_VARIABLE OPERADOR NOMBRE_VARIABLE
        | NOMBRE_VARIABLE OPERADOR VALOR_NUMERICO
        | VALOR_NUMERICO OPERADOR NOMBRE_VARIABLE
        | VALOR_NUMERICO OPERADOR VALOR_NUMERICO;

    OPERADOR:
        S_MAS | S_MENOS | S_DIVISION | S_MULTIPLICACION | S_MODULO;

    CICLO_WHILE:
        P_WHILE A_PARENTESIS CONDICION C_PARENTESIS A_LLAVE EXPRESIONES C_LLAVE FIN_SENTENCIA;

    CICLO_FOR: 
        P_FOR A_PARENTESIS ASIGNACION CONDICION FIN_SENTENCIA INCREMENTO C_PARENTESIS A_LLAVE EXPRESIONES C_LLAVE FIN_SENTENCIA;
    
    CICLO_DO_WHILE:
        P_DO A_LLAVE EXPRESIONES C_LLAVE P_WHILE A_PARENTESIS CONDICION C_PARENTESIS FIN_SENTENCIA;
    
    IF:
        P_IF A_PARENTESIS CONDICION C_PARENTESIS A_LLAVE EXPRESIONES C_LLAVE FIN_SENTENCIA
        | P_IF A_PARENTESIS CONDICION C_PARENTESIS A_LLAVE EXPRESIONES C_LLAVE P_ELSE A_LLAVE EXPRESIONES C_LLAVE FIN_SENTENCIA;
    
    FUNCION:
        P_FUNCION A_PARENTESIS ARGUMENTOS C_PARENTESIS;

    ARGUMENTOS:
        NOMBRE_VARIABLE
        | ARGUMENTOS S_COMA NOMBRE_VARIABLE
        | CADENA
        | ARGUMENTOS S_COMA CADENA 
        | ;

    CONDICION: 
        NOMBRE_VARIABLE COMPARAR VALOR_NUMERICO
        | NOMBRE_VARIABLE COMPARAR NOMBRE_VARIABLE
        | NOMBRE_VARIABLE COMPARAR OPERACION
        | VALOR_NUMERICO COMPARAR VALOR_NUMERICO
        | VALOR_NUMERICO COMPARAR NOMBRE_VARIABLE
        | VALOR_NUMERICO COMPARAR OPERACION;
    
    COMPARAR: S_COMPARAR | S_MAYOR | S_MAYOR_IGUAL | S_MENOR | S_MENOR_IGUAL; 

    INCREMENTO: 
        NOMBRE_VARIABLE P_INCREMENTO
        | P_INCREMENTO NOMBRE_VARIABLE;
    
%%
extern int linenum;
extern int yylineno;

int main(int argc, char **argv) {
    extern FILE *yyin, *yyout; 
    
	++argv, --argc;

    if ( argc > 0 ) {
        yyin = fopen( argv[0], "r" );

        printf("\nPrueba con el archivo de entrada \n");

        if (yyparse() == 0) {
            printf("Bien \n");
        } else { 
            printf("Linea erronea. \n");  
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

void yyerror(const char* mensaje){
    printf("Error en la linea %d \n", yylineno);
}