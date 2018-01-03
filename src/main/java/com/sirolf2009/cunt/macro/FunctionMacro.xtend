package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.Macro
import com.sirolf2009.cunt.SexpWalker
import com.sirolf2009.cunt.sexp.Sexp
import com.sirolf2009.cunt.sexp.SexpAtom
import com.sirolf2009.cunt.sexp.SexpList
import java.util.ArrayList
import java.util.EmptyStackException
import java.util.List
import org.eclipse.xtend.lib.annotations.Data

class FunctionMacro implements Macro {

	override apply(Sexp it) {
		val walker = new SexpWalker(it)
		val functions = new ArrayList()
		try {
			while(true) {
				val identifier = walker.next()
				if(identifier.atomic && (identifier as SexpAtom).data.equals("function")) {
					val mark = walker.pushMark()
					try {
						val name = walker.right()
						val args = walker.right()
						val open = walker.right()
						if(name.atomic && !args.atomic && open.atomic && (open as SexpAtom).data.equals("{")) {
							val body = new ArrayList()
							var searchingForEnd = true
							while(searchingForEnd) {
								val sexp = walker.next()
								if(sexp.atomic && (sexp as SexpAtom).data.equals("}")) {
									searchingForEnd = false
									functions.add(new FunctionDeclaration(mark.stack.peek() as SexpList, identifier as SexpAtom, name as SexpAtom, args as SexpList, open as SexpAtom, body, sexp as SexpAtom))
								} else {
									body.add(sexp)
								}
							}
						}
					} catch(EmptyStackException e) {
					}
					walker.popMark()
				}
			}
		} catch(EmptyStackException e) {
		}
		functions.forEach[
			val function = new SexpList(new ArrayList(#[
				new SexpAtom("defn"),
				name,
				args
			]))
			function.addAll(body)
			val identifierIndex = parent.indexOf(identifier)
			parent.removeAll(identifier, name, args, open, close)
			parent.removeAll(body)
			parent.add(identifierIndex, function)
		]
	}
	
	@Data static class FunctionDeclaration {
		val SexpList parent
		val SexpAtom identifier
		val SexpAtom name
		val SexpList args
		val SexpAtom open
		val List<Sexp> body
		val SexpAtom close
	}

}
