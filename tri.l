%{
#include "y.tab.h"
extern int lexval;
%}
%%
"sin" {return SINE;}
"cos" {return COSINE;}
"tan" {return TANGENT;}
"area" {return AREA;}
"print" {return PRINT;}
[0-9]+ {yylval = atoi(yytext); return NUMBER;}
[a-z] {yylval = atoi(yytext-'a');return TOKEN;}
[ \t]+ {} /* ignore whitespace */
'\n' {return 0;} /* logical EOF */
. {return yytext[0];}
%%
