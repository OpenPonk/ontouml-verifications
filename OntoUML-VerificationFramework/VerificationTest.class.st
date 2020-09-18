"
I represent tests for Verification.
"
Class {
	#name : #VerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Verification-Tests'
}

{ #category : #constants }
VerificationTest >> getTestedClass [
	^ Verification.
]

{ #category : #constants }
VerificationTest >> getVerifiedClass [
	^ nil.
]

{ #category : #constants }
VerificationTest >> getVerifiedClassInstance [
	^ nil.
]

{ #category : #tests }
VerificationTest >> testCanVerify [
	self assert: (self getTestedClass canVerify: self getNotVerifiedClassInstance) equals: false.
]

{ #category : #tests }
VerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
VerificationTest >> testVerifiedClass [
	self assert: self getTestedClass verifiedClass equals: self getVerifiedClass.
]

{ #category : #tests }
VerificationTest >> testVerifyObjectWithModel [
	self assert: (self getTestedClass verify: self getVerifiedClassInstance withModel: 'dummyModel') equals: {}.
]
