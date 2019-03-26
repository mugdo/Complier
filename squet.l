%{
#include "y.tab.h"
extern int lexval;
%}
%%
[0-9]+ {yylval=atoi(yytext);return NUMBER;}
(sqrt)  {return SQRT;}
(pow)   {return POW;}
[ \t]+  {}
\n   {return 0;}
. {return yytext[0];}
%%
