grammar UseCasesSelectors;

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
  public boolean onEmptyCombinator(TokenStream input) {
    return !directlyFollows(input.LT(-1), input.LT(1));
  }

  private boolean directlyFollows(Token first, Token second) {
    CommonToken firstT = (CommonToken) first;
    CommonToken secondT = (CommonToken) second;

    if (firstT.getStopIndex() + 1 != secondT.getStartIndex())
      return false;
      
    return true;
  }
}

@lexer::header {
  package org.meri.antlr.predicates;
}

COLON: ':';
STAR: '*';
NUMBER: ('0'..'9')+;
IDENT : ('a'..'z' | 'A'..'Z')+;

elementName: IDENT | STAR | NUMBER; //some options have been removed for simplicity sake
pseudoClass: COLON COLON? IDENT; //parameters have been removed for simplicity sake
elementSubsequent: pseudoClass; //some options have been removed for simplicity sake

simpleSelectorWrong: 
  (elementName elementSubsequent*)
  | elementSubsequent+
;
    
simpleSelector: 
  (elementName ( {!onEmptyCombinator(input)}?=>elementSubsequent)*)
  | (elementSubsequent ( {!onEmptyCombinator(input)}?=>elementSubsequent)*)
;