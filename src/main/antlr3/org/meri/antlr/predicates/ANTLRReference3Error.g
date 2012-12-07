grammar ANTLRReference3Error;

options {
    // antlr will generate java lexer and parser
    language = Java;
    // generated parser should create abstract syntax tree
    output = AST;
    // parser will extend special super class
    superClass = SuperParser;
}

@parser::header {
  package org.meri.antlr.predicates;
}

@lexer::header {
  package org.meri.antlr.predicates;
}

LETTER : 'a'..'z' | 'A'..'Z';

data 
@init {int n=1;}
    : ( {n<=4}?=> LETTER {n++;} )+
    ;

//this works OK
start:  data;

//this does not work
//differentData: '@' data;
//startDoesNotWork:  data | differentData;

