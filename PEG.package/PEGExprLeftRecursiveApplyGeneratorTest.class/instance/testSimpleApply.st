as yet unclassified
testSimpleApply
	"
	a = a 'b' | 'a'
	"
	| applyGenerator generator parser parseString parseResult |
	applyGenerator := PEGExprLeftRecursiveApplyGenerator newWithRule: #a.
	
	generator := PEGExprAlternativesGenerator new: {
		PEGExprLexicalSequenceGenerator new: {
			PEGExprLexicalApplyWrapperGenerator newWithRule: #a .
			PEGExprStringGenerator newString: 'b'} .
		PEGExprStringGenerator newString: 'a'}.
	
	applyGenerator compile: #apply_a into: parserClass.
	generator compile: #parse_a into: parserClass.
	parser := parserClass new.
	parseString := 'abb'.
	
	parseResult := parser parse: parseString startingFrom: #a.
	self assert: parseResult endPos == 4