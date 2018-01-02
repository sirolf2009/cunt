package com.sirolf2009.cunt.sexp

import java.io.InputStream
import java.io.InputStreamReader
import java.io.Reader
import java.io.StringReader

class Parser {

	def static Sexp parse(InputStream in) {
		return parse(new InputStreamReader(in))
	}

	def static Sexp parse(Reader in) {
		val tokenList = Tokenizer.tokenize(in)
		if(tokenList.size() == 0) {
			throw new RuntimeException("Empty expression cannot be parsed.")
		} else if(tokenList.size() == 1) {
			return new SexpAtom(tokenList.get(0).data)
		} else if(tokenList.size() > 1) {
			return new SexpList(tokenList)
		} else {
			throw new RuntimeException("Impossible token count: "+tokenList.size())
		}
	}

	def static Sexp parse(String str) {
		val reader = new StringReader(str)
		val sexp = parse(reader)
		reader.close()
		return sexp
	}
}
