package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.sexp.Parser
import org.junit.Assert
import org.junit.Test

class FunctionCallMacroTest {
	

	val macro = new FunctionCallMacro()

	@Test
	def void test() {
		'''
			(println("Hello World"))
		''' -> '''
			((println "Hello World"))
		'''
		//TODO do I want comma's inbetween params?
		'''
			(println("Hello World" "How Are You" "Doing?"))
		''' -> '''
			((println "Hello World" "How Are You" "Doing?"))
		'''
		'''
			(println("Hello World" getValueFrom(database)))
		''' -> '''
			((println "Hello World" (getValueFrom database)))
		'''
		'''
			(+(5 5))
		''' -> '''
			((+ 5 5))
		'''
	}
	
	@Test
	def void stacked() {
		'''
			(getUserInfo
				(getUsername (session)
				getUserStore (session))
			)
		''' -> '''
			((getUserInfo 
				(getUsername session) 
				(getUserStore session)
			))
		'''
		'''
			(getUserInfo
				(getUsername (session)
				getUserStore (session))
			)
		''' -> '''
			((getUserInfo 
				(getUsername session) 
				(getUserStore session)
			))
		'''
	}
	
	@Test
	def void example() {
		'''
			(
				namespace com.sirolf2009.cunt.Example
			
				function -main(args) {
					println(5+5 6+6)
					println()
					println("Hello World")
					println(5+5)
				}
			)
		''' -> '''
			(
				namespace com.sirolf2009.cunt.Example
			
				function (-main args) {
					(println 5+5 6+6)
					(println )
					(println "Hello World")
					(println 5+5)
				}
			)
		'''
	}
	
	@Test
	def void macro() {
		'''
			(
				val identifier = walker.next()
				if(identifier.atomic && walker.canWalkRight()) {
					val mark = walker.pushMark()
					val params = walker.right()
					if(!params.atomic) {
						functions.add(new FunctionCall(mark.stack.peek(), identifier as SexpAtom, params as SexpList))
					}
					walker.popMark()
				}
			)
		''' -> '''
			(
				val identifier = (walker.next) 
				(if identifier.atomic && (walker.canWalkRight)) { 
					val mark = (walker.pushMark) 
					val params = (walker.right) 
					(if !params.atomic) { 
						(functions.add new (FunctionCall (mark.stack.peek) , identifier as SexpAtom, params as SexpList))
					} 
					(walker.popMark)
				}
			)
		'''
	}
	
	def ->(String source, String target) {
		try {
			Assert.assertEquals(Parser.parse(target), macro.convert(Parser.parse(source)))
		} catch(AssertionError e) {
			println("Expected")
			println(Parser.parse(target))
			println()
			println("Actual")
			println(macro.convert(Parser.parse(source)))
			throw e
		}
	}
}