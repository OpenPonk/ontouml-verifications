Class {
	#name : 'TClassUpdaterTest',
	#superclass : 'TestCase',
	#traits : 'TClassUpdater',
	#classTraits : 'TClassUpdater classTrait',
	#category : 'OntoUML-VerificationFramework-Traits',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Traits'
}

{ #category : 'tests' }
TClassUpdaterTest >> testUpdateMessageWithClassification [
	| testCode |
	testCode := 'testMethod: aResponse
	^ aResponse.'.
	self class updateMessage: testCode withClassification: 'test'. 
	self assert: (self class class canUnderstand: #testMethod:).
	self assert: (self class class >> #testMethod:) sourceCode equals: testCode.
	self assert: (self class class >> #testMethod:) protocolName equals: 'test'.
	self class class removeSelector: #testMethod: .
]
