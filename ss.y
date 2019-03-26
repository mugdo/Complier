%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(const char *s){
	fprintf(stderr,"%s\n",s);
}
extern FILE *yyin;
int yylex();
int count=0;
int count_start;
int count_end;
int var=0;
int sum=0;
%}
%token NUMBER TOKEN PRINT SERIES_SUM SUM
%%
sum_statement : command user_func { };

user_func : SUM '(' NUMBER ',' NUMBER ')' { printf("%d ",$3+$5); }
		| SERIES_SUM '(' NUMBER ',' NUMBER ')' {
			if($1<$3){
				count_start=$1;
				count_end=$3;
			}
			else{
				count_start=$3;
				count_end=$1;
			}
			
			for(var=count_start;var<=count_end;var++){
				sum+=var;	
			}
			printf("%d ",sum);
		};
command : PRINT { };

%%
int main(){
	FILE *file;
	file = fopen("ss.c", "r") ;
	if (!file) {
		printf("couldnot open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}

