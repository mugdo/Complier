%{
#include "y.tab.h"
extern int yylval;
%}
%%
[0-9]+ {yylval=atoi(yytext);return NUMBER;}
(sqrt)  {return SQRT;}
[ \t]+  {}
\n   {return 0;}
. {return yytext[0];}
%%