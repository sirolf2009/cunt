package com.sirolf2009.cunt.sexp

import java.io.Reader
import java.util.ArrayList
import java.util.List
import java.util.Map

import static com.sirolf2009.cunt.sexp.Token.*
import java.io.StringReader

class Tokenizer {

	private enum State {
		COMMENT,
		QMARK,
		QMARK_BSLASH,
		SYMBOL,
		VBAR,
		VBAR_BSLASH
	}

	val Map<State, (Character)=>void> stateActions = #{
		State.COMMENT -> [readComment],
		State.QMARK -> [readQuotationMark],
		State.QMARK_BSLASH -> [readQuotationMarkBackslash],
		State.VBAR -> [readVerticalBar],
		State.VBAR_BSLASH -> [readVerticalBarBackslash],
		State.SYMBOL -> [readSymbol]
	}

	var Token currentToken = new Token()
	var int depth = 0
	var int lineNumber = 1
	var State state = State.SYMBOL
	var List<Token> tokenList = new ArrayList<Token>()
	
	def static List<Token> tokenize(String string) {
		val reader = new StringReader(string)
		val tokens = tokenize(reader)
		reader.close()
		return tokens
	}

	def static List<Token> tokenize(Reader in) {
		val tokenizer = new Tokenizer()
		var finished = false
		var int ch = in.read()
		while(!finished && ch != -1) {
			finished = tokenizer.readChar(ch as char)
			if(!finished) {
				ch = in.read()
			}
		}
		val remaining = new StringBuffer()
		var reading = true
		while(reading) {
			val character = in.read()
			if(character == -1) {
				reading = false
			} else {
				remaining.append(character as char)
			}
		}
		if(!remaining.toString.trim.empty) {
			throw new IllegalStateException("Unexpected tokens at line " + tokenizer.lineNumber + ". "+remaining)
		}
		tokenizer.close()
		return tokenizer.getParsedTokens()
	}

	def List<Token> getParsedTokens() {
		return tokenList
	}

	def void flush() {
		if(currentToken.length() > 0) {
			currentToken.setLocation(lineNumber)
			tokenList.add(currentToken)
			currentToken = new Token()
		}
	}

	def boolean readChar(char ch) {
		stateActions.get(state).apply(ch)
		return depth <= 0 && this.tokenList.size() > 0
	}

	def void readComment(char ch) {
		if(ch == newLineChar) {
			flush()
			lineNumber++
			state = State.SYMBOL
		} else {
			currentToken.append(ch)
		}
	}

	def void readQuotationMark(char ch) {
		currentToken.append(ch)
		if(ch == newLineChar) {
			lineNumber++
		} else if(ch == escapeChar) {
			state = State.QMARK_BSLASH
		} else if(ch == quotationMarkChar) {
			flush()
			state = State.SYMBOL
		}
	}

	def void readQuotationMarkBackslash(char ch) {
		currentToken.append(ch)
		if(ch == newLineChar) {
			lineNumber++
		}
		this.state = State.QMARK
	}

	def void readSymbol(char ch) {
		if(ch == newLineChar) {
			flush()
			lineNumber++
		} else if(ch == spaceChar || ch == tabChar || ch == returnChar) {
			flush()
		} else if(ch == commentChar) {
			flush()
			this.currentToken.append(ch)
			this.state = State.COMMENT
		} else if(ch == leftParenthesisChar || ch == leftBracketChar) {
			this.depth++
			flush()
			this.currentToken.append(ch)
			flush()
		} else if(ch == rightParenthesisChar || ch == rightBracketChar) {
			this.depth--
			flush()
			this.currentToken.append(ch)
			flush()
		} else if(ch == quotationMarkChar) {
			flush()
			this.currentToken.append(ch)
			this.state = State.QMARK
		} else if(ch == verticalBarChar) {
			flush()
			currentToken.append(ch)
			state = State.VBAR
		} else {
			currentToken.append(ch)
		}
	}

	def void readVerticalBar(char ch) {
		currentToken.append(ch)
		if(ch == newLineChar) {
			lineNumber++
		} else if(ch == escapeChar) {
			state = State.VBAR_BSLASH
		} else if(ch == verticalBarChar) {
			flush()
			state = State.SYMBOL
		}
	}

	def void readVerticalBarBackslash(char ch) {
		currentToken.append(ch)
		if(ch == newLineChar) {
			lineNumber++
		}
		state = State.VBAR
	}

	def void close() {
		flush()
		if(this.state.equals(State.QMARK) || this.state.equals(State.QMARK_BSLASH)) {
			throw new IllegalStateException("Missing quotation mark at line " + this.lineNumber);
		}
		if(this.depth != 0) {
			throw new IllegalStateException("Unbalanced parenthesis at line " + this.lineNumber + ".");
		}
	}
}
