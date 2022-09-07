%{
    #define KEYWORD                 10
    #define IDENTIFIER              11
    #define INTEGER_CONSTANT        12
    #define FLOATING_CONSTANT       13
    #define ENUMERATION_CONSTANT    14
    #define CHARACTER_CONSTANT      15
    #define STRING_LITERAL          16
    #define PUNCTUATOR              17
    #define MULTI_LINE_COMMENT      18
    #define SINGLE_LINE_COMMENT     19
    #define ERROR                   20
%}


KEYWORD                 "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary"
IDENTIFIER              [a-zA-Z_][a-zA-Z0-9_]*
ESCAPE_SEQUENCE         "\\\'"|"\\\""|"\\?"|"\\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"
 
DIGIT                   [0-9]
DIGIT_SEQUENCE          {DIGIT}+
NON_ZERO_DIGIT          [1-9]

INTEGER_CONSTANT        {NON_ZERO_DIGIT}{DIGIT}*|"0"

EXPONENT_PART           [eE]([+-]?){DIGIT_SEQUENCE}
FRACTIONAL_CONSTANT     {DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE}|{DIGIT_SEQUENCE}\.

FLOATING_CONSTANT       {FRACTIONAL_CONSTANT}({EXPONENT_PART}?)|{DIGIT_SEQUENCE}{EXPONENT_PART}

ENUMERATION_CONSTANT    {IDENTIFIER}

C_CHAR                  [^\'\n\\]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE         {C_CHAR}+

CHARACTER_CONSTANT      \'{C_CHAR_SEQUENCE}\'

S_CHAR                  [^\"\n\\]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE         {S_CHAR}+

STRING_LITERAL          \"({S_CHAR_SEQUENCE}?)\"

WHITESPACE              [ \t\r\n\v\f]

PUNCTUATOR              "["|"++"|"/"|"?"|"="|","|"]"|"("|"{"|"}"|"."|"->"|"*"|"+"|"-"|"~"|"!"|"%"|"<<"|">>"|"<"|">"|"<="|">="|":"|";"|"..."|"*="|"/="|"%="|"+="|"-="|"<<="|"#"|"--"|")"|"&"|"=="|"^"|"|"|"&&"|">>="|"!="|"&="|"^="|"||"|"|"

CHARACTER_SEQUENCE 		[^*]|[*][^/]
MULTI_LINE_COMMENT 		[/][*]{CHARACTER_SEQUENCE}*[*][/]

SINGLE_LINE_COMMENT		[/][/][^\n]*


%%
{KEYWORD}                       { return KEYWORD; }
{IDENTIFIER}                    { return IDENTIFIER; }
{INTEGER_CONSTANT}              { return INTEGER_CONSTANT; }
{FLOATING_CONSTANT}             { return FLOATING_CONSTANT; }
{CHARACTER_CONSTANT}            { return CHARACTER_CONSTANT; }
{STRING_LITERAL}                { return STRING_LITERAL; }
{PUNCTUATOR}                    { return PUNCTUATOR; }
{MULTI_LINE_COMMENT}            { return MULTI_LINE_COMMENT; }
{SINGLE_LINE_COMMENT}           { return SINGLE_LINE_COMMENT; }
{WHITESPACE}                    { }
.                               { return ERROR; }
%%