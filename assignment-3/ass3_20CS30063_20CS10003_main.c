#include<stdio.h>

int main(){
    int token;
    while(token=yylex()){
        switch(token){
            case KEYWORD: 
                printf("<KEYWORD, %s>\n", yytext); 
                break;
            case IDENTIFIER: 
                printf("<IDENTIFIER, %s>\n", yytext); 
                break;
            case INTEGER_CONSTANT: 
                printf("<INTEGER_CONSTANT, %s>\n", yytext); 
                break;
            case FLOATING_CONSTANT: 
                printf("<FLOAT_CONSTANT, %s>\n", yytext); 
                break;
            case CHARACTER_CONSTANT: 
                printf("<CHARACTER_CONSTANT, %s>\n", yytext); 
                break;
            case STRING_LITERAL: 
                printf("<STRING_LITERAL, %s>\n", yytext); 
                break;
            case PUNCTUATOR: 
                printf("<PUNCTUATOR, %s>\n", yytext); 
                break;
            case MULTI_LINE_COMMENT: 
            case SINGLE_LINE_COMMENT: 
                break;
            default:
                printf("<ERROR_INVALID_TOKEN, %s>\n", yytext);
                break;
        }
    }
    return 0;
}