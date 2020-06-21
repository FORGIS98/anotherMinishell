%{
/*
Like LEX, yacc has 3 parts.
*/

#include <stdlib.h>
void yyerror(char *s); // Called by yacc when there is a syntax error

static int nComand; // Amount of commands in the line inserted
static char fileDescriptor[2]; // 0 for input, 1 for output
%}



%union { // Union let's us specify the diff types that the analyser can return.
  char *command;
}

%start PROMPT // Specifies the starting rule in the rules between %% %%
%token COMMAND // Tokens that we expect, doesn't need to hace the same name as the real token
%type <command> COMMAND // Type of COMMAND



%%
// Expected Input //           // Actions //

PROMPT   :                     {return(0);}
         | LINE '\n'           {nComand += 1; return(nComand);}
         ;

LINE     : 
         | PIPES DIR BCKGROUND
         ;

PIPES    : 
         | CMDFLAGS            {nComand += 1;}
         | PIPES '|' CMDFLAGS  {nComand += 1;}
         ;

CMDFLAGS :
         | COMMAND             {}
         | CMDFLAGS COMMAND    {}
         ;
%%

void yyerror(char *s){
  fprintf(stderr, "%s\n", s);
}

int yywrap(void){
  return 1;
}
