package com.sirolf2009.cunt

import com.sirolf2009.cunt.sexp.Parser
import org.junit.Assert
import org.junit.Test

class SexpWalkerTest {
	
	@Test
	def void next() {
		val sexp = !"(toplevel (midlevel 1) (midlevel 2))"
		val walker = new SexpWalker(sexp)
		Assert.assertEquals(sexp, walker.getFocus())
		Assert.assertEquals(sexp.get(0), walker.next())
		Assert.assertEquals(sexp.get(1), walker.next())
		Assert.assertEquals(sexp.get(1).get(0), walker.next())
		Assert.assertEquals(sexp.get(1).get(1), walker.next())
		Assert.assertEquals(sexp.get(2), walker.next())
		Assert.assertEquals(sexp.get(2).get(0), walker.next())
		Assert.assertEquals(sexp.get(2).get(1), walker.next())
	}
	
	@Test
	def void toList() {
		val sexp = !"(toplevel (midlevel 1) (midlevel 2))"
		val walker = new SexpWalker(sexp)
		Assert.assertEquals(#[
			!"(toplevel (midlevel 1) (midlevel 2))",
			!"toplevel",
			!"(midlevel 1)",
			!"midlevel",
			!"1",
			!"(midlevel 2)",
			!"midlevel",
			!"2"
		], walker.toList())
	}
	
	def !(String string) {
		return Parser.parse(string)
	}
	
}