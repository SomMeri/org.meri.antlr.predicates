package org.meri.antlr.predicates;

import org.antlr.runtime.Parser;
import org.antlr.runtime.RecognizerSharedState;
import org.antlr.runtime.TokenStream;

public class SuperParser extends Parser {

  public SuperParser(TokenStream input, RecognizerSharedState state) {
    super(input, state);
  }

  public SuperParser(TokenStream input) {
    super(input);
  }

}
