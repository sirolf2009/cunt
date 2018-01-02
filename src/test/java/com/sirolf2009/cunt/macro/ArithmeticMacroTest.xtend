package com.sirolf2009.cunt.macro

import org.junit.Test
import com.sirolf2009.cunt.sexp.Parser

class ArithmeticMacroTest {
	
	val macro = new ArithmeticMacro()
	
	@Test
	def void test() {
		println(macro.apply(Parser.parse("(5 + 5)")))
	}
	
}