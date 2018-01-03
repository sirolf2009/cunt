package com.sirolf2009.cunt.sexp

import org.eclipse.xtend.lib.annotations.Data

@Data class SexpAtom implements Sexp {
	
	val String data
	
	override isAtomic() {
		return true
	}
	
	override toString() {
		return data
	}
	
}