grammar SyntacticallyIncorrect;

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
sameWord: LETTER {1+2!=3}? LETTER;

// uncomment next line in order to get antlr error
//start: word | sameWord;

// uncomment next rule in order to get antlr error
//alternativesStart: LETTER (
//  LETTER {1+2==3}?
//  | LETTER {1+2!=3}?
//);

gatedWord: LETTER {1+2==3}?=> LETTER;
gatedSameWord: LETTER {1+2!=3}?=> LETTER;

// uncomment next line in order to get antlr error
//gatedStart: gatedWord | gatedSameWord;

// uncomment next rule in order to get antlr error
//gatedAlternativesStart: LETTER (
//  LETTER {1+2==3}?=> LETTER
//  | LETTER {1+2!=3}?=> LETTER
//);
