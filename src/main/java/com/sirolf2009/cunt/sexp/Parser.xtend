package com.sirolf2009.cunt.sexp

import java.io.Reader
import java.io.StringReader
import java.util.Stack
import java.util.List

class Parser {

	def static Sexp parse(String str) {
		val reader = new StringReader(str)
		val sexp = parse(reader)
		reader.close()
		return sexp
	}

	def static Sexp parse(Reader in) {
		val tokenList = Tokenizer.tokenize(in)
		if(tokenList.size() == 0) {
			throw new RuntimeException("Empty expression cannot be parsed.")
		} else if(tokenList.size() == 1) {
			return new SexpAtom(tokenList.get(0).data)
		} else if(tokenList.size() > 1) {
			return asList(tokenList)
		} else {
			throw new RuntimeException("Impossible token count: "+tokenList.size())
		}
	}
	
	def static SexpList asList(List<Token> tokens) {
		val stack = new Stack<SexpList>()
		var currentList = new SexpList()
		var firstTime = true
		for (Token tok : tokens) {
			if (tok.isLeftParenthesis()) {
				if (!firstTime) {
					stack.push(currentList)
					currentList = new SexpList()
				}
				firstTime = false
			} else if (tok.isRightParenthesis()) {
				if (stack.empty()) {
					if(tokens.last == tok) {
						return currentList
					} else {
						throw new IllegalArgumentException("Unbalanced parenthesis")
					}
				} else {
					val lastList = currentList
					currentList = stack.pop()
					currentList.add(lastList)
				}
			} else if (!tok.isComment()) {
				currentList.add(new SexpAtom(tok.data))
			}
		}
	}
}
