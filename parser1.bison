%{
#include <stdio.h>
extern char *yytext;
extern int yylex();
extern int yyerror( char *str );
extern int yylineno;
%}

%union {
    struct decl *decl;
    struct stmt *stmt;
    struct symbol *symbol;
    struct expr *expr;
    struct type *type;
    char* name;

}

// Everything of one type can only interact with other things of the same type
%type <decl> program programs func type line expr term
%type <stmt> 
%type <symbol>
%type <expr>
%type <type> type assign

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
program: programs { parser_result = $1; }
       | %empty { parser_result = NULL; }
       ;

programs: func { $$ = decl_create($1, $3,0,0,0); }
        ;


func: TOKEN_IDENT TOKEN_COLON TOKEN_FUNCTION type TOKEN_LPARENT param TOKEN_RPARENT TOKEN_ASS TOKEN_LBRACKET body TOKEN_RBRACKET
    | TOKEN_IDENT TOKEN_COLON TOKEN_FUNCTION type TOKEN_LPARENT TOKEN_RPARENT TOKEN_ASS TOKEN_LBRACKET body TOKEN_RBRACKET
    ;
param: TOKEN_IDENT TOKEN_COLON type
     | TOKEN_IDENT TOKEN_COLON type ", " param
     ;

body: line TOKEN_RETURN TOKEN_IDENT TOKEN_SEMICOLON 
    | line TOKEN_RETURN TOKEN_NUMBER TOKEN_SEMICOLON 
    | line
    ;

line: expr TOKEN_SEMICOLON
    | expr TOKEN_SEMICOLON line
    ;

expr: assign 
    | term compare term
    | term TOKEN_ADD term
    | term TOKEN_SUBTRACT term
    | term
    | TOKEN_QUOTE expr TOKEN_QUOTE
    ;
assign: TOKEN_IDENT TOKEN_COLON type
      | TOKEN_IDENT TOKEN_COLON type TOKEN_ASS line
      | TOKEN_IDENT TOKEN_ASS expr
      ;
term: term TOKEN_STAR factor
    | term TOKEN_DIVIDE factor
    | factor
    ;
compare: EQ
       | GT 
       | GE 
       | LE 
       | NE
       ;

factor: TOKEN_SUBTRACT factor
      | TOKEN_IDENT
      | TOKEN_TRUE
      | TOKEN_FALSE
      | TOKEN_NUMBER
      ;


type: TOKEN_VOID
    | TOKEN_INTEGER
    | TOKEN_STRING
    | TOKEN_BOOLEAN
    | TOKEN_CHAR
    ;
%%

/* If statements? */
//int yywrap() { return 0; } 
//int yywrap();
/* Array not implemented */
/* expr TOKEN_SEMICOLON { return 0; } */
/* From programs: | func expr TOKEN_SEMICOLON { printf(" programs "); } */
/* From line: | expr TOKEN_SEMICOLON */

int yyerror(char *str)
{
     printf("parse error: %s on line %d\n",str, yylineno);
     //return 0;
}