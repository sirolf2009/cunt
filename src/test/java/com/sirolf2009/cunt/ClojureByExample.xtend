package com.sirolf2009.cunt

import com.sirolf2009.cunt.sexp.Parser
import org.junit.Assert
import org.junit.Test

/**
 * https://kimh.github.io/clojure-by-example/
 */
class ClojureByExample {
	
	@Test
	def void helloWorld() {
		'''println("Hello, world!")'''
		->
		'''((println "Hello, world!"))'''
	}
	
	@Test
	def void bindings() {
		'''val a = "aaaaa"'''
		->
		'''((def a "aaaaa"))'''
		
		'''val String a = "aaaaa"'''
		->
		'''((do
			(clojure.core.typed/ann a String)
			(def a "aaaaa")'''
	}
	
	@Test
	def void functions() {
		'''function say-hello(name) {
			println(str("Hello, " name))
		}'''
		->
		'''((defn say-hello
			[name]
		    (println (str "Hello, " name))))'''
	}
	
	@Test
	def void namespaces() {
		'''namespace com.sirolf2009.cunt.ClojureByExample
		import java.util.date
		use clojure.java.io'''
		->
		'''((ns com.sirolf2009.cunt.ClojureByExample
			(:import [java.util.date])
			(:use [clojure.java.io])))'''
	}
	
	@Test
	def void controlFlow() {
		'''
		if(true) {
			println("This is always printed")
		} else {
			println("This is never printed")
		}'''
		->
		'''((if true
		         (println "This is always printed")
		         (println "This is never printed")))'''
	}
	
	def ->(String source, String target) {
		val transpiled = Transpiler.transpile(source)
		try {
			Assert.assertEquals(Parser.parse(target), Transpiler.transpile(source))
		} catch(AssertionError e) {
			println("Expected")
			println(Parser.parse(target))
			println()
			println("Actual")
			println(transpiled)
			throw e
		}
	}
	
}