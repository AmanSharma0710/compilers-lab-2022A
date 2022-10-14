%{
    #include <stdio.h>
    extern int yylex();
    extern int lineCount;
    void yyerror(char *);
    void yyprint(char *);
%}

%union {
    int intVal;
    float floatVal;
    char *charVal;
    char *stringVal;
    char *identifierVal;
}

%token AUTO
%token BREAK
%token CASE
%token CHAR
%token CONST
%token CONTINUE
%token DEFAULT
%token DO
%token DOUBLE
%token ELSE
%token ENUM
%token EXTERN
%token FLOAT
%token FOR
%token GOTO
%token IF
%token INLINE
%token INT
%token LONG
%token REGISTER
%token RESTRICT
%token RETURN
%token SHORT
%token SIGNED
%token SIZEOF
%token STATIC
%token STRUCT
%token SWITCH
%token TYPEDEF
%token UNION
%token UNSIGNED
%token VOID
%token VOLATILE
%token WHILE
%token _BOOL
%token _COMPLEX
%token _IMAGINARY

%token LEFT_SQUARE_BRACKET
%token INCREMENT_OPERATOR
%token FORWARD_SLASH
%token QUESTION_MARK
%token ASSIGNMENT_OPERATOR
%token COMMA
%token RIGHT_SQUARE_BRACKET
%token LEFT_PARENTHESES
%token LEFT_CURLY_BRACKET
%token RIGHT_CURLY_BRACKET
%token DOT
%token ARROW
%token ASTERISK
%token PLUS
%token MINUS
%token TILDE
%token EXCLAMATION
%token MODULO
%token LEFT_SHIFT
%token RIGHT_SHIFT
%token LESS_THAN
%token GREATER_THAN
%token LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL
%token COLON
%token SEMI_COLON
%token ELLIPSIS
%token ASTERISK_ASSIGNMENT_OPERATOR
%token FORWARD_SLASH_ASSIGNMENT_OPERATOR
%token MODULO_ASSIGNMENT_OPERATOR
%token PLUS_ASSIGNMENT_OPERATOR
%token MINUS_ASSIGNMENT_OPERATOR
%token LEFT_SHIFT_ASSIGNMENT_OPERATOR
%token HASH
%token DECREMENT
%token RIGHT_PARENTHESES
%token BITWISE_AND
%token EQUALS
%token BITWISE_XOR
%token BITWISE_OR
%token LOGICAL_AND
%token LOGICAL_OR
%token RIGHT_SHIFT_ASSIGNMENT_OPERATOR
%token NOT_EQUALS
%token BITWISE_AND_ASSIGNMENT_OPERATOR
%token BITWISE_OR_ASSIGNMENT_OPERATOR
%token BITWISE_XOR_ASSIGNMENT_OPERATOR

%token<stringVal> IDENTIFIER
%token<intVal> INTEGER_CONSTANT
%token<floatVal> FLOATING_CONSTANT
%token<charVal> CHARACTER_CONSTANT
%token<stringVal> STRING_LITERAL

%token INVALID_TOKEN

%nonassoc RIGHT_PARENTHESES
%nonassoc ELSE

%start translation_unit

%%

/* Expressions */

primary_expression: 
                    IDENTIFIER 
                        { yyprint("primary_expression --> IDENTIFIER"); printf("IDENTIFIER = %s\n", $1); }
                    | INTEGER_CONSTANT 
                        { yyprint("primary_expression --> INTEGER_CONSTANT"); printf("INTEGER_CONSTANT = %d\n", $1); }
                    | FLOATING_CONSTANT 
                        { yyprint("primary_expression --> FLOATING_CONSTANT"); printf("FLOATING_CONSTANT = %f\n", $1); }
                    | CHARACTER_CONSTANT 
                        { yyprint("primary_expression --> CHARACTER_CONSTANT"); printf("CHARACTER_CONSTANT = %s\n", $1); }
                    | STRING_LITERAL 
                        { yyprint("primary_expression --> STRING_LITERAL"); printf("STRING_LITERAL = %s\n", $1); }
                    | LEFT_PARENTHESES expression RIGHT_PARENTHESES
                        { yyprint("primary_expression --> ( expression )"); }
                    ;

postfix_expression:
                    primary_expression
                        { yyprint("postfix_expression --> primary_expression"); }
                    | postfix_expression LEFT_SQUARE_BRACKET expression RIGHT_SQUARE_BRACKET
                        { yyprint("postfix_expression --> postfix_expression [ expression ]"); }
                    | postfix_expression LEFT_PARENTHESES argument_expression_list_opt RIGHT_PARENTHESES
                        { yyprint("postfix_expression --> postfix_expression ( argument_expression_list_opt )"); }
                    | postfix_expression DOT IDENTIFIER
                        { yyprint("postfix_expression --> postfix_expression . IDENTIFIER"); printf("IDENTIFIER = %s\n", $3); }
                    | postfix_expression ARROW IDENTIFIER
                        { yyprint("postfix_expression --> postfix_expression -> IDENTIFIER"); printf("IDENTIFIER = %s\n", $3); }
                    | postfix_expression INCREMENT_OPERATOR
                        { yyprint("postfix_expression --> postfix_expression ++"); }
                    | postfix_expression DECREMENT
                        { yyprint("postfix_expression --> postfix_expression --"); }
                    | LEFT_PARENTHESES type_name RIGHT_PARENTHESES LEFT_CURLY_BRACKET initialiser_list RIGHT_CURLY_BRACKET
                        { yyprint("postfix_expression --> ( type_name ) { initialiser_list }"); }
                    | LEFT_PARENTHESES type_name RIGHT_PARENTHESES LEFT_CURLY_BRACKET initialiser_list COMMA RIGHT_CURLY_BRACKET
                        { yyprint("postfix_expression --> ( type_name ) { initialiser_list , }"); }
                    ;

argument_expression_list_opt:
                                argument_expression_list
                                    { yyprint("argument_expression_list_opt --> argument_expression_list"); }
                                |
                                    { yyprint("argument_expression_list_opt --> epsilon"); }
                                ;

argument_expression_list:
                            assignment_expression
                                { yyprint("argument_expression_list --> assignment_expression"); }
                            | argument_expression_list COMMA assignment_expression
                                { yyprint("argument_expression_list --> argument_expression_list , assignment_expression"); }
                            ;

unary_expression:
                    postfix_expression
                        { yyprint("unary_expression --> postfix_expression"); }
                    | INCREMENT_OPERATOR unary_expression
                        { yyprint("unary_expression --> ++ unary_expression"); }
                    | DECREMENT unary_expression
                        { yyprint("unary_expression --> -- unary_expression"); }
                    | unary_operator cast_expression
                        { yyprint("unary_expression --> unary_operator cast_expression"); }
                    | SIZEOF unary_expression
                        { yyprint("unary_expression --> sizeof unary_expression"); }
                    | SIZEOF LEFT_PARENTHESES type_name RIGHT_PARENTHESES
                        { yyprint("unary_expression --> sizeof ( type_name )"); }
                    ;

unary_operator:
                BITWISE_AND
                    { yyprint("unary_operator --> &"); }
                | ASTERISK
                    { yyprint("unary_operator --> *"); }
                | PLUS
                    { yyprint("unary_operator --> +"); }
                | MINUS
                    { yyprint("unary_operator --> -"); }
                | TILDE
                    { yyprint("unary_operator --> ~"); }
                | EXCLAMATION
                    { yyprint("unary_operator --> !"); }
                ;

cast_expression:
                unary_expression
                    { yyprint("cast_expression --> unary_expression"); }
                | LEFT_PARENTHESES type_name RIGHT_PARENTHESES cast_expression
                    { yyprint("cast_expression --> ( type_name ) cast_expression"); }
                ;

multiplicative_expression:
                            cast_expression
                                { yyprint("multiplicative_expression --> cast_expression"); }
                            | multiplicative_expression ASTERISK cast_expression
                                { yyprint("multiplicative_expression --> multiplicative_expression * cast_expression"); }
                            | multiplicative_expression FORWARD_SLASH cast_expression
                                { yyprint("multiplicative_expression --> multiplicative_expression / cast_expression"); }
                            | multiplicative_expression MODULO cast_expression
                                { yyprint("multiplicative_expression --> multiplicative_expression % cast_expression"); }
                            ;

additive_expression:
                    multiplicative_expression
                        { yyprint("additive_expression --> multiplicative_expression"); }
                    | additive_expression PLUS multiplicative_expression
                        { yyprint("additive_expression --> additive_expression + multiplicative_expression"); }
                    | additive_expression MINUS multiplicative_expression
                        { yyprint("additive_expression --> additive_expression - multiplicative_expression"); }
                    ;

shift_expression:
                    additive_expression
                        { yyprint("shift_expression --> additive_expression"); }
                    | shift_expression LEFT_SHIFT additive_expression
                        { yyprint("shift_expression --> shift_expression << additive_expression"); }
                    | shift_expression RIGHT_SHIFT additive_expression
                        { yyprint("shift_expression --> shift_expression >> additive_expression"); }
                    ;

relational_expression:
                        shift_expression
                            { yyprint("relational_expression --> shift_expression"); }
                        | relational_expression LESS_THAN shift_expression
                            { yyprint("relational_expression --> relational_expression < shift_expression"); }
                        | relational_expression GREATER_THAN shift_expression
                            { yyprint("relational_expression --> relational_expression > shift_expression"); }
                        | relational_expression LESS_THAN_EQUAL shift_expression
                            { yyprint("relational_expression --> relational_expression <= shift_expression"); }
                        | relational_expression GREATER_THAN_EQUAL shift_expression
                            { yyprint("relational_expression --> relational_expression >= shift_expression"); }
                        ;

equality_expression:
                    relational_expression
                        { yyprint("equality_expression --> relational_expression"); }
                    | equality_expression EQUALS relational_expression
                        { yyprint("equality_expression --> equality_expression == relational_expression"); }
                    | equality_expression NOT_EQUALS relational_expression
                        { yyprint("equality_expression --> equality_expression != relational_expression"); }
                    ;

AND_expression:
                equality_expression
                    { yyprint("AND_expression --> equality_expression"); }
                | AND_expression BITWISE_AND equality_expression
                    { yyprint("AND_expression --> AND_expression & equality_expression"); }
                ;

exclusive_OR_expression:
                        AND_expression
                            { yyprint("exclusive_OR_expression --> AND_expression"); }
                        | exclusive_OR_expression BITWISE_XOR AND_expression
                            { yyprint("exclusive_OR_expression --> exclusive_OR_expression ^ AND_expression"); }
                        ;

inclusive_OR_expression:
                        exclusive_OR_expression
                            { yyprint("inclusive_OR_expression --> exclusive_OR_expression"); }
                        | inclusive_OR_expression BITWISE_OR exclusive_OR_expression
                            { yyprint("inclusive_OR_expression --> inclusive_OR_expression | exclusive_OR_expression"); }
                        ;

logical_AND_expression:
                        inclusive_OR_expression
                            { yyprint("logical_AND_expression --> inclusive_OR_expression"); }
                        | logical_AND_expression LOGICAL_AND inclusive_OR_expression
                            { yyprint("logical_AND_expression --> logical_AND_expression && inclusive_OR_expression"); }
                        ;

logical_OR_expression:
                        logical_AND_expression
                            { yyprint("logical_OR_expression --> logical_AND_expression"); }
                        | logical_OR_expression LOGICAL_OR logical_AND_expression
                            { yyprint("logical_OR_expression --> logical_OR_expression || logical_AND_expression"); }
                        ;

conditional_expression:
                        logical_OR_expression
                            { yyprint("conditional_expression --> logical_OR_expression"); }
                        | logical_OR_expression QUESTION_MARK expression COLON conditional_expression
                            { yyprint("conditional_expression --> logical_OR_expression ? expression : conditional_expression"); }
                        ;

assignment_expression:
                        conditional_expression
                            { yyprint("assignment_expression --> conditional_expression"); }
                        | unary_expression assignment_operator assignment_expression
                            { yyprint("assignment_expression --> unary_expression assignment_operator assignment_expression"); }
                        ;

assignment_operator:
                    ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> ="); }
                    | ASTERISK_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> *="); }
                    | FORWARD_SLASH_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> /="); }
                    | MODULO_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> %="); }
                    | PLUS_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> += "); }
                    | MINUS_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> -= "); }
                    | LEFT_SHIFT_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> <<="); }
                    | RIGHT_SHIFT_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> >>="); }
                    | BITWISE_AND_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> &="); }
                    | BITWISE_XOR_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> ^="); }
                    | BITWISE_OR_ASSIGNMENT_OPERATOR
                        { yyprint("assignment_operator --> |="); }
                    ;

expression:
            assignment_expression
                { yyprint("expression --> assignment_expression"); }
            | expression COMMA assignment_expression
                { yyprint("expression --> expression , assignment_expression"); }
            ;

constant_expression:
                    conditional_expression
                        { yyprint("constant_expression --> conditional_expression"); }
                    ;

/* Declarations */

declaration:
            declaration_specifiers init_declarator_list_opt SEMI_COLON
                { yyprint("declaration --> declaration_specifiers init_declarator_list_opt ;"); }
            ;

init_declarator_list_opt:
                            init_declarator_list
                                { yyprint("init_declarator_list_opt --> init_declarator_list"); }
                            |
                                { yyprint("init_declarator_list_opt --> epsilon"); }
                            ;

declaration_specifiers:
                        storage_class_specifier declaration_specifiers_opt
                            { yyprint("declaration_specifiers --> storage_class_specifier declaration_specifiers_opt"); }
                        | type_specifier declaration_specifiers_opt
                            { yyprint("declaration_specifiers --> type_specifier declaration_specifiers_opt"); }
                        | type_qualifier declaration_specifiers_opt
                            { yyprint("declaration_specifiers --> type_qualifier declaration_specifiers_opt"); }
                        | function_specifier declaration_specifiers_opt
                            { yyprint("declaration_specifiers --> function_specifier declaration_specifiers_opt"); }
                        ;

declaration_specifiers_opt:
                            declaration_specifiers
                                { yyprint("declaration_specifiers_opt --> declaration_specifiers"); }
                            |
                                { yyprint("declaration_specifiers_opt --> epsilon "); }
                            ;

init_declarator_list:
                        init_declarator
                            { yyprint("init_declarator_list --> init_declarator"); }
                        | init_declarator_list COMMA init_declarator
                            { yyprint("init_declarator_list --> init_declarator_list , init_declarator"); }
                        ;

init_declarator:
                declarator
                    { yyprint("init_declarator --> declarator"); }
                | declarator ASSIGNMENT_OPERATOR initialiser
                    { yyprint("init_declarator --> declarator = initialiser"); }
                ;

storage_class_specifier:
                        EXTERN
                            { yyprint("storage_class_specifier --> extern"); }
                        | STATIC
                            { yyprint("storage_class_specifier --> static"); }
                        | AUTO
                            { yyprint("storage_class_specifier --> auto"); }
                        | REGISTER
                            { yyprint("storage_class_specifier --> register"); }
                        ;

type_specifier:
                VOID
                    { yyprint("type_specifier --> void"); }
                | CHAR
                    { yyprint("type_specifier --> char"); }
                | SHORT
                    { yyprint("type_specifier --> short"); }
                | INT
                    { yyprint("type_specifier --> int"); }
                | LONG
                    { yyprint("type_specifier --> long"); }
                | FLOAT
                    { yyprint("type_specifier --> float"); }
                | DOUBLE
                    { yyprint("type_specifier --> double"); }
                | SIGNED
                    { yyprint("type_specifier --> signed"); }
                | UNSIGNED
                    { yyprint("type_specifier --> unsigned"); }
                | _BOOL
                    { yyprint("type_specifier --> _Bool"); }
                | _COMPLEX
                    { yyprint("type_specifier --> _Complex"); }
                | _IMAGINARY
                    { yyprint("type_specifier --> _Imaginary"); }
                | enum_specifier 
                    { yyprint("type_specifier --> enum_specifier"); }
                ;

specifier_qualifier_list:
                            type_specifier specifier_qualifier_list_opt
                                { yyprint("specifier_qualifier_list --> type_specifier specifier_qualifier_list_opt"); }
                            | type_qualifier specifier_qualifier_list_opt
                                { yyprint("specifier_qualifier_list --> type_qualifier specifier_qualifier_list_opt"); }
                            ;

specifier_qualifier_list_opt:
                                specifier_qualifier_list
                                    { yyprint("specifier_qualifier_list_opt --> specifier_qualifier_list"); }
                                | 
                                    { yyprint("specifier_qualifier_list_opt --> epsilon"); }
                                ;

enum_specifier:
                ENUM identifier_opt LEFT_CURLY_BRACKET enumerator_list RIGHT_CURLY_BRACKET 
                    { yyprint("enum_specifier --> enum identifier_opt { enumerator_list }"); }
                | ENUM identifier_opt LEFT_CURLY_BRACKET enumerator_list COMMA RIGHT_CURLY_BRACKET
                    { yyprint("enum_specifier --> enum identifier_opt { enumerator_list , }"); }
                | ENUM IDENTIFIER
                    { yyprint("enum_specifier --> enum IDENTIFIER"); printf("IDENTIFIER = %s\n", $2); }
                ;

identifier_opt:
                IDENTIFIER 
                    { yyprint("identifier_opt --> IDENTIFIER"); printf("IDENTIFIER = %s\n", $1); }
                | 
                    { yyprint("identifier_opt --> epsilon"); }
                ;

enumerator_list:
                enumerator 
                    { yyprint("enumerator_list --> enumerator"); }
                | enumerator_list COMMA enumerator
                    { yyprint("enumerator_list --> enumerator_list , enumerator"); }
                ;

enumerator:
            IDENTIFIER 
                { yyprint("enumerator --> ENUMERATION_CONSTANT"); printf("ENUMERATION_CONSTANT = %s\n", $1); }
            | IDENTIFIER ASSIGNMENT_OPERATOR constant_expression
                { yyprint("enumerator --> ENUMERATION_CONSTANT = constant_expression"); printf("ENUMERATION_CONSTANT = %s\n", $1); }
            ;

type_qualifier:
                CONST
                    { yyprint("type_qualifier --> const"); }
                | RESTRICT
                    { yyprint("type_qualifier --> restrict"); }
                | VOLATILE
                    { yyprint("type_qualifier --> volatile"); }
                ;

function_specifier:
                    INLINE
                        { yyprint("function_specifier --> inline"); }
                    ;

declarator:
            pointer_opt direct_declarator
                { yyprint("declarator --> pointer_opt direct_declarator"); }
            ;

pointer_opt:
            pointer
                { yyprint("pointer_opt --> pointer"); }
            |
                { yyprint("pointer_opt --> epsilon"); }
            ;

direct_declarator:
                    IDENTIFIER 
                        { yyprint("direct_declarator --> IDENTIFIER"); printf("IDENTIFIER = %s\n", $1); }
                    | LEFT_PARENTHESES declarator RIGHT_PARENTHESES
                        { yyprint("direct_declarator --> ( declarator )"); }
                    | direct_declarator LEFT_SQUARE_BRACKET type_qualifier_list_opt assignment_expression_opt RIGHT_SQUARE_BRACKET
                        { yyprint("direct_declarator --> direct_declarator [ type_qualifier_list_opt assignment_expression_opt ]"); }
                    | direct_declarator LEFT_SQUARE_BRACKET STATIC type_qualifier_list_opt assignment_expression RIGHT_SQUARE_BRACKET
                        { yyprint("direct_declarator --> direct_declarator [ static type_qualifier_list_opt assignment_expression ]"); }
                    | direct_declarator LEFT_SQUARE_BRACKET type_qualifier_list STATIC assignment_expression RIGHT_SQUARE_BRACKET
                        { yyprint("direct_declarator --> direct_declarator [ type_qualifier_list static assignment_expression ]"); }
                    | direct_declarator LEFT_SQUARE_BRACKET type_qualifier_list_opt ASTERISK RIGHT_SQUARE_BRACKET
                        { yyprint("direct_declarator --> direct_declarator [ type_qualifier_list_opt * ]"); }
                    | direct_declarator LEFT_PARENTHESES parameter_type_list RIGHT_PARENTHESES
                        { yyprint("direct_declarator --> direct_declarator ( parameter_type_list )"); }
                    | direct_declarator LEFT_PARENTHESES identifier_list_opt RIGHT_PARENTHESES
                        { yyprint("direct_declarator --> direct_declarator ( identifier_list_opt )"); }
                    ;

type_qualifier_list_opt:
                        type_qualifier_list
                            { yyprint("type_qualifier_list_opt --> type_qualifier_list"); }
                        |
                            { yyprint("type_qualifier_list_opt --> epsilon"); }
                        ;

assignment_expression_opt:
                            assignment_expression
                                { yyprint("assignment_expression_opt --> assignment_expression"); }
                            |
                                { yyprint("assignment_expression_opt --> epsilon"); }
                            ;

identifier_list_opt:
                    identifier_list
                        { yyprint("identifier_list_opt --> identifier_list"); }
                    |
                        { yyprint("identifier_list_opt --> epsilon"); }
                    ;

pointer:
        ASTERISK type_qualifier_list_opt
            { yyprint("pointer --> * type_qualifier_list_opt"); }
        | ASTERISK type_qualifier_list_opt pointer
            { yyprint("pointer --> * type_qualifier_list_opt pointer"); }
        ;

type_qualifier_list:
                    type_qualifier
                        { yyprint("type_qualifier_list --> type_qualifier"); }
                    | type_qualifier_list type_qualifier
                        { yyprint("type_qualifier_list --> type_qualifier_list type_qualifier"); }
                    ;

parameter_type_list:
                    parameter_list
                        { yyprint("parameter_type_list --> parameter_list"); }
                    | parameter_list COMMA ELLIPSIS
                        { yyprint("parameter_type_list --> parameter_list , ..."); }
                    ;

parameter_list:
                parameter_declaration
                    { yyprint("parameter_list --> parameter_declaration"); }
                | parameter_list COMMA parameter_declaration
                    { yyprint("parameter_list --> parameter_list , parameter_declaration"); }
                ;

parameter_declaration:
                        declaration_specifiers declarator
                            { yyprint("parameter_declaration --> declaration_specifiers declarator"); }
                        | declaration_specifiers
                            { yyprint("parameter_declaration --> declaration_specifiers"); }
                        ;

identifier_list:
                IDENTIFIER 
                    { yyprint("identifier_list --> IDENTIFIER"); printf("IDENTIFIER = %s\n", $1); }
                | identifier_list COMMA IDENTIFIER
                    { yyprint("identifier_list --> identifier_list , IDENTIFIER"); printf("IDENTIFIER = %s\n", $3); }
                ;

type_name:
            specifier_qualifier_list
                { yyprint("type_name --> specifier_qualifier_list"); }
            ;

initialiser:
            assignment_expression
                { yyprint("initialiser --> assignment_expression"); }
            | LEFT_CURLY_BRACKET initialiser_list RIGHT_CURLY_BRACKET
                { yyprint("initialiser --> { initialiser_list }"); }  
            | LEFT_CURLY_BRACKET initialiser_list COMMA RIGHT_CURLY_BRACKET
                { yyprint("initialiser --> { initialiser_list , }"); }
            ;

initialiser_list:
                    designation_opt initialiser
                        { yyprint("initialiser_list --> designation_opt initialiser"); }
                    | initialiser_list COMMA designation_opt initialiser
                        { yyprint("initialiser_list --> initialiser_list , designation_opt initialiser"); }
                    ;

designation_opt:
                designation
                    { yyprint("designation_opt --> designation"); }
                |
                    { yyprint("designation_opt --> epsilon"); }
                ;

designation:
            designator_list ASSIGNMENT_OPERATOR
                { yyprint("designation --> designator_list ="); }
            ;

designator_list:
                designator
                    { yyprint("designator_list --> designator"); }
                | designator_list designator
                    { yyprint("designator_list --> designator_list designator"); }
                ;

designator:
            LEFT_SQUARE_BRACKET constant_expression RIGHT_SQUARE_BRACKET
                { yyprint("designator --> [ constant_expression ]"); }
            | DOT IDENTIFIER
                { yyprint("designator --> . IDENTIFIER"); printf("IDENTIFIER = %s\n", $2); }   
            ;

/* Statements */

statement:
            labeled_statement
                { yyprint("statement --> labeled_statement"); }
            | compound_statement
                { yyprint("statement --> compound_statement"); }
            | expression_statement
                { yyprint("statement --> expression_statement"); }
            | selection_statement
                { yyprint("statement --> selection_statement"); }
            | iteration_statement
                { yyprint("statement --> iteration_statement"); }
            | jump_statement
                { yyprint("statement --> jump_statement"); }
            ;

labeled_statement:
                    IDENTIFIER COLON statement
                        { yyprint("labeled_statement --> IDENTIFIER : statement"); printf("IDENTIFIER = %s\n", $1); }
                    | CASE constant_expression COLON statement
                        { yyprint("labeled_statement --> case constant_expression : statement"); }    
                    | DEFAULT COLON statement
                        { yyprint("labeled_statement --> default : statement"); }
                    ;

compound_statement:
                    LEFT_CURLY_BRACKET block_item_list_opt RIGHT_CURLY_BRACKET
                        { yyprint("compound_statement --> { block_item_list_opt }"); }
                    ;

block_item_list_opt:
                    block_item_list
                        { yyprint("block_item_list_opt --> block_item_list"); }
                    |
                        { yyprint("block_item_list_opt --> epsilon"); }
                    ;

block_item_list:
                block_item
                    { yyprint("block_item_list --> block_item"); }
                | block_item_list block_item
                    { yyprint("block_item_list --> block_item_list block_item"); }
                ;

block_item:
            declaration
                { yyprint("block_item --> declaration"); }
            | statement
                { yyprint("block_item --> statement"); }
            ;

expression_statement:
                        expression_opt SEMI_COLON
                            { yyprint("expression_statement --> expression_opt ;"); }
                        ;

expression_opt:
                expression
                    { yyprint("expression_opt --> expression"); }
                |
                    { yyprint("expression_opt --> epsilon"); }
                ;

selection_statement:
                    IF LEFT_PARENTHESES expression RIGHT_PARENTHESES statement
                        { yyprint("selection_statement --> if ( expression ) statement"); }
                    | IF LEFT_PARENTHESES expression RIGHT_PARENTHESES statement ELSE statement
                        { yyprint("selection_statement --> if ( expression ) statement else statement"); }
                    | SWITCH LEFT_PARENTHESES expression RIGHT_PARENTHESES statement
                        { yyprint("selection_statement --> switch ( expression ) statement"); }
                    ;

iteration_statement:
                    WHILE LEFT_PARENTHESES expression RIGHT_PARENTHESES statement
                        { yyprint("iteration_statement --> while ( expression ) statement"); }
                    | DO statement WHILE LEFT_PARENTHESES expression RIGHT_PARENTHESES SEMI_COLON
                        { yyprint("iteration_statement --> do statement while ( expression ) ;"); }
                    | FOR LEFT_PARENTHESES expression_opt SEMI_COLON expression_opt SEMI_COLON expression_opt RIGHT_PARENTHESES statement
                        { yyprint("iteration_statement --> for ( expression_opt ; expression_opt ; expression_opt ) statement"); }
                    | FOR LEFT_PARENTHESES declaration expression_opt SEMI_COLON expression_opt RIGHT_PARENTHESES statement
                        { yyprint("iteration_statement --> for ( declaration expression_opt ; expression_opt ) statement"); }
                    ;

jump_statement:
                GOTO IDENTIFIER SEMI_COLON
                    { yyprint("jump_statement --> goto IDENTIFIER ;"); printf("IDENTIFIER = %s\n", $2); }    
                | CONTINUE SEMI_COLON
                    { yyprint("jump_statement --> continue ;"); }
                | BREAK SEMI_COLON
                    { yyprint("jump_statement --> break ;"); }
                | RETURN expression_opt SEMI_COLON
                    { yyprint("jump_statement --> return expression_opt ;"); }
                ;

/* External definitions */

translation_unit:
                    external_declaration
                        { yyprint("translation_unit --> external_declaration"); }
                    | translation_unit external_declaration
                        { yyprint("translation_unit --> translation_unit external_declaration"); }
                    ;

external_declaration:
                        function_definition
                            { yyprint("external_declaration --> function_definition"); }
                        | declaration
                            { yyprint("external_declaration --> declaration"); }
                        ;

function_definition:
                    declaration_specifiers declarator declaration_list_opt compound_statement
                        { yyprint("function_definition --> declaration_specifiers declarator declaration_list_opt compound_statement"); }
                    ;

declaration_list_opt:
                        declaration_list
                            { yyprint("declaration_list_opt --> declaration_list"); }
                        |
                            { yyprint("declaration_list_opt --> epsilon"); }
                        ;

declaration_list:
                    declaration
                        { yyprint("declaration_list --> declaration"); }
                    | declaration_list declaration
                        { yyprint("declaration_list --> declaration_list declaration"); }
                    ;

%%

void yyerror(char* s) {
    printf("error in line %d : %s\n", lineCount, s);
}

void yyprint(char* s) {
    printf("production in line %d : %s\n", lineCount, s);
}
