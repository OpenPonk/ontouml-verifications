"
Tests aggregation, filtering, and state management of verification result collections in OntoUML.
"
Class {
	#name : 'VerificationResultsTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Results',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Results'
}

{ #category : 'tests' }
VerificationResultsTest >> testAddResult [

	| verificationResults dummyMessage |
	dummyMessage := 'dummyMessage'.
	verificationResults := VerificationResults new.
	self assertEmpty: verificationResults results.
	verificationResults addResult: dummyMessage.
	self assertCollection: verificationResults results hasSameElements: { dummyMessage }
]

{ #category : 'tests' }
VerificationResultsTest >> testAddResults [

	| verificationResults dummyMessageCollection |
	dummyMessageCollection := { 'dummyMessage'. 'dummyMessage2' }.
	verificationResults := VerificationResults new.
	self assertEmpty: verificationResults results.
	verificationResults addResults: dummyMessageCollection.
	self assertCollection: verificationResults results hasSameElements: dummyMessageCollection
]

{ #category : 'tests' }
VerificationResultsTest >> testHasErrors [

	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageError createFor: dummyObject withVerification: dummyVerification withText: 'some text'.
	verificationResults := VerificationResults new.
	self deny: (verificationResults hasErrors: dummyObject) description: 'Empty results should not have errors for object'.
	verificationResults addResult: dummyMessage.
	self assert: (verificationResults hasErrors: dummyObject) description: 'Results containing an error should report errors present'
]

{ #category : 'tests' }
VerificationResultsTest >> testHasWarnings [

	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageWarning createFor: dummyObject withVerification: dummyVerification withText: 'some text'.
	verificationResults := VerificationResults new.
	self deny: (verificationResults hasWarnings: dummyObject) description: 'Empty results should not have warnings for object'.
	verificationResults addResult: dummyMessage.
	self
		assert: (verificationResults hasWarnings: dummyObject)
		description: 'Results containing a warning should report warnings present'
]

{ #category : 'tests' }
VerificationResultsTest >> testInitialize [

	| results |
	results := VerificationResults new results.
	self assert: results class identicalTo: Set.
	self assertEmpty: results
]

{ #category : 'tests' }
VerificationResultsTest >> testMixedErrorsAndWarningsFiltering [

	| verificationResults errorObject warningObject verification errorMessage warningMessage |
	errorObject := Object new.
	warningObject := Object new.
	verification := Verification basicNew.
	errorMessage := VerificationMessageError createFor: errorObject withVerification: verification withText: 'error'.
	warningMessage := VerificationMessageWarning createFor: warningObject withVerification: verification withText: 'warning'.
	verificationResults := VerificationResults new.
	verificationResults addResults: {
			errorMessage.
			warningMessage }.
	self assertCollection: verificationResults selectErrors hasSameElements: { errorMessage }.
	self assertCollection: verificationResults selectWarnings hasSameElements: { warningMessage }.
	self assert: (verificationResults hasErrors: errorObject) description: 'Object with error must report hasErrors: true'.
	self deny: (verificationResults hasErrors: warningObject) description: 'Object with only warning must report hasErrors: false'.
	self assert: (verificationResults hasWarnings: warningObject) description: 'Object with warning must report hasWarnings: true'.
	self deny: (verificationResults hasWarnings: errorObject) description: 'Object with only error must report hasWarnings: false'
]

{ #category : 'tests' }
VerificationResultsTest >> testResults [

	| verificationResults dummyMessage |
	dummyMessage := 'dummyMessage'.
	verificationResults := VerificationResults new.
	self assertEmpty: verificationResults results.
	verificationResults addResult: dummyMessage.
	self assertCollection: verificationResults results hasSameElements: { dummyMessage }
]

{ #category : 'tests' }
VerificationResultsTest >> testSelectErrors [

	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageError createFor: dummyObject withVerification: dummyVerification withText: 'some text'.
	verificationResults := VerificationResults new.
	self assertEmpty: verificationResults selectErrors.
	verificationResults addResult: dummyMessage.
	self assertCollection: verificationResults selectErrors hasSameElements: { dummyMessage }
]

{ #category : 'tests' }
VerificationResultsTest >> testSelectWarnings [

	| verificationResults dummyMessage dummyObject dummyVerification |
	dummyObject := Object new.
	dummyVerification := Verification basicNew.
	dummyMessage := VerificationMessageWarning createFor: dummyObject withVerification: dummyVerification withText: 'some text'.
	verificationResults := VerificationResults new.
	self assertEmpty: verificationResults selectWarnings.
	verificationResults addResult: dummyMessage.
	self assertCollection: verificationResults selectWarnings hasSameElements: { dummyMessage }
]
