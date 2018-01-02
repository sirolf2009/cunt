package com.sirolf2009.cunt.macro

import org.junit.Assert
import org.junit.Test

class FunctionCallMacroTest {
	

	val macro = new FunctionCallMacro()

	@Test
	def void test() {
		'''
			println("Hello World")
		''' -> '''
			(println "Hello World")
		'''
		'''
			println("Hello World", "How Are You" "Doing?")
		''' -> '''
			(println "Hello World" "How Are You" "Doing?")
		'''
		'''
			+(5, 5)
		''' -> '''
			(+ 5 5)
		'''
	}
	
	@Test
	def void example() {
		'''
			namespace com.sirolf2009.cunt.Example
			
			function -main(args) {
				println(5+5, 6+6)
				println()
				println("Hello World")
				println(5+5)
			}
		''' -> '''
			namespace com.sirolf2009.cunt.Example
			
			function (-main args) {
				(println 5+5 6+6)
				(println )
				(println "Hello World")
				(println 5+5)
			}
		'''
	}
	
	def ->(String source, String target) {
		Assert.assertEquals(target.trim(), macro.apply(source).trim())
	}
}