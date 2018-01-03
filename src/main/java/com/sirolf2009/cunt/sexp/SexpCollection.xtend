package com.sirolf2009.cunt.sexp

import java.util.Collection

interface SexpCollection extends Sexp, Collection<Sexp> {
	
    def boolean addAll(int index, Collection<? extends Sexp> c)
    def Sexp get(int index)
    def Sexp remove(int index)
    def Sexp set(int index, Sexp element)
    def void add(int index, Sexp element)
    def int indexOf(Object obj)
	
}