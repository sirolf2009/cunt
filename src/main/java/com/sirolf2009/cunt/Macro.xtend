package com.sirolf2009.cunt

import com.sirolf2009.cunt.sexp.Sexp
import com.sirolf2009.cunt.sexp.SexpAtom
import com.sirolf2009.cunt.sexp.SexpCollection
import java.util.Optional
import java.util.function.Predicate

interface Macro {
	
	def void apply(Sexp it)
	
	def convert(Sexp it) {
		apply(it)
		return it
	}
	
	def filter(Sexp it, Predicate<Sexp> predicate) {
		new SexpWalker(it).toList().filter(predicate)
	}
	
	def Optional<SexpAtom> findAtom(Sexp it, String data) {
		if(it instanceof SexpCollection) {
			return findAtom(it as SexpCollection, data)
		} else {
			return Optional.empty()
		}
	}
	
	def Optional<SexpAtom> findAtom(SexpCollection it, String data) {
		return Optional.ofNullable(findFirst[
			atomic && (it as SexpAtom).data.equals(data)
		] as SexpAtom)
	}
	
	def SexpAtom atom(String data) {
		return new SexpAtom(data)
	}
	
}