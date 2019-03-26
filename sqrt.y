%{
#include<stdio.h>
#include<math.h>
void yyerror (const char *s){
fprintf(stderr,"%s",s);
}
%}
%token NUMBER SQRT
%%
Statement : expression { printf("=%d\n",$1); }
expression : expression '+' term {$$=$1+$3;}
           |expression '-' term {$$=$1-$3;}
           |term {$$=$1;};
           
term: term '*' factor  {$$=$1*$3;}
     |term '/' factor  
      if($3==0){
          printf("Error\n");
      }
      else{
        $$=$1/$3;
      }
     |factor {$$=$1;};
     
factor: SQRT '(' NUMBER ')' {$$=sqrt($3);}
      |factor1 {$$=$1;};
      
factor1:'[' expression ']' {$$=$2;}
      |factor2 {$$=$1;};
      
factor2:'{' expression '}' {$$=$2;}
      |factor3 {$$=$1;};
      
factor3:'(' expression ')' {$$=$2;}
      |NUMBER {$$=$1;};
%%
