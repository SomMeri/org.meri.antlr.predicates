grammar Nuances;

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
  private boolean somePredicate() {
    return false;
  }
}

@lexer::header {
  package org.meri.antlr.predicates;
}

LETTER : 'a'..'z' | 'A'..'Z';
NUMBER : '0'..'9';

loop: ( {somePredicate()}?=> LETTER )*;
loopDisambiguating: ( {somePredicate()}? LETTER )*;

advancedDisambiguating: LETTER (
  {1+2==3}? LETTER LETTER
  | {1+2!=3}? LETTER*
);

compareGated: LETTER (
  {1+2==3}?=> LETTER LETTER
  | {1+2!=3}?=> LETTER*
);

stillDisambiguating: ({2+2==4}?) LETTER;
testStillDisambiguating: stillDisambiguating | LETTER;

ignored: ({3+3==6}?)=>LETTER;

combinationDisambiguatingNotHoisted: LETTER (
  {1+4==5}?=> LETTER
  | {1+4!=5}? NUMBER
);

combinationDisambiguatingHoisted: LETTER (
  {1+5==6}?=> LETTER*
  | {1+5!=6}? LETTER+
);

uncoveredDisambiguatingNotHoisted: LETTER (
  {2+4==6}? LETTER
  | NUMBER
);

uncoveredDisambiguatingHoisted: LETTER (
  {2+5==7}? LETTER*
  | LETTER+
);

uncoveredGated: LETTER (
  {3+4==7}?=> LETTER
  | NUMBER
);

  