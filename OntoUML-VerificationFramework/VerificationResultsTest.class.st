Class {
	#name : #VerificationResultsTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationFramework-Results'
}

{ #category : #tests }
VerificationResultsTest >> testAddResult [
	| verificationResults dummyMessage |
	dummyMessage := 'dummyMessage'.	
	verificationResults := VerificationResults new.
	self assert: verificationResults results size equals: 0.
	verificationResults addResult: dummyMessage.
	self assert: (verificationResults results anySatisfy: [ :item | item = dummyMessage ])
]

{ #category : #tests }
VerificationResultsTest >> testAddResults [
	| verificationResults dummyMessageCollection |
	dummyMessageCollection := {'dummyMessage'. 'dummyMessage2'}.	
	verificationResults := VerificationResults new.
	self assert: verificationResults results size equals: 0.
	verificationResults addResults: dummyMessageCollection.
	self assert: verificationResults results size equals: 2.
	self assert: (verificationResults results anySatisfy: [ :item | item = (dummyMessageCollection at: 1) ]).
	self assert: (verificationResults results anySatisfy: [ :item | item = (dummyMessageCollection at: 2) ]).
]

{ #category : #tests }
VerificationResultsTest >> testHasErrors [
	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageError createFor: dummyObject withVerification: dummyVerification  withText: 'some text'.	
	verificationResults := VerificationResults new.
	self assert: (verificationResults hasErrors: dummyObject) not.
	verificationResults addResult: dummyMessage.
	self assert: (verificationResults hasErrors: dummyObject).
]

{ #category : #tests }
VerificationResultsTest >> testHasWarnings [
	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageWarning createFor: dummyObject withVerification: dummyVerification  withText: 'some text'.	
	verificationResults := VerificationResults new.
	self assert: (verificationResults hasWarnings: dummyObject) not.
	verificationResults addResult: dummyMessage.
	self assert: (verificationResults hasWarnings: dummyObject).
]

{ #category : #tests }
VerificationResultsTest >> testInitialize [
	self assert: VerificationResults new results equals: Set new.
]

{ #category : #tests }
VerificationResultsTest >> testResults [
	| verificationResults dummyMessage |
	dummyMessage := 'dummyMessage'.	
	verificationResults := VerificationResults new.
	self assert: verificationResults results size equals: 0.
	verificationResults addResult: dummyMessage.
	self assert: verificationResults results size equals: 1.
	self assert: (verificationResults results anySatisfy: [ :item | item = dummyMessage ])
]

{ #category : #tests }
VerificationResultsTest >> testSelectErrors [
	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageError createFor: dummyObject withVerification: dummyVerification  withText: 'some text'.	
	verificationResults := VerificationResults new.
	self assert: verificationResults selectErrors size equals: 0.
	verificationResults addResult: dummyMessage.
	self assert: verificationResults selectErrors size equals: 1.	
	self assert: (verificationResults selectErrors anySatisfy: [ :item | item = dummyMessage ]).
]

{ #category : #tests }
VerificationResultsTest >> testSelectWarnings [
	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageWarning createFor: dummyObject withVerification: dummyVerification  withText: 'some text'.	
	verificationResults := VerificationResults new.
	self assert: verificationResults selectWarnings size equals: 0.
	verificationResults addResult: dummyMessage.
	self assert: verificationResults selectWarnings size equals: 1.	
	self assert: (verificationResults selectWarnings anySatisfy: [ :item | item = dummyMessage ]).
]
