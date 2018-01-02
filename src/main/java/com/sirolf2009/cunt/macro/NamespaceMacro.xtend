package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.PreParseMacro
import java.util.regex.Pattern

class NamespaceMacro implements PreParseMacro {
	
	static val pattern = Pattern.compile("namespace (.+)")
	
	override apply(String it) {
		val matcher = pattern.matcher(it)
		matcher.find()
		replace(matcher, '''(ns «matcher.group(1)»)''')
	}
	
}