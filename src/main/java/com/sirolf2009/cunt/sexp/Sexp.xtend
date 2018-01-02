package com.sirolf2009.cunt.sexp

import java.util.List

interface Sexp extends List<Sexp> {
	
	def boolean isAtomic()
	
}