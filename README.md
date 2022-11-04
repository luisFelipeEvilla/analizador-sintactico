# analizador-sintactico

### uso

 yacc -d analizador.y && lex LAB01_Cuesta_Salazar_Evilla.l && gcc lex.yy.c y.tab.c -o analizador

 
yacc -d analizador.y && lex LAB01_Cuesta_Salazar_Evilla.l && gcc lex.yy.c y.tab.c -o analizador && ./analizador ./prueba.c  