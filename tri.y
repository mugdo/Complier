%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(const char *s){
	fprintf(stderr,"%s\n",s);
}
extern FILE *yyin;
int yylex();
int var=0;
int num1,num2;
int fix;
char indicate;
%}
%token NUMBER TOKEN PRINT SINE COSINE TANGENT AREA
%%
sine_cal : command func { };

func : token '(' expression ')' {
		var = $3;
		double pi = 3.14159265;
		double res;
		
		if ( fix == 1 )
			res = sin((var*pi)/180);
			
		else if ( fix == 2 )
			res = cos((var*pi)/180);
			
		else if ( fix == 3 ){
			if ( var == 90 )
				res = -9999;
			else
				res=tan((var*pi)/180);
		}
		else if ( fix == 4 ){
			if ( indicate == 'R' )
				res = num1 * num2;
			else if ( indicate == 'S' )
				res = var * var;
		}
		
		if ( res == -9999)
			printf("Error ");
		else
			printf("%lf ",res);
	};

expression : NUMBER ',' NUMBER { num1 = $1; num2 = $3; indicate = 'R'; }
			| NUMBER { var = $1; indicate = 'S'; };
			
command : PRINT { };

token : SINE { fix = 1; }
	| COSINE { fix = 2 ; }
	| TANGENT { fix = 3 ; }
	| AREA { fix = 4 ; };
%%
int main(){
	FILE *file;
	file = fopen("tri.c", "r") ;
	if (!file) {
		printf("couldnot open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}

