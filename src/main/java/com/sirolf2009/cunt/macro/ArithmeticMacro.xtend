package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.sexp.Sexp
import com.sirolf2009.cunt.sexp.SexpAtom
import com.sirolf2009.cunt.Macro

class ArithmeticMacro implements Macro {
	
	val ops = #[
		"+", "-", "*", "/", "%"
	].map[new SexpAtom(it)].toList()
	
	override apply(Sexp it) {
		filter[
			!isAtomic() && size() == 3 && ops.contains(get(1))
		].forEach[
			val op = remove(1)
			add(0, op)
		]
	}
	
}