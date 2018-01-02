# cunt
C-inspired Unusually Named Transpiler

```
namespace com.sirolf2009.cunt.Example
		
function -main(args) {
	println("Hello World")
}
```

```
macro com.sirolf2009.cunt.macro.NamespaceMacro

val pattern = Pattern.compile("namespace (.+)")

function apply(it) {
	val matcher = pattern.matcher(it)
	matcher.find()
	PreParseMacro.replace(matcher, '''(ns «matcher.group(1)»)''')
}
```
