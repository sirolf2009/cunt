package com.sirolf2009.cunt

import com.sirolf2009.cunt.sexp.Parser
import org.junit.Assert
import org.junit.Test
import com.sirolf2009.cunt.sexp.SexpList
import com.sirolf2009.cunt.sexp.SexpCollection

class SexpWalkerTest {
	
	@Test
	def void simple() {
		val sexp = !"(+ 5 5)"
		val walker = new SexpWalker(sexp)
		Assert.assertEquals(sexp, walker.get())
		Assert.assertEquals(!"+", walker.down)
		Assert.assertEquals(!"5", walker.right)
		Assert.assertEquals(!"5", walker.right)
		Assert.assertEquals(!"5", walker.left)
		Assert.assertEquals(!"+", walker.left)
	}
	
	@Test
	def void mark() {
		val sexp = !"(+ 5 (+ 6 7))"
		val walker = new SexpWalker(sexp)
		walker.down()
		walker.right()
		walker.right()
		walker.pushMark()
		walker.down()
		Assert.assertEquals(!"6", walker.right)
		Assert.assertEquals(!"7", walker.right)
		walker.popMark()
		Assert.assertEquals(!"5", walker.left)
	}
	
	@Test
	def void next() {
		val sexp = (!"(toplevel (midlevel 1) (midlevel 2))") as SexpList
		val walker = new SexpWalker(sexp)
		Assert.assertEquals(sexp, walker.get())
		Assert.assertEquals(sexp.get(0), walker.next())
		Assert.assertEquals(sexp.get(1), walker.next())
		Assert.assertEquals(sexp.getCollection(1).get(0), walker.next())
		Assert.assertEquals(sexp.getCollection(1).get(1), walker.next())
		Assert.assertEquals(sexp.get(2), walker.next())
		Assert.assertEquals(sexp.getCollection(2).get(0), walker.next())
		Assert.assertEquals(sexp.getCollection(2).get(1), walker.next())
	}
	
	def getCollection(SexpCollection sexp, int index) {
		return sexp.get(index) as SexpCollection
	}
	
	@Test
	def void toList() {
		val sexp = !"(toplevel (midlevel 1) (midlevel 2))"
		val walker = new SexpWalker(sexp)
		Assert.assertArrayEquals(#[
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