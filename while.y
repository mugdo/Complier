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
int var=0;
int dec;
%}
%token NUMBER TOKEN PRINT WHILE
%%
while_statement : while_cond statement { };

while_cond : token '(' expression ')' { int count = 0; };

expression: TOKEN '=' NUMBER ':' NUMBER ':' NUMBER { var=$1; count_start=$7; dec=$5; count_end=$3; };

statement: command TOKEN { if(var==$2){
	var=count_start;
	while(var>=count_end){
		printf("%d ",var);	
		var=var-dec;	
	}
} };
command: PRINT { };
token: WHILE { };

%%
int main(){
	FILE *file;
	file = fopen("while.c", "r") ;
	if (!file) {
		printf("couldnot open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}

