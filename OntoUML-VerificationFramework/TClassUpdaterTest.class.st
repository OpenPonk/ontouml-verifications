Class {
	#name : #TClassUpdaterTest,
	#superclass : #TestCase,
	#traits : 'TClassUpdater',
	#classTraits : 'TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Traits'
}

{ #category : #tests }
TClassUpdaterTest >> testUpdateMessageWithClassification [
	| testCode |
	testCode := 'testMethod: aResponse
	^ aResponse.'.
	self class updateMessage: testCode withClassification: 'test'. 
	self assert: (self class class canUnderstand: #testMethod:).
	self assert: (self class class >> #testMethod:) sourceCode equals: testCode.
	self assert: (self class class >> #testMethod:) protocol equals: 'test'.
	self class class removeSelector: #testMethod: .
]
