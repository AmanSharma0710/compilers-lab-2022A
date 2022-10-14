#include <stdio.h>
extern int yyparse();

int main() {
    
    yyparse();
    return 0;

    /*
    argument_expression_list_opt:
    init_declarator_list_opt:
    declaration_list_opt:
    expression_opt
    declaration_specifiers_opt:
    etc
    These non terminals have been added to handle optional productions
    The production *_opt --> epsilon is added to achieve this

    Changes have been made from the original l file submitted for the last assignment
    the various punctuators and keywords have been returned separately
    in order to deal with them separately in the .y file for their respective productions
    #defines mapping lexemes to numbers in the .l file have been removed since they are no longer
    needed to in the main file.

    The test file is parsed line by line with each production used mentioned
    */
}
