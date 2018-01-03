package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.sexp.Sexp
import com.sirolf2009.cunt.sexp.SexpAtom
import com.sirolf2009.cunt.Macro
import com.sirolf2009.cunt.sexp.SexpList

class ArithmeticMacro implements Macro {
	
	val ops = #[
		"+", "-", "*", "/", "%"
	].map[new SexpAtom(it)].toList()
	
	override apply(Sexp it) {
		filter[it instanceof SexpList].map[it as SexpList].filter[size == 3 && ops.contains(get(1))].forEach[
			val op = remove(1)
			add(0, op)
		]
	}
	
}