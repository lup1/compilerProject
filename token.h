/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_TOKEN_H_INCLUDED
# define YY_YY_TOKEN_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TOKEN_EOF = 258,
    TOKEN_SKIP = 259,
    TOKEN_LPARENT = 260,
    TOKEN_RPARENT = 261,
    TOKEN_LBRACKET = 262,
    TOKEN_RBRACKET = 263,
    TOKEN_SEMICOLON = 264,
    TOKEN_COLON = 265,
    TOKEN_STAR = 266,
    TOKEN_ADD = 267,
    TOKEN_SUBTRACT = 268,
    TOKEN_DIVIDE = 269,
    TOKEN_INCREMENT = 270,
    TOKEN_DECREMENT = 271,
    TOKEN_LOGAND = 272,
    TOKEN_LOGOR = 273,
    TOKEN_QUOTE = 274,
    TOKEN_COMMENT = 275,
    TOKEN_OCOMMENT = 276,
    TOKEN_CCOMMENT = 277,
    TOKEN_WHILE = 278,
    TOKEN_IF = 279,
    TOKEN_ELSE = 280,
    TOKEN_FUNCTION = 281,
    TOKEN_VOID = 282,
    TOKEN_INTEGER = 283,
    TOKEN_BOOLEAN = 284,
    TOKEN_CHAR = 285,
    TOKEN_STRING = 286,
    TOKEN_TRUE = 287,
    TOKEN_FALSE = 288,
    TOKEN_PRINT = 289,
    TOKEN_RETURN = 290,
    TOKEN_IDENT = 291,
    TOKEN_NUMBER = 292,
    TOKEN_ASS = 293,
    GT = 294,
    LT = 295,
    GE = 296,
    LE = 297,
    EQ = 298,
    NE = 299,
    TOKEN_ERROR = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 20 "parser1.bison"

    struct decl *decl;
    struct stmt *stmt;
    struct symbol *symbol;
    struct expr *expr;
    struct type *type;
    char* name;


#line 113 "token.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_TOKEN_H_INCLUDED  */
