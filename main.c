#include "token.h"
#include <getopt.h>
#include <stdio.h>
#include <unistd.h>

extern FILE *yyin;
extern int yylex();
extern char *yytext;

extern int yyparse(); //Removed "void" from parameters
extern int yylineno;
extern char *sumting;   // Used for getopt function
//extern int *sumting;   // Used for getopt function


int main(int argc, char *argv[])
{
    
    // FIXME: handle command line switches, e.g. "-scan"
    //        hint: man getopt_long_only()

    // FIXME: specify filename on command line
    // FIXME: bminor source code requires filename suffix .bminor

    //sumting = "-scan";
    
    //printf("very beginning\n");
    //printf("Creating struct for getopt_long_only\n");

    /* parsing command line options */
    int c;  // For flag options
    int parse_check; // Int for parsing

    static int scan_flag=0; //= "-scan";
    static int parse_flag=0; //= "-parse";
    static int print_flag=0; //= "-print";  //= "-scan";
    static int resolve_flag; //= "-resolve"; //= "-scan";
    static int typecheck_flag; //= "-typecheck"; //= "-scan";
    static int codegen_flag; //= "-codegen"; //= "-scan";

    // Open file
    yyin = fopen(argv[argc-1],"r");
    
    if(!yyin) {
        printf("error: could not open file!\n");
        return 1;
    }
    
    //while (1) {
        
        static struct option long_options[] = {
            /* these options set a flag */
            {"scan", 0, &scan_flag, 1},  
            {"parse", 0, &parse_flag, 1},
            {"print", 0, &print_flag, 1},
            {"resolve", 0, &resolve_flag, 1},
            {"typecheck", 0, &typecheck_flag, 1},
            {"codegen", 0, &codegen_flag, 1},
            {0, 0, 0, 0}
        };


    // typedef struct option {
    //     char        *name;
    //     int         has_arg;
    //     int         *flag;
    //     int         val;
    // };

        int option_index = 0;

        c = getopt_long_only(argc, argv, "", long_options, &option_index);
        // printf("C is %d\n",c);

    //while (1) {
        //printf("C is %d\n",c);
    //    printf("scan_flag = %d\nparse_flag = %d\n", scan_flag, parse_flag);

        if (c==-1) {    // If the -____ part of the command is not anything from the options, break and return -1
            return 1;
        }
        // enum yytokentype t = yylex();
        // if(t==TOKEN_EOF) return 0;
        //printf("parse next \n");
        
        if (scan_flag) {
            /* If this option sets a flag, do nothing else now */
                //printf("scan case \n");
                    // if (long_options[option_index].flag != 0) {
                    //     printf("%d \n",long_options[option_index].flag);
                    //     break;
                    // }
                //break;

                while(1) {
                    //printf("scanning\n");
                enum yytokentype t = yylex();
                if(t==0) return 0;
                
                if(t==TOKEN_SKIP) printf("%s  %s\n","TOKEN_SKIP",yytext);
                if(t==TOKEN_LPARENT) printf("%s  %s\n","TOKEN_LPARENT",yytext);
                if(t==TOKEN_RPARENT) printf("%s  %s\n","TOKEN_RPARENT",yytext);
                if(t==TOKEN_LBRACKET) printf("%s  %s\n","TOKEN_LBRACKET",yytext);
                if(t==TOKEN_RBRACKET) printf("%s  %s\n","TOKEN_RBRACKET",yytext);
                if(t==TOKEN_SEMICOLON) printf("%s  %s\n","TOKEN_SEMICOLON",yytext);
                if(t==TOKEN_COLON) printf("%s  %s\n","TOKEN_COLON",yytext);
                
                if(t==TOKEN_STAR) printf("%s  %s\n","TOKEN_STAR",yytext);
                if(t==TOKEN_ADD) printf("%s  %s\n","TOKEN_ADD",yytext);
                if(t==TOKEN_DIVIDE) printf("%s  %s\n","TOKEN_DIVIDE",yytext);
                if(t==TOKEN_SUBTRACT) printf("%s  %s\n","TOKEN_SUBTRACT",yytext);
                if(t==TOKEN_INCREMENT) printf("%s  %s\n","TOKEN_INCREMENT",yytext);
                if(t==TOKEN_DECREMENT) printf("%s  %s\n","TOKEN_DECREMENT",yytext);
                if(t==TOKEN_LOGAND) printf("%s  %s\n","TOKEN_LOGAND",yytext);
                if(t==TOKEN_LOGOR) printf("%s  %s\n","TOKEN_LOGOR",yytext);
                //if(t==TOKEN_BACKSLASH) printf("%s  %s\n","TOKEN_BACKSLASH",yytext);
                if(t==TOKEN_QUOTE) printf("%s %s\n","TOKEN_QUOTE",yytext);
                //if(t==TOKEN_COMMENT) printf("%s  %s\n","TOKEN_COMMENT",yytext);
                //if(t==TOKEN_OCOMMENT) printf("%s  %s\n","TOKEN_OCOMMENT",yytext);
                //if(t==TOKEN_CCOMMENT) printf("%s  %s\n","TOKEN_CCOMMENT",yytext);
                if(t==TOKEN_WHILE) printf("%s  %s\n","TOKEN_WHILE",yytext);
                if(t==TOKEN_IF) printf("%s  %s\n","TOKEN_IF",yytext);
                if(t==TOKEN_ELSE) printf("%s  %s\n","TOKEN_ELSE",yytext);
                if(t==TOKEN_FUNCTION) printf("%s  %s\n","TOKEN_FUNCTION",yytext);
                if(t==TOKEN_VOID) printf("%s  %s\n","TOKEN_VOID",yytext);
                if(t==TOKEN_INTEGER) printf("%s  %s\n","TOKEN_INTEGER",yytext);
                if(t==TOKEN_BOOLEAN) printf("%s  %s\n","TOKEN_BOOLEAN",yytext);
                if(t==TOKEN_CHAR) printf("%s  %s\n","TOKEN_CHAR",yytext);
                if(t==TOKEN_STRING) printf("%s  %s\n","TOKEN_STRING",yytext);
                if(t==TOKEN_TRUE) printf("%s  %s\n","TOKEN_TRUE",yytext);
                if(t==TOKEN_FALSE) printf("%s  %s\n","TOKEN_FALSE",yytext);
                if(t==TOKEN_PRINT) printf("%s  %s\n","TOKEN_PRINT",yytext);
                if(t==TOKEN_RETURN) printf("%s  %s\n","TOKEN_RETURN",yytext);
                if(t==TOKEN_IDENT) printf("%s  %s\n","TOKEN_IDENT",yytext);
                if(t==TOKEN_NUMBER) printf("%s  %s\n","TOKEN_NUMBER",yytext);

                if(t==TOKEN_ASS) printf("%s  %s\n","TOKEN_ASS",yytext);
                if(t==GT) printf("%s  %s\n","GT",yytext);
                if(t==LT) printf("%s  %s\n","LT",yytext);
                if(t==GE) printf("%s  %s\n","GE",yytext);
                if(t==LE) printf("%s  %s\n","LE",yytext);
                if(t==EQ) printf("%s  %s\n","EQ",yytext);
                if(t==NE) printf("%s  %s\n","NE",yytext);


                if (t==TOKEN_ERROR) {
                    fprintf(stderr, "scan error: %s is not a valid token \n", yytext);
                    return 1;
                }

                if (t==TOKEN_EOF) {
                    return 0;
                }
            }
        
        }
        
        else if (parse_flag) {
            //printf("parse case \n");
            // yyin = fopen(argv[argc-1],"r");
        
            // if(!yyin) {
            //     printf("parse error: could not open file!\n");
            //     return 1;
            // }
            //while(t != TOKEN_EOF) {
                //printf("parsing");
               // if(t==TOKEN_EOF) return 0;
                parse_check = yyparse();
                //printf("parse_check = %d\n", parse_check);
                if (parse_check) {
                    printf("Parse error on line %d\n", yylineno);
                    //printf("Parsing successful\n");
                    //return 0;
                }
                else if (!parse_check) {
                    printf("Parsing successful\n");
                    //printf("Parse error on line %d\n", yylineno);
                    //continue;
                    //return 1;
                }
            //}
            //return 0;
            
        }

        else if (print_flag) {
                printf("print case \n");
                
        }
    
        else if (resolve_flag) {
                printf("resolve case \n");
        }

        else if (typecheck_flag) {
                printf("typecheck case \n");
        }

        else if (codegen_flag) {
                printf("code generation case \n");
        }
        else {
            /* getopt_long already printed an error message */
            printf("Error \n");
        }
            
        
    
    
            
    //    return 0;
    //} 
    return 0;
}


