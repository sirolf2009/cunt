package com.sirolf2009.cunt.sexp

import java.util.Collection

class SexpAtom implements Sexp {
	
	val String data
	
	new(String data) {
		this.data = data
	}
	
	override isAtomic() {
		return true
	}
	
	override add(Sexp e) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override addAll(Collection<? extends Sexp> c) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override clear() {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override contains(Object o) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override containsAll(Collection<?> c) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override isEmpty() {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override iterator() {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override remove(Object o) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override removeAll(Collection<?> c) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override retainAll(Collection<?> c) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override size() {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override toArray() {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override <T> toArray(T[] a) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override add(int index, Sexp element) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override addAll(int index, Collection<? extends Sexp> c) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override get(int index) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override indexOf(Object o) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override lastIndexOf(Object o) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override listIterator() {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override listIterator(int index) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override remove(int index) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override set(int index, Sexp element) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
	override subList(int fromIndex, int toIndex) {
		throw new UnsupportedOperationException("Sexp is atomic")
	}
	
}