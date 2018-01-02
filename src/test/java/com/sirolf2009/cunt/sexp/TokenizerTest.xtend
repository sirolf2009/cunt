package com.sirolf2009.cunt.sexp

import org.junit.Test
import org.junit.Assert

class TokenizerTest {
	
	@Test
	def void test() {
		Assert.assertArrayEquals(#['(', '5', '+', '5', ')'].map[t].toList(), Tokenizer.tokenize("(5 + 5)"))
		Assert.assertArrayEquals(#['(', '55', '+', '55', ')'].map[t].toList(), Tokenizer.tokenize("(55 + 55)"))
		Assert.assertArrayEquals(#['(', '(', '5', '+', '5', ')', '+', '(', '5', '+', '5', ')', ')'].map[t].toList(), Tokenizer.tokenize("((5 + 5) + (5 + 5))"))
		Assert.assertArrayEquals(#['(', '(', '55', '+', '55', ')', '+', '(', '55', '+', '55', ')', ')'].map[t].toList(), Tokenizer.tokenize("((55 + 55) + (55 + 55))"))
	}
	
	@Test(expected=IllegalStateException)
	def void testUnbalancedRight() {
		Tokenizer.tokenize("(5 + 5))")
	}
	
	@Test(expected=IllegalStateException)
	def void testUnbalancedLeft() {
		Tokenizer.tokenize("((5 + 5)")
	}
	
	def t(String token) {
		return new Token() => [
			it.append(token)
		]
	}
	
}