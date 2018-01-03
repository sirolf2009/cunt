package com.sirolf2009.cunt.sexp

import java.util.Vector
import org.eclipse.xtend.lib.annotations.Delegate
import java.util.Collection

class SexpVector extends Vector<Sexp> implements SexpCollection {
	
	@Delegate val Vector<Sexp> children

	new() {
		children = new Vector()
	}
	
	new(Collection<Sexp> children) {
		this(new Vector(children))
	}

	new(Vector<Sexp> children) {
		this.children = children
	}
	
	override synchronized toString() {
		return '''[«children.map[toString].join(" ")»]'''
	}
	
	override isAtomic() {
		return false
	}
	
	override synchronized equals(Object obj) {
		return obj instanceof SexpVector && children.equals((obj as SexpVector).children)
	}

}