%{
/*
Like LEX, yacc has 3 parts.
*/

#include <stdlib.h>
void yyerror(char *s); // Called by yacc when there is a syntax error

static int nComand; // Amount of commands in the line inserted
static int inBackground; // if(1) command in background = true
static char *fileDescriptor[2]; // 0 for input, 1 for output
static char **commandMatrix; // [X][Y] X for command and Y for flags

static void separateFlags(char *arguments);
static int flagsFound; // if(1) we've found "-al" or "-a -l" for example
static int flagAmount; // Number of flags on each command
static int commandAmount; // Number of commands
%}



%right '|'
%union { // Union let's us specify the diff types that the analyser can return.
  char *command;
}

%start PROMPT // Specifies the starting rule in the rules between %% %%
%token COMMAND // Tokens that we expect, doesn't need to hace the same name as the real token
%type <command> COMMAND // Type of COMMAND



%%
// Expected Input //              // Actions //

PROMPT    :                       {return(0);}
          | LINE '\n'             {nComand += 1; return(nComand);}
          ;

LINE      : 
          | PIPES DIR BCKGROUND
          ;

PIPES     : 
          | CMDFLAGS              {nComand += 1;}
          | PIPES '|' CMDFLAGS    {nComand += 1;}
          ;

CMDFLAGS  :
          | COMMAND               {separateFlags($1);}
          | CMDFLAGS COMMAND      {separateFlags($2);}
          ;

DIR       :
          | '<' COMMAND DIR       {fileDescriptor[0] = $2;}
          | '>' COMMAND DIR       {fileDescriptor[1] = $2;}
          | '>' '&' COMMAND DIR   {fileDescriptor[1] = $2;}
          ;

BCKGROUND :
          | '&'                   {inBackground = 1;}
          ;
%%

void yyerror(char *s){
  fprintf(stderr, "%s\n", s);
}

int yywrap(void){
  return 1;
}

static void separateFlags(char *args){
  if(strcmp(args[0], '-')){ // true = not a flag
    flagAmount = 0;    
    commandAmount += 1;
    commandMatrix = realloc(commandMatrix, (commandAmount) * sizeof(char *));
    
    if(commandMatrix == NULL)
      exit(1);

    commandMatrix[commandAmount - 1] = args;
  }
  else{
    flagAmount += 1;
    amount = commandAmount - 1
    commandMatrix[amount] = realloc(commandMatrix[amount], (flagAmount) * sizeof(char *));

    if(commandMatrix[amount] == NULL)
      exit(1);

    commandMatric[amount][flagAmount - 1] = args
  }
}

int getData(char ***commandM, char *fileDesc[2], int *inBck){
  



  return yyparse();
}
