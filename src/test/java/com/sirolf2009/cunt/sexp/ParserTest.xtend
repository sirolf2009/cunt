package com.sirolf2009.cunt.sexp

import org.junit.Test
import org.junit.Assert

class ParserTest {

	@Test
	def void singleAtom() {
		Assert.assertEquals(a("atom"), Parser.parse("atom"))
	}

	@Test
	def void singleList() {
		Assert.assertEquals(l("atom1", "atom2"), Parser.parse("(atom1 atom2)"))
	}

	@Test
	def void nestedList() {
		Assert.assertEquals(l("atom1", l("atom2", "atom3")), Parser.parse("(atom1 (atom2 atom3))"))
	}

	@Test
	def void singleVector() {
		Assert.assertEquals(v("atom1", "atom2"), Parser.parse("[atom1 atom2]"))
	}

	@Test
	def void nestedVector() {
		Assert.assertEquals(v("atom1", v("atom2", "atom3")), Parser.parse("[atom1 [atom2 atom3]]"))
	}

	@Test
	def void nestedCollections() {
		val expected = v(
			"atom1",
			l(
				"atom2",
				"atom3",
				v(
					"atom4",
					l("atom5")
				)
			)
		)
		Assert.assertEquals(expected, Parser.parse("[atom1 (atom2 atom3 [atom4 (atom5)])]"))
	}

	def l(Object... sexps) {
		return new SexpList(sexps.convert)
	}

	def v(Object... sexps) {
		return new SexpVector(sexps.convert)
	}

	def a(String data) {
		return new SexpAtom(data)
	}

	def convert(Object... sexps) {
		sexps.map [
			if(it instanceof String) {
				return a(it)
			}
			return it as Sexp
		]
	}

}
