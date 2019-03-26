%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
void yyerror (const char *s){
fprintf(stderr,"%s",s);
}
extern FILE *yyin;
%}
%token NUMBER SQRT POW
%%
Statement:expression {printf("=%d\n",$1);}
expression: expression '+' term {$$=$1+$3;}
           |expression '-' term {$$=$1-$3;}
           |term {$$=$1;}
           ;
term: term '*' factor  {$$=$1*$3;}
     |term '/' factor  
      { 
			if($3==0.0) 
				yyerror ("divide by zero");
			else
				$$ = $1 / $3;
		}
     |factor {$$=$1;}
     ;
factor: SQRT '(' factor ')' {$$=sqrt($3);}
      |POW '(' factor '^' NUMBER ')' {$$=pow($3,$5);}
      |factor2 {$$=$1;}
         ;
factor2:'[' expression ']' {$$=$2;}
      |factor3 {$$=$1;}
      ;
factor3:'{' expression '}' {$$=$2;}
      |factor4 {$$=$1;}
      ;
factor4:'(' expression ')' {$$=$2;}
      |NUMBER {$$=$1;}
      
      ;
%%

int main(){
	FILE *file;
	file = fopen("code.c", "r") ;
	if (!file) {
		printf("couldnot open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}
