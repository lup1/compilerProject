%{
#include <stdio.h>
extern char *yytext;
extern int yylex();
extern int yyerror( char *str );
extern int yylineno;
%}

%token TOKEN_EOF
%token TOKEN_SKIP
%token TOKEN_LPARENT
%token TOKEN_RPARENT
%token TOKEN_LBRACKET
%token TOKEN_RBRACKET
%token TOKEN_SEMICOLON
%token TOKEN_COLON
%token TOKEN_STAR
%token TOKEN_ADD
%token TOKEN_SUBTRACT
%token TOKEN_DIVIDE
%token TOKEN_INCREMENT
%token TOKEN_DECREMENT
%token TOKEN_LOGAND
%token TOKEN_LOGOR
     
%token TOKEN_QUOTE
%token TOKEN_COMMENT
%token TOKEN_OCOMMENT
%token TOKEN_CCOMMENT
%token TOKEN_WHILE
%token TOKEN_IF
%token TOKEN_ELSE
%token TOKEN_FUNCTION
%token TOKEN_VOID
%token TOKEN_INTEGER
%token TOKEN_BOOLEAN
%token TOKEN_CHAR
%token TOKEN_STRING
%token TOKEN_TRUE
%token TOKEN_FALSE
%token TOKEN_PRINT
%token TOKEN_RETURN
%token TOKEN_IDENT
%token TOKEN_NUMBER
     
%token TOKEN_ASS
%token GT
%token LT
%token GE
%token LE
%token EQ
%token NE
%token TOKEN_ERROR


%%
program: programs
       ;

programs:  "global" assign; 
         | func { printf(" programs; func "); }
         ;

func: TOKEN_IDENT TOKEN_COLON TOKEN_FUNCTION type TOKEN_LPARENT TOKEN_RPARENT TOKEN_ASS TOKEN_LBRACKET body TOKEN_RBRACKET { printf(" func "); }
    | TOKEN_IDENT TOKEN_COLON TOKEN_FUNCTION type TOKEN_LPARENT expr TOKEN_RPARENT TOKEN_ASS TOKEN_LBRACKET body TOKEN_RBRACKET { printf(" func w param "); }
    ;

body: line TOKEN_RETURN TOKEN_INTEGER
    | line TOKEN_RETURN TOKEN_IDENT
    ;

line: expr TOKEN_SEMICOLON
    ;

expr : term TOKEN_ADD term { printf(" expr add \n"); }
     | term TOKEN_SUBTRACT term { printf(" expr sub \n"); }
     | term { printf(" expr term \n"); }
     | assign { printf(" expr assign \n"); }
     | factor TOKEN_INCREMENT { printf(" expr factor inc \n"); }
     | factor TOKEN_DECREMENT { printf(" expr factor dec \n"); }
     | comment { printf(" expr comment \n"); }
     | ifstatment { printf(" expr ifstatement \n"); }
     ;

term : term TOKEN_STAR factor { printf(" term mult \n"); }
     | term TOKEN_DIVIDE factor { printf(" term div \n"); }
     | factor { printf(" term factor \n"); }
     ;

factor: TOKEN_SUBTRACT factor { printf(" factor neg num \n"); }
      | TOKEN_LPARENT expr TOKEN_RPARENT { printf(" factor parens \n"); }
      | TOKEN_NUMBER { printf(" factor token_number \n"); }
      | TOKEN_IDENT { printf(" factor token_identifier \n"); }
      ;

assign: TOKEN_IDENT TOKEN_COLON type TOKEN_ASS line { printf(" assign defined val \n"); }
      | TOKEN_IDENT TOKEN_COLON type { printf(" assign undefined val \n"); }
      ;


type: TOKEN_VOID
     | TOKEN_BOOLEAN
     | TOKEN_INTEGER
     | TOKEN_CHAR
     | TOKEN_STRING
     ;

ifstatment: TOKEN_IF TOKEN_LPARENT boolstat TOKEN_RPARENT expr TOKEN_ELSE expr
          ;

boolstat: compare
        | boolstat TOKEN_LOGAND
        | boolstat TOKEN_LOGOR
        ;

compare: expr EQ expr
       | expr GT expr
       | expr GE expr
       | expr LE expr
       | expr NE expr
       ;

comment: TOKEN_OCOMMENT expr TOKEN_CCOMMENT
       | TOKEN_COMMENT expr
       ;

%%

/* If statements? */
//int yywrap() { return 0; } 
//int yywrap();
/* Array not implemented */
/* expr TOKEN_SEMICOLON { return 0; } */
/* From programs: | func expr TOKEN_SEMICOLON { printf(" programs "); } */

int yyerror(char *str)
{
     printf("parse error: %s on line %d\n",str, yylineno);
     //return 0;
}