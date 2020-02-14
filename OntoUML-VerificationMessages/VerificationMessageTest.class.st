Class {
	#name : #VerificationMessageTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationMessages'
}

{ #category : #tests }
VerificationMessageTest >> testCreateForWithVerificationWithText [
	| tmp1 tmp2 tmp3 tmp4 tmp6 |
	tmp2 := Object new.
	tmp3 := Verification basicNew.
	tmp4 := 'dummyMessageText'.
	tmp1 := VerificationMessage
		createFor: tmp2
		withVerification: tmp3
		withText: tmp4.
	tmp6 := self.
	tmp6
		assert: tmp1 objectReference equals: tmp2;
		assert: tmp1 verification equals: tmp3;
		assert: tmp1 messageText equals: tmp4
]

{ #category : #tests }
VerificationMessageTest >> testMessageText [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp2 := Object new.
	tmp3 := Verification basicNew.
	tmp4 := 'dummyMessageText'.
	tmp5 := 'changedText'.
	tmp1 := VerificationMessage
		createFor: tmp2
		withVerification: tmp3
		withText: tmp4.
	self assert: tmp1 messageText equals: tmp4.
	tmp1 messageText: tmp5.
	self assert: tmp1 messageText equals: tmp5
]

{ #category : #tests }
VerificationMessageTest >> testNew [
	self should: [ VerificationMessage new ] raise: ShouldNotImplement
]

{ #category : #tests }
VerificationMessageTest >> testObjectReference [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp2 := Object new.
	tmp3 := Verification basicNew.
	tmp4 := 'dummyMessageText'.
	tmp5 := tmp3.
	tmp1 := VerificationMessage
		createFor: tmp2
		withVerification: tmp3
		withText: tmp4.
	self assert: tmp1 objectReference equals: tmp2.
	tmp1 objectReference: tmp5.
	self assert: tmp1 objectReference equals: tmp5
]

{ #category : #tests }
VerificationMessageTest >> testVerification [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp2 := Object new.
	tmp3 := Verification basicNew.
	tmp4 := 'dummyMessageText'.
	tmp5 := tmp2.
	tmp1 := VerificationMessage
		createFor: tmp2
		withVerification: tmp3
		withText: tmp4.
	self assert: tmp1 verification equals: tmp3.
	tmp1 verification: tmp5.
	self assert: tmp1 verification equals: tmp5
]
