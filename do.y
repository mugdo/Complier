%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(const char *s){
	fprintf(stderr,"%s\n",s);
}
extern FILE *yyin;
int yylex();
int count_start;
int count_end;
int var;
int inc;
%}
%token NUMBER TOKEN PRINT DO WHILE
%%
do_while_statement : start do_statement while_cond { };

do_statement : DO '{' statement '}' { };

while_cond : WHILE '(' expression ')' { };

expression : TOKEN '=' NUMBER ':' NUMBER {
	count_end = $3;
	inc = $5;
	
	do{
		printf("%d ",var);
		var+=inc;
	}while(var<=count_end);
	
//	var+=inc;
//	while(var<=count_end)
//	{
//		printf("%d ",var);
//		var+=inc;
//	}
};

start : TOKEN '=' NUMBER { count_start= $3; };

statement : command TOKEN {
	var=count_start;
	
	//printf("%d ",var);
};

command : PRINT { };

%%
int main(){
	FILE *file;
	file = fopen("do.c", "r") ;
	if (!file) {
		printf("couldnot open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}

