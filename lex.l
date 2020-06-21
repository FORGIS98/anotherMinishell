%{
/* 
LEX file contains 3 parts:
1. Firts the definitions, global C code, and some other configs and headers between the %{ %}
2. Second the rules, patterns and actions between the %% %%
3. Third the subroutines
*/ 

#include "y.tab.h" // Here I have my tokens define with there actions, this file is generated after yacc.y
%}

%%
[|&<>\n]                  {return strdup(yytext);}
[a-zA-Z][a-zA-Z]*         {yylval.command = strdup(yytext); return COMMAND;}
[ \t\n]                   {; // Ignore any white space, tabs...}
%%

// yywrap is called by lex when input is exhausted.
// Return 1 if you are done or 0 if more processing is required.
int yywrap(void){
  return 1;
}
