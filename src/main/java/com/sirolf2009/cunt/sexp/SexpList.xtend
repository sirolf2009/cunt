package com.sirolf2009.cunt.sexp

import java.util.List
import org.eclipse.xtend.lib.annotations.Delegate
import java.util.ArrayList
import java.util.Stack

class SexpList implements Sexp {
	
	@Delegate val List<Sexp> children = new ArrayList()

	new() {
	}

	new(List<Token> tokens) {
		val stack = new Stack<SexpList>()
		var currentList = new SexpList()
		var firstTime = true
		for (Token tok : tokens) {
			if (tok.isLeftParenthesis()) {
				if (!firstTime) {
					stack.push(currentList)
					currentList = new SexpList()
				}
				firstTime = false
			} else if (tok.isRightParenthesis()) {
				if (stack.empty()) {
					children.addAll(currentList)
				} else {
					val lastList = currentList
					currentList = stack.pop()
					currentList.add(lastList)
				}
			} else if (!tok.isComment()) {
				currentList.add(new SexpAtom(tok.data))
			}
		}
	}
	
	override toString() {
		return '''(«FOR child : children»
			«child.toString()»
		«ENDFOR»)'''
	}
	
	override isAtomic() {
		return false
	}
	
}