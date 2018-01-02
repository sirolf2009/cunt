package com.sirolf2009.cunt.macro

import com.sirolf2009.cunt.PreParseMacro
import java.util.regex.Pattern

class FunctionMacro implements PreParseMacro {

	static val pattern = Pattern.compile('''function (.+)\((.+)\)[\s]*\{[\s]*(.*)[\s]*\}''', Pattern.DOTALL)

	override apply(String it) {
		val matcher = pattern.matcher(it)
		matcher.find()
		replace(matcher, '''
		(defn «matcher.group(1)»
			[«matcher.group(2)»]
		«"	"+matcher.group(3)»)''')
	}

}
