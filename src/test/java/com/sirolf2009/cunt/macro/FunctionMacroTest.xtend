package com.sirolf2009.cunt.macro

import org.junit.Test
import org.junit.Assert
import com.sirolf2009.cunt.sexp.Parser

class FunctionMacroTest {

	val macro = new FunctionMacro()

	@Test
	def void test() {
		//TODO support SexpVector
		'''
			(function -main(args) {
			})
		''' -> '''
			(defn -main
				[args]
				)
		'''
		
		'''
			function -main(args) {
				(+ 5 5)
				(+ 6 6)
			}
		''' -> '''
			(defn -main
				[args]
				(+ 5 5)
				(+ 6 6)
			)
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
			
			(defn -main
				[args]
				println(5+5, 6+6)
				println()
				println("Hello World")
				println(5+5)
			)
		'''
	}
	
	def ->(String source, String target) {
		Assert.assertEquals(target.trim(), macro.convert(Parser.parse(source)))
	}

}
