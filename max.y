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
int ck=0;
int flag=0;
%}
%token NUMBER TOKEN PRINT SERIES_MEDIAN MAX
%%
sum_statement : user_func { };

user_func : MAX '(' NUMBER ',' NUMBER ')' {
        //printf("number=%d ",$3);
        //printf("number=%d ",$5);
		if($3<$5)
			{
			   printf("%d ",$5);
			}
		 
			 else
			 {
				printf("%d ",$3);
			 } 
			 
         }
		| SERIES_MEDIAN '(' NUMBER ',' NUMBER ')' {

				count_start=$3;
				count_end=$5;

			
			for(var=$3;var<=$5;var++){
				sum++;	
			}
			ck=$3+$5;
			//printf("ck=%d ",ck);
			printf("sum=%d ",sum);
			if(sum%2==0)
			{
			   printf("%d ",(ck)/2+1);
			    printf("%d ",(ck)/2);
			    
			  	
			 }
			 else
			 {
			   printf("%d ",(ck)/2);
			      
			 }
			
			
		};


%%
int main(){
	FILE *file;
	file = fopen("max.c", "r") ;
	if (!file) {
		printf("couldnot open file");
		exit (1);	
	}
	else {
		yyin = file;
	}
	yyparse();
}
