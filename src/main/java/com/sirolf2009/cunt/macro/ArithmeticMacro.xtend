package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.PostParseMacro
import com.sirolf2009.cunt.SexpWalker
import com.sirolf2009.cunt.sexp.SexpAtom
import com.sirolf2009.cunt.sexp.Sexp

class ArithmeticMacro implements PostParseMacro {
	
	val ops = #[
		"+", "-", "*", "/", "%"
	].map[new SexpAtom(it)].toList()
	
	override apply(Sexp it) {
		val walker = new SexpWalker(it)
		walker.toList().filter[
			println(it)
			!isAtomic() && size() == 3 && ops.contains(get(1))
		].forEach[
			println(it)
			val op = remove(1)
			println(it)
			add(op)
		]
		it
	}
	
}