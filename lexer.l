%{
/* 
LEX file contains 3 parts:
1. Firts the definitions, global C code, and some other configs and headers like myTokens.h between the %{ %}
2. Second the rules, patterns and actions between the %% %%
3. Third the subroutines
*/ 

#include "myTokens.h"
%}

%%
[a-zA-Z][a-zA-Z]*         return COMMAND;
-[a-zA-Z][a-zA-Z]*        return FLAG;
"|"                       return PIPE;
[ \t\n]                   ; // Ignore any white space, tabs...
.                         printf("Error: Unexpected Token"); // For anything else error
%%

// yywrap is called by lex when input is exhausted.
// Return 1 if you are done or 0 if more processing is required.
int yywrap(void){
  return 1;
}
