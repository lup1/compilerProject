%{
#include "token.h"
int mylineno = 0;
%}
%option yylineno

DIGIT  [0-9]
LETTER [a-zA-Z]
%%

(\t|\n|\r|\ )+ { }
"/*" {
    int c;
   
        while ((c = input()) != 0) {
           if(c == '\n') {
              continue;
           }
           else if(c == '*') {
               if ((c = input()) == '/') {
                 break;
               }
               else
                  unput(c);
           
                }
        }   
        
        
    }
"//" { 
      int c;
        while ((c = input()) != 0) {
            if(c == '\n') {
                
                break;
            }
        }
        
    }
\(  { return TOKEN_LPARENT; }
\)  { return TOKEN_RPARENT; }
\{  { return TOKEN_LBRACKET; }
\}  { return TOKEN_RBRACKET; }
\;  { return TOKEN_SEMICOLON; }
\:  { return TOKEN_COLON; } 

\*  { return TOKEN_STAR; }
\+  { return TOKEN_ADD; }
\-  { return TOKEN_SUBTRACT; }
"/" { return TOKEN_DIVIDE; }
\++ { return TOKEN_INCREMENT; }
\-- { return TOKEN_DECREMENT; }
\\&& { return TOKEN_LOGAND; }
"||" { return TOKEN_LOGOR; }    

\"  { return TOKEN_QUOTE; }

while      { return TOKEN_WHILE; }
if         { return TOKEN_IF; }
else         { return TOKEN_ELSE; }
function   { return TOKEN_FUNCTION; }
void       { return TOKEN_VOID; }
integer    { return TOKEN_INTEGER; }
boolean    { return TOKEN_BOOLEAN; }
char       { return TOKEN_CHAR; }
string     { return TOKEN_STRING; }
true       { return TOKEN_TRUE; }
false      { return TOKEN_FALSE; }
print         { return TOKEN_PRINT; }
return         { return TOKEN_RETURN; }
{LETTER}+  { return TOKEN_IDENT; }
{DIGIT}+   { return TOKEN_NUMBER; }
\=   { return TOKEN_ASS; }
\>   { return GT; }
\<   { return LT; }
\>=   { return GE; }
\<=   { return LE; }
\==     { return EQ; }
\!= { return NE; }  // Not equal to
.          { return TOKEN_ERROR; }
%%
int yywrap() { return 1; }
// got rid of space as TOKEN_SKIP
// "//" { return TOKEN_SKIP;  } 
// \\t {return TOKEN_SKIP; }
// \\n {return TOKEN_SKIP; }