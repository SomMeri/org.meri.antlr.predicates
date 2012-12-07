grammar Environnement;

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
NUMERAL: '0'..'9';

//example: check previous token
word: LETTER (
    { input.LT(-1).getText().equals("a")}? LETTER+
  | { !input.LT(-1).getText().equals("a")}? LETTER*
  );

number: NUMERAL (
  {input.LT(1).getText().equals("9")}? NUMERAL NUMERAL
  | {input.LT(1).getText().equals("9")}? NUMERAL*
);

labeledWord: a=LETTER (
    { $a.getText().equals("a")}? LETTER+
  | { !$a.getText().equals("a")}? LETTER*
  );

labeledListWord: a+=LETTER+ (
    { $a.size() < 10 }?=> NUMERAL
  | { $a.size() >= 10}?=>
  );

//this would cause null pointer exception
nullPointerAtPredicate: LETTER { $a.getText().equals("a") }? a=LETTER;

localVariables
@init {int num=0;} //define local variable num
   : (LETTER { num++; })* //raise the num variable each time you encounter a letter  
   (
      { num < 10 }?=> NUMERAL
    | { num >= 10}?=> 
    );

localVariablesWarning
@init {int n=1;} // n becomes a local variable
  : ( {n<=4}?=> NUMERAL {n++;} )+ // enter loop only if n<=4
  ;

// uncomment to obtain syntax error in generated parser
//syntaxError: localVariablesWarning | LETTER;
