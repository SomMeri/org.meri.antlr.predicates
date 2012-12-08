grammar Backtracking;

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

@parser::members {
}

@lexer::header {
  package org.meri.antlr.predicates;
}

LETTER : 'a'..'z' | 'A'..'Z';
word: LETTER {1+2==3}? LETTER;
number:  LETTER {2+3!=5}? LETTER;

backtrack: (number)=> number | word;
