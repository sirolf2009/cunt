package com.sirolf2009.cunt

import java.util.regex.Matcher

interface PreParseMacro {
	
	def String apply(String it)

	def replace(String source, Matcher matcher, String replacement) {
		val newSource = new StringBuffer(source.substring(0, matcher.start(0)))
		newSource.append(replacement)
		if(matcher.end(0) != source.length()) {
			newSource.append(source.substring(matcher.end(0), source.length()))
		}
		return newSource.toString()
	}
	
}