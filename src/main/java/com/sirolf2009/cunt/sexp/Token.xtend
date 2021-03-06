package com.sirolf2009.cunt.sexp

import org.eclipse.xtend.lib.annotations.Accessors

class Token {

	public static val char commentChar = ';'
	public static val char escapeChar = '\\'
	public static val char quotationMarkChar = '\"'
	public static val char leftParenthesisChar = '('
	public static val char rightParenthesisChar = ')'
	public static val char leftBracketChar = '['
	public static val char rightBracketChar = ']'
	public static val char verticalBarChar = '|'
	public static val char newLineChar = '\n'
	public static val char returnChar = '\r'
	public static val char spaceChar = ' '
	public static val char tabChar = '\t'

	val StringBuffer data = new StringBuffer()
	@Accessors var int location
	
	def append(char character) {
		data.append(character)
	}
	
	def append(String string) {
		data.append(string)
	}
	
	def getData() {
		return data.toString()
	}
	
	def length() {
		return data.length()
	}
	
	def size() {
		return length()
	}
	
	def isComment() {
		return getData().startsWith("" + commentChar)
	}

	def isLeftParenthesis() {
		return getData().equals("" + leftParenthesisChar)
	}

	def isRightParenthesis() {
		return getData().equals("" + rightParenthesisChar)
	}

	def isLeftBracket() {
		return getData().equals("" + leftBracketChar)
	}

	def isRightBracket() {
		return getData().equals("" + rightBracketChar)
	}

	def isQuotationMarkToken() {
		return getData().startsWith("" + quotationMarkChar) && getData().endsWith("" + quotationMarkChar)
	}

	def isVerticalBarToken() {
		return getData().startsWith("" + verticalBarChar) && getData().endsWith("" + verticalBarChar)
	}
	
	override equals(Object obj) {
		return obj instanceof Token && (obj as Token).data.toString().equals(data.toString())
	}

	override toString() {
		return getData()
	}

}
