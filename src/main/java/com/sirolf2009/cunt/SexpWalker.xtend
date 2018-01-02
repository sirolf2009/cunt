package com.sirolf2009.cunt

import com.sirolf2009.cunt.sexp.Sexp
import java.util.ArrayList
import java.util.EmptyStackException
import java.util.Stack

class SexpWalker {

	val Sexp root
	val Stack<Sexp> stack
	var Sexp focus

	new(Sexp sexp) {
		this.root = sexp
		stack = new Stack()
		focus = root
	}
	
	def toList() {
		val items = new ArrayList()
		try {
			items.add(focus)
			while(true) {
				items.add(next())
			}
		} catch(EmptyStackException e) {}
		return items
	}

	def Sexp next() {
		if(focus.isAtomic()) {
			up()
		} else {
			stack.push(focus)
			focus = focus.get(0)
			return focus
		}
	}

	def Sexp up() {
		val parent = stack.peek()
		val index = (0 ..< parent.size()).findFirst[parent.get(it).equals(focus)]
		if(index == parent.size()-1) {
			focus = stack.pop()
			up()
		} else {
			focus = parent.get(index+1)
			return focus
		}
	}

	def getFocus() {
		return focus
	}
}
