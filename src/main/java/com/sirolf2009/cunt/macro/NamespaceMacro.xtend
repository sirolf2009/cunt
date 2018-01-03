package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.sexp.Sexp
import com.sirolf2009.cunt.sexp.SexpAtom
import com.sirolf2009.cunt.sexp.SexpList
import java.util.ArrayList
import com.sirolf2009.cunt.Macro
import com.sirolf2009.cunt.sexp.SexpCollection

class NamespaceMacro implements Macro {
	
	override apply(Sexp sexp) {
		if(sexp instanceof SexpCollection) {
			val it = sexp as SexpCollection
			findAtom("namespace").ifPresent [ keyword |
				val index = indexOf(keyword)
				if(get(index + 1).atomic) {
					val namespace = get(index + 1)
					remove(keyword)
					remove(namespace)
					add(index, new SexpList(new ArrayList(#[new SexpAtom("ns"), namespace])))
				}
			]
		}
	}
	
}