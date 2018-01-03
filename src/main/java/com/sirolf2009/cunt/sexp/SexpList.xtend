package com.sirolf2009.cunt.sexp

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Delegate

class SexpList implements SexpCollection, List<Sexp> {
	
	@Delegate val List<Sexp> children

	new() {
		children = new ArrayList()
	}

	new(List<Sexp> children) {
		this.children = children
	}
	
	override toString() {
		return '''(«children.map[toString].join(" ")»)'''
	}
	
	override isAtomic() {
		return false
	}
	
	override equals(Object obj) {
		return obj instanceof SexpList && children.equals((obj as SexpList).children)
	}
	
}