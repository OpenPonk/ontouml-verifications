Class {
	#name : #VerificationResultsTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationResults'
}

{ #category : #tests }
VerificationResultsTest >> testAddResult [
	| tmp1 tmp2 |
	tmp2 := 'dummyMessage'.
	tmp1 := VerificationResults new.
	self assert: tmp1 results size equals: 0.
	tmp1 addResult: tmp2.
	self assert: (tmp1 results anySatisfy: [ :arg1 | arg1 = tmp2 ])
]

{ #category : #tests }
VerificationResultsTest >> testAddResults [
	| tmp1 tmp2 |
	tmp2 := {'dummyMessage' . 'dummyMessage2'}.
	tmp1 := VerificationResults new.
	self assert: tmp1 results size equals: 0.
	tmp1 addResults: tmp2.
	self
		assert: tmp1 results size equals: 2;
		assert: (tmp1 results anySatisfy: [ :arg1 | arg1 = (tmp2 at: 1) ]);
		assert: (tmp1 results anySatisfy: [ :arg2 | arg2 = (tmp2 at: 2) ])
]

{ #category : #tests }
VerificationResultsTest >> testHasErrors [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp3 := Object new.
	tmp4 := Verification basicNew.
	tmp2 := VerificationMessageError
		createFor: tmp3
		withVerification: tmp4
		withText: 'some text'.
	tmp1 := VerificationResults new.
	self assert: (tmp1 hasErrors: tmp3) not.
	tmp1 addResult: tmp2.
	self assert: (tmp1 hasErrors: tmp3)
]

{ #category : #tests }
VerificationResultsTest >> testHasWarnings [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp3 := Object new.
	tmp4 := Verification basicNew.
	tmp2 := VerificationMessageWarning
		createFor: tmp3
		withVerification: tmp4
		withText: 'some text'.
	tmp1 := VerificationResults new.
	self assert: (tmp1 hasWarnings: tmp3) not.
	tmp1 addResult: tmp2.
	self assert: (tmp1 hasWarnings: tmp3)
]

{ #category : #tests }
VerificationResultsTest >> testInitialize [
	self assert: VerificationResults new results equals: Set new
]

{ #category : #tests }
VerificationResultsTest >> testResults [
	| tmp1 tmp2 |
	tmp2 := 'dummyMessage'.
	tmp1 := VerificationResults new.
	self assert: tmp1 results size equals: 0.
	tmp1 addResult: tmp2.
	self
		assert: tmp1 results size equals: 1;
		assert: (tmp1 results anySatisfy: [ :arg1 | arg1 = tmp2 ])
]

{ #category : #tests }
VerificationResultsTest >> testSelectErrors [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp3 := Object new.
	tmp4 := Verification basicNew.
	tmp2 := VerificationMessageError
		createFor: tmp3
		withVerification: tmp4
		withText: 'some text'.
	tmp1 := VerificationResults new.
	self assert: tmp1 selectErrors size equals: 0.
	tmp1 addResult: tmp2.
	self
		assert: tmp1 selectErrors size equals: 1;
		assert: (tmp1 selectErrors anySatisfy: [ :arg1 | arg1 = tmp2 ])
]

{ #category : #tests }
VerificationResultsTest >> testSelectWarnings [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp3 := Object new.
	tmp4 := Verification basicNew.
	tmp2 := VerificationMessageWarning
		createFor: tmp3
		withVerification: tmp4
		withText: 'some text'.
	tmp1 := VerificationResults new.
	self assert: tmp1 selectWarnings size equals: 0.
	tmp1 addResult: tmp2.
	self
		assert: tmp1 selectWarnings size equals: 1;
		assert: (tmp1 selectWarnings anySatisfy: [ :arg1 | arg1 = tmp2 ])
]
