%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "decl.h"
#include "stmt.h"
#include "expr.h"
#include "type.h"
#include "param_list.h"

extern char *yytext;
extern int yylex();
extern int yyerror( char *str );
extern int yylineno;
extern struct decl *parser_result;
//extern void *parser_result;
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
%type <decl> program programs func body line expr //compare factor body term type assign
%type <stmt> compare factor
// %type <symbol> compare factor
%type <expr> term 
%type <type> type assign
// Try using create statements like the ones in the libraries

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

programs: func { $$ = $1; }
        ;


func: TOKEN_IDENT TOKEN_COLON TOKEN_FUNCTION type TOKEN_LPARENT param TOKEN_RPARENT TOKEN_ASS TOKEN_LBRACKET body TOKEN_RBRACKET
    | TOKEN_IDENT TOKEN_COLON TOKEN_FUNCTION type TOKEN_LPARENT TOKEN_RPARENT TOKEN_ASS TOKEN_LBRACKET body TOKEN_RBRACKET
    ;
param: TOKEN_IDENT TOKEN_COLON type
     | TOKEN_IDENT TOKEN_COLON type ", " param
     ;

body: line TOKEN_RETURN TOKEN_IDENT TOKEN_SEMICOLON {$$ = decl_create(STMT_RETURN, 0, $1, 0, 0);} 
    | line TOKEN_RETURN TOKEN_NUMBER TOKEN_SEMICOLON 
    | line { $$ = $1; }
    ;

line: expr TOKEN_SEMICOLON { parser_result = $1; }
    | expr TOKEN_SEMICOLON line 
    ;

expr: assign { $$ = $1; }
    | term compare term
    | term TOKEN_ADD term { $$ = expr_create(TOKEN_ADD, $1, $3); }
    | term TOKEN_SUBTRACT term { $$ = expr_create(TOKEN_SUBTRACT, $1, $3); }
    | term { $$ = $1; }
    | TOKEN_QUOTE expr TOKEN_QUOTE 
    ;
assign: TOKEN_IDENT TOKEN_COLON type
      | TOKEN_IDENT TOKEN_COLON type TOKEN_ASS line
      | TOKEN_IDENT TOKEN_ASS expr
      ;
term: term TOKEN_STAR factor
    | term TOKEN_DIVIDE factor
    | factor { $$ = $1; }
    ;
compare: EQ { $$ = atoi(yytext); }
       | GT { $$ = atoi(yytext); }
       | GE { $$ = atoi(yytext); }
       | LE { $$ = atoi(yytext); }
       | NE { $$ = atoi(yytext); }
       ;

factor: TOKEN_SUBTRACT factor
      | TOKEN_IDENT { $$ = atoi(yytext); }
      | TOKEN_TRUE { $$ = atoi(yytext); }
      | TOKEN_FALSE { $$ = atoi(yytext); }
      | TOKEN_NUMBER { $$ = atoi(yytext); }
      ;


type: TOKEN_VOID { $$ = type_create(TYPE_VOID, 0, 0, 0); }
    | TOKEN_INTEGER { $$ = type_create(TYPE_INTEGER, 0, 0, 0); }
    | TOKEN_STRING { $$ = type_create(TYPE_STRING, 0, 0, 0); }
    | TOKEN_BOOLEAN { $$ = type_create(TYPE_BOOLEAN, 0, 0, 0); }
    | TOKEN_CHAR { $$ = type_create(TYPE_CHAR, 0, 0, 0); }
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
    //struct decl *parser_result;
     printf("parse error: %s on line %d\n",str, yylineno);
     //return 0;
}