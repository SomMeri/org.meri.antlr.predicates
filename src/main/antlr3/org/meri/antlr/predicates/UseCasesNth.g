grammar UseCasesNth;

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
import java.util.HashSet;
import java.util.Set;
}

@parser::members {
  private static Set<String> NTH_PSEUDOCLASSES = new HashSet<String>();
  static {
    NTH_PSEUDOCLASSES.add("nth-child");
    NTH_PSEUDOCLASSES.add("nth-last-child");
    NTH_PSEUDOCLASSES.add("nth-of-type");
    NTH_PSEUDOCLASSES.add("nth-last-of-type");
  }

  public boolean isInsideNth() {
    return isNthPseudoClass(input.LT(-1));
  }
  
  private boolean isNthPseudoClass(Token a) {
    if (a == null)
      return false;
    String text = a.getText();
    if (text == null)
      return false;
    return NTH_PSEUDOCLASSES.contains(text.toLowerCase());
  }
  
}

@lexer::header {
  package org.meri.antlr.predicates;
}

LPAREN: '(';
RPAREN: ')';
COLON: ':';
COMMA: ',';
IDENT : ('a'..'z' | 'A'..'Z')+;

//pseudoparameters and nth with dummy syntax
pseudoparameters: IDENT (COMMA IDENT)*; 
nth: IDENT; //real nth syntax ommited for simplicity sake

// pseudoclass
pseudo
    : COLON COLON? IDENT ((
        { isInsideNth()}?=> LPAREN nth RPAREN
        | LPAREN pseudoparameters RPAREN
        )?)
    ;

//different solution - note that we need to use rewrite rules in this case
pseudoDifferentSolution
    : COLON COLON? name=IDENT ((
        { isNthPseudoClass($name)}?=> LPAREN nthParameters=nth RPAREN
        | LPAREN parameters=pseudoparameters RPAREN
        )?)
    -> $name $nthParameters? $parameters?  
    ;
