grammar UseCasesWhen;

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
  //checks whether its parameter is "when"
  public boolean isWhen(Token token) {
    return token.getText().toLowerCase().equals("when");
  }
}

@lexer::header {
  package org.meri.antlr.predicates;
}

LBRACE : '{' ;
RBRACE : '}' ;
LPAREN: '(';
RPAREN: ')';
COMMA: ',';
IDENT : ('a'..'z' | 'A'..'Z')+;

name: IDENT;
arguments:  IDENT (COMMA IDENT)*;
body: LBRACE /* whatever can be inside the body goes here */ RBRACE;
guard: IDENT /* place conditions syntax here */; 

//mixin and its optional guards
mixin: name LPAREN arguments? RPAREN guards? body;
//guards are entered only if the next token is the word "when"
guards: {isWhen(input.LT(1))}?=> IDENT guard (COMMA guard)*;
