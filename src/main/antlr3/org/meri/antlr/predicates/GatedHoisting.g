grammar GatedHoisting;

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

LETTER: 'a'..'z' | 'A'..'Z';
NUMBER: '0'..'9';

//gated predicate in the beginning of a rule
word: {1+2==3}?=> LETTER LETTER;
differentWord: {1+2!=3}?=> LETTER NUMBER;

start: word | differentWord;

//gated predicate in the beginning of an alternative
alternatives: LETTER (
  {2+3==5}?=> LETTER
  | {2+3==5}?=> NUMBER
);
