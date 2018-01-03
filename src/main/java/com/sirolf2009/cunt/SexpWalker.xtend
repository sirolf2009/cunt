package com.sirolf2009.cunt

import com.sirolf2009.cunt.sexp.Sexp
import java.util.ArrayList
import java.util.Stack
import org.eclipse.xtend.lib.annotations.Data
import java.util.EmptyStackException
import com.sirolf2009.cunt.sexp.SexpList
import com.sirolf2009.cunt.sexp.SexpCollection

class SexpWalker {

	val Sexp root
	val Stack<SexpCollection> stack
	val Stack<Mark> markStack
	var Sexp focus

	new(Sexp root) {
		this.root = root
		stack = new Stack()
		markStack = new Stack()
		focus = root
	}

	def get() {
		return focus
	}

	def toList() {
		val all = new ArrayList<Sexp>()
		all.add(focus)
		try {
			while(true) {
				all.add(next())
			}
		} catch(EmptyStackException e) {
			return all
		}
	}

	def next() {
		if(canWalkDown()) {
			down()
		} else if(canWalkRight()) {
			right()
		} else {
			while(!canWalkRight()) {
				up()
			}
			right()
		}
	}

	def up() {
		focus = stack.pop()
	}

	def right() {
		focus = parent.get(indexInParent() + 1)
	}

	def left() {
		focus = parent.get(indexInParent() - 1)
	}

	def down() {
		stack.add(focus as SexpCollection)
		focus = (focus  as SexpCollection).get(0)
	}

	def canWalkUp() {
		return !stack.isEmpty()
	}

	def canWalkRight() {
		if(!canWalkUp) {
			return false
		}
		return indexInParent != parent.size() - 1
	}

	def canWalkLeft() {
		if(!canWalkUp) {
			return false
		}
		return indexInParent() != 0
	}

	def canWalkDown() {
		return !focus.atomic && !(focus as SexpList).empty
	}

	def private indexInParent() {
		return (0 ..< parent.size).findFirst[parent.get(it) === focus]
	}

	def private parent() {
		return stack.peek()
	}

	def pushMark() {
		val newStack = new Stack<SexpCollection>()
		newStack.addAll(stack)
		markStack.push(new Mark(newStack, focus))
	}

	def popMark() {
		val mark = markStack.pop()
		focus = mark.focus
		stack.clear()
		stack.addAll(mark.stack)
	}

	@Data static class Mark {
		val Stack<SexpCollection> stack
		val Sexp focus
		
		override toString() {
			return '''Mark(«stack», «focus»)'''
		}
	}

}
