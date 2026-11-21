"
Tests diagnostic message formatting, severity levels, and model references generated during OntoUML verification.
"
Class {
	#name : 'VerificationMessageTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Messages',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Messages'
}

{ #category : 'tests' }
VerificationMessageTest >> testCreateForWithDocumentationReferenceAndLazyLookup [

	| kind verification messageWithExplicitRef messageWithLazyRef |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	verification := Verification basicNew.
	messageWithExplicitRef := VerificationMessageError
		                          createFor: kind
		                          withVerification: verification
		                          withText: 'explicit'
		                          documentationReference: 'https://example.org/custom'.
	self assert: messageWithExplicitRef documentationReference equals: 'https://example.org/custom'.
	messageWithExplicitRef documentationReference: 'https://example.org/updated'.
	self assert: messageWithExplicitRef documentationReference equals: 'https://example.org/updated'.
	messageWithLazyRef := VerificationMessageError createFor: kind withVerification: verification withText: 'lazy'.
	self
		assert: messageWithLazyRef documentationReference
		equals: 'https://ontouml.readthedocs.io/en/latest/classes/sortals/kind/index.html'
]

{ #category : 'tests' }
VerificationMessageTest >> testCreateForWithVerificationWithText [

	| validationMessage testObject testVerification testMessageText |
	testObject := Object new.
	testVerification := Verification basicNew.
	testMessageText := 'dummyMessageText'.
	validationMessage := VerificationMessage createFor: testObject withVerification: testVerification withText: testMessageText.
	self assert: validationMessage objectReference identicalTo: testObject.
	self assert: validationMessage verification identicalTo: testVerification.
	self assert: validationMessage messageText equals: testMessageText
]

{ #category : 'tests' }
VerificationMessageTest >> testMessageText [
	| validationMessage testObject testVerification testMessageText secondText |
	testObject := Object new.
	testVerification := Verification basicNew.
	testMessageText := 'dummyMessageText'. 
	secondText := 'changedText'.
	validationMessage := VerificationMessage createFor: testObject withVerification: testVerification  withText: testMessageText.
	self assert: validationMessage messageText equals: testMessageText.
	validationMessage messageText: secondText.
	self assert: validationMessage messageText equals: secondText.
	
]

{ #category : 'tests' }
VerificationMessageTest >> testNew [
	self should: [ VerificationMessage new. ] raise: ShouldNotImplement.
]

{ #category : 'tests' }
VerificationMessageTest >> testObjectReference [

	| validationMessage testObject testVerification testMessageText secondObject |
	testObject := Object new.
	testVerification := Verification basicNew.
	testMessageText := 'dummyMessageText'.
	secondObject := testVerification.
	validationMessage := VerificationMessage createFor: testObject withVerification: testVerification withText: testMessageText.
	self assert: validationMessage objectReference identicalTo: testObject.
	validationMessage objectReference: secondObject.
	self assert: validationMessage objectReference identicalTo: secondObject
]

{ #category : 'tests' }
VerificationMessageTest >> testSeverity [

	| verification errorMessage warningMessage |
	verification := Verification basicNew.
	self should: [ VerificationMessage basicNew severity ] raise: SubclassResponsibility.
	errorMessage := VerificationMessageError createFor: Object new withVerification: verification withText: 'err'.
	warningMessage := VerificationMessageWarning createFor: Object new withVerification: verification withText: 'warn'.
	self assert: errorMessage severity equals: 'Error'.
	self assert: warningMessage severity equals: 'Warning'
]

{ #category : 'tests' }
VerificationMessageTest >> testVerification [

	| validationMessage testObject testVerification testMessageText secondVerification |
	testObject := Object new.
	testVerification := Verification basicNew.
	testMessageText := 'dummyMessageText'.
	secondVerification := testObject.
	validationMessage := VerificationMessage createFor: testObject withVerification: testVerification withText: testMessageText.
	self assert: validationMessage verification identicalTo: testVerification.
	validationMessage verification: secondVerification.
	self assert: validationMessage verification identicalTo: secondVerification
]
