package com.sirolf2009.cunt.macro

import org.junit.Assert
import org.junit.Test
import com.sirolf2009.cunt.sexp.Parser

class NamespaceMacroTest {

	val macro = new NamespaceMacro()

	@Test
	def void test() {
		'''
			(namespace com.sirolf2009.cunt.macro)
		''' -> '''
			((ns com.sirolf2009.cunt.macro))
		'''
	}
	
	@Test
	def void example() {
		'''
		(
			namespace com.sirolf2009.cunt.Example
			
			function -main(args) {
				println(5+5, 6+6)
				println()
				println("Hello World")
				println(5+5)
			}
		)
		''' -> '''
		((ns com.sirolf2009.cunt.Example) function -main (args) { println (5+5, 6+6) println () println ("Hello World") println (5+5) })
		'''
	}
	
	def ->(String source, String target) {
		Assert.assertEquals(target.trim(), macro.convert(Parser.parse(source)).toString())
	}

}
