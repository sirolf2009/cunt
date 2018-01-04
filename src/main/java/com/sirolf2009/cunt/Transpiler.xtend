package com.sirolf2009.cunt

import com.sirolf2009.cunt.macro.ArithmeticMacro
import com.sirolf2009.cunt.macro.NamespaceMacro
import com.sirolf2009.cunt.sexp.Parser
import java.util.List
import com.sirolf2009.cunt.macro.FunctionMacro
import com.sirolf2009.cunt.macro.FunctionCallMacro

class Transpiler {
	
	def static void main(String[] args) {
		val source = '''
		namespace com.sirolf2009.cunt.Example
		
		var Number additive
		
		function -main(args) {
			println("Hello World")
		}
		'''
		val transpiled = source.transpile()
		println(transpiled)
	}
	
	def static transpile(String source) {
		source.transpile(#[new NamespaceMacro(), new FunctionMacro(), new FunctionCallMacro(), new ArithmeticMacro()])
	}
	
	def static transpile(String source, List<Macro> macros) {
		val workingCode = Parser.parse("("+source+")")
		macros.forEach[macro|
			macro.apply(workingCode)
		]
		return workingCode
	}
	
}