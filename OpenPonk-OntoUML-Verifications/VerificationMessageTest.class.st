Class {
	#name : 'VerificationMessageTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Messages',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Messages'
}

{ #category : 'tests' }
VerificationMessageTest >> testCreateForWithVerificationWithText [
	| validationMessage testObject testVerification testMessageText |
	testObject := Object new.
	testVerification := Verification basicNew.
	testMessageText := 'dummyMessageText'. 
	validationMessage := VerificationMessage createFor: testObject withVerification: testVerification  withText: testMessageText.
	self assert: validationMessage objectReference equals: testObject;
	assert: validationMessage verification equals: testVerification;	
	assert: validationMessage messageText  equals: testMessageText.
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
	validationMessage := VerificationMessage createFor: testObject withVerification: testVerification  withText: testMessageText.
	self assert: validationMessage objectReference equals: testObject.
	validationMessage objectReference: secondObject.
	self assert: validationMessage objectReference equals: secondObject.
]

{ #category : 'tests' }
VerificationMessageTest >> testVerification [
	| validationMessage testObject testVerification testMessageText secondVerification |
	testObject := Object new.
	testVerification := Verification basicNew.
	testMessageText := 'dummyMessageText'.
	secondVerification := testObject.
	validationMessage := VerificationMessage createFor: testObject withVerification: testVerification  withText: testMessageText.	
	self assert: validationMessage verification equals: testVerification.
	validationMessage verification: secondVerification.
	self assert: validationMessage verification equals: secondVerification.
]
