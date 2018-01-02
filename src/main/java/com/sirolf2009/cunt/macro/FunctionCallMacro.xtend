package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.PreParseMacro
import java.util.ArrayList
import java.util.regex.Pattern

class FunctionCallMacro implements PreParseMacro {

	static val pattern = Pattern.compile('''([^(\s]+)\(([^)]*)\)''')
	static val paramPattern = Pattern.compile('''([^,]+)*''')

	override apply(String source) {
		var it = source
		while(true) {
			val matcher = pattern.matcher(it)
			if(matcher.find()) {
				val paramMatcher = paramPattern.matcher(matcher.group(2))
				val params = new ArrayList()
				while(paramMatcher.find()) {
					if(!paramMatcher.group(0).empty) {
						params.add(paramMatcher.group(0).trim())
					}
				}
				it = replace(matcher, '''(«matcher.group(1)» «params.join(" ")»)''')
			} else {
				return it
			}
		}
	}

}