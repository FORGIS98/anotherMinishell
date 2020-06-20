basicCompile:
	lex lexer.l
	gcc minishell.c lex.yy.c -o minishell
