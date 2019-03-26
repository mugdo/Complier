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
int id;
%}
%token NUMBER TOKEN PRINT FOR TO
%%
for_statement : for_cond statement { };

for_cond : token '(' expression ')' { int count = 0;};

expression: TOKEN '=' NUMBER TO TOKEN '=' NUMBER ';' NUMBER { var=$1; count_start=$3; count_end=$7; id=$9; };

statement: command TOKEN {
	printf("%d %d ",var,$2);	
	if ( var == $2 ) {
		if( count_start <= count_end ){
			for ( var = count_start ; var <= count_end ; var += id ) {
				printf("%d ",var);		
			}
		}
		else{
			for( var = count_start ; var >= count_end ; var -= id ) {
				printf("%d ",var);		
			}
		}
	}
};
	
command: PRINT { };
token: FOR { };
%%
int main(){
	FILE *file;
	file = fopen("for.c", "r") ;
	if (!file) {
		printf("couldnot open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}

