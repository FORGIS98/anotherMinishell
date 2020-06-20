#include <stdio.h>
#include "myTokens.h"

extern int yylex(); // Main entry-point for lex, returns token
extern int yylineno; // Line number for files, TODO: delete this line if no needed
extern char *yytext; // Pointer to the matched string

char *names[] = {NULL}; // myTokens start at 1

int main(){
  int nameToken, valueToken;
  nameToken = yylex(); // Return the 1 valid token

  while(nameToken) { // lex will return a EOF when finish, EOF = 0
    printf("token ID: %d\n", nameToken);
    printf("token VALUE: %s\n", yytext);
    nameToken = yylex(); // Return next valid token
  }

  return 0;

}
