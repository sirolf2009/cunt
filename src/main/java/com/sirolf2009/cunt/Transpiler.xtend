package com.sirolf2009.cunt

import com.sirolf2009.cunt.macro.FunctionCallMacro
import com.sirolf2009.cunt.macro.FunctionMacro
import com.sirolf2009.cunt.macro.NamespaceMacro
import java.util.List
import java.util.concurrent.atomic.AtomicReference
import com.sirolf2009.cunt.sexp.Parser

class Transpiler {
	
	def static void main(String[] args) {
		val source = '''
		namespace com.sirolf2009.cunt.Example
		
		function -main(args) {
			println("Hello World")
		}
		'''
		val transpiled = source.transpile(#[new NamespaceMacro(), new FunctionMacro(), new FunctionCallMacro()])
		println("("+transpiled+")")
		println(Parser.parse("("+transpiled+")"))
	}
	
	def static transpile(String source, List<PreParseMacro> preParseMacros) {
		val workingSource = new AtomicReference(source)
		preParseMacros.forEach[macro|
			workingSource.getAndUpdate[macro.apply(it)]
		]
		return workingSource.get()
	}
	
}