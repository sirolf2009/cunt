package com.sirolf2009.cunt

import com.sirolf2009.cunt.macro.ArithmeticMacro
import com.sirolf2009.cunt.macro.NamespaceMacro
import com.sirolf2009.cunt.sexp.Parser
import java.util.List

class Transpiler {
	
	def static void main(String[] args) {
		val source = '''
		namespace com.sirolf2009.cunt.Example
		
		var Number additive
		
		function -main(args) {
			println("Hello World")
		}
		'''
		val transpiled = source.transpile(#[new NamespaceMacro(), new ArithmeticMacro()])
		println(transpiled)
	}
	
	def static transpile(String source, List<Macro> postParseMacros) {
		val workingCode = Parser.parse("("+source+")")
		postParseMacros.forEach[macro|
			macro.apply(workingCode)
		]
		return workingCode
	}
	
}