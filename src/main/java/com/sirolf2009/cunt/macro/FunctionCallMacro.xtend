package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.SexpWalker
import com.sirolf2009.cunt.sexp.Sexp
import java.util.ArrayList
import java.util.EmptyStackException
import com.sirolf2009.cunt.sexp.SexpAtom
import com.sirolf2009.cunt.sexp.SexpList
import com.sirolf2009.cunt.macro.FunctionCallMacro.FunctionCall
import com.sirolf2009.cunt.Macro
import org.eclipse.xtend.lib.annotations.Data

class FunctionCallMacro implements Macro {

	override apply(Sexp it) {
		val walker = new SexpWalker(it)
		val functions = new ArrayList()
		try {
			while(true) {
				val identifier = walker.next()
				if(identifier.atomic && walker.canWalkRight()) {
					val mark = walker.pushMark()
					val params = walker.right()
					if(!params.atomic) {
						functions.add(new FunctionCall(mark.stack.peek(), identifier as SexpAtom, params as SexpList))
					}
					walker.popMark()
				}
			}
		} catch(EmptyStackException e) {
		}
		functions.forEach[
			parent.remove(identifier)
			params.add(0, identifier)
		]
	}

	@Data static class FunctionCall {
		val Sexp parent
		val SexpAtom identifier
		val SexpList params
		
		override toString() {
			return '''FunctionCall(«parent», «identifier», «params»)'''
		}
	}

}
