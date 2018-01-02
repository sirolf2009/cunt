package com.sirolf2009.cunt

import com.sirolf2009.cunt.sexp.Sexp

interface PostParseMacro {
	
	def Sexp apply(Sexp it)
	
}