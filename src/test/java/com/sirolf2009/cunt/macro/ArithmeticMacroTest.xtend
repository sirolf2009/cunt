package com.sirolf2009.cunt.macro

import org.junit.Test
import com.sirolf2009.cunt.sexp.Parser
import org.junit.Assert

class ArithmeticMacroTest {
	
	val macro = new ArithmeticMacro()
	
	@Test
	def void test() {
		Assert.assertEquals(Parser.parse("(+ 5 5)"), macro.convert(Parser.parse("(5 + 5)")))
	}
	
}