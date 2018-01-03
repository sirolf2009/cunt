package com.sirolf2009.cunt.sexp

import java.io.Reader
import java.io.StringReader
import java.util.Stack
import java.util.List
import com.sirolf2009.cunt.sexp.Parser.ParseContext

class Parser {

	def static Sexp parse(String str) {
		val reader = new StringReader(str)
		val sexp = parse(reader)
		reader.close()
		return sexp
	}

	def static Sexp parse(Reader in) {
		return parse(new ParseContext(Tokenizer.tokenize(in)))
	}
	
	def static Sexp parse(ParseContext it) {
		parse(next())
	}
	
	def static Sexp parse(ParseContext it, Token token) {
		if(token.isLeftParenthesis) {
			parseList
		} else if(token.leftBracket) {
			parseVector
		} else {
			parseAtom(token)
		}
	}
	
	def static Sexp parseList(ParseContext it) {
		val list = new SexpList()
		while(true) {
			val token = next()
			if(token.rightParenthesis) {
				return list
			} else {
				list.add(parse(token))
			}
		}
	}
	
	def static Sexp parseVector(ParseContext it) {
		val vector = new SexpVector()
		while(true) {
			val token = next()
			if(token.rightBracket) {
				return vector
			} else {
				vector.add(parse(token))
			}
		}
	}
	
	def static Sexp parseAtom(ParseContext it, Token token) {
		return new SexpAtom(token.data)
	}
	
	static class ParseContext {
		val List<Token> tokens
		val Stack<SexpCollection> stack
		var int currentToken
		
		new(List<Token> tokens) {
			this.tokens = tokens
			stack = new Stack()
			currentToken = -1
		}
		
		def next() {
			currentToken++
			return tokens.get(currentToken)
		}
		
		def addToCollection(SexpAtom atom) {
			stack.peek().add(atom)
		}
	} 
}
