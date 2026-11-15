"
I represent tests for Verification.
"
Class {
	#name : 'VerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
VerificationTest >> getTestedClass [
	^ Verification.
]

{ #category : 'constants' }
VerificationTest >> getVerifiedClass [
	^ nil.
]

{ #category : 'constants' }
VerificationTest >> getVerifiedClassInstance [
	^ nil.
]

{ #category : 'tests' }
VerificationTest >> testCanVerify [

	self
		deny: (self getTestedClass canVerify: self getNotVerifiedClassInstance)
		description: 'Abstract Verification base class must not verify arbitrary objects'
]

{ #category : 'tests' }
VerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
VerificationTest >> testStereotypeVerificationDefaults [

	self assertEmpty: StereotypeVerification verifiedStereotypes.
	self
		deny: (StereotypeVerification canVerifyStereotype: OPUMLClass new)
		description: 'StereotypeVerification without concrete stereotypes must reject unstereotyped class'.
	self
		deny: (StereotypeVerification canVerify: OPUMLClass new)
		description: 'Abstract StereotypeVerification must not verify unstereotyped class'
]

{ #category : 'tests' }
VerificationTest >> testVerifiedClass [

	self assert: self getTestedClass verifiedClass identicalTo: self getVerifiedClass
]

{ #category : 'tests' }
VerificationTest >> testVerifyObjectWithModel [

	self assertEmpty: (self getTestedClass verify: self getVerifiedClassInstance withModel: 'dummyModel')
]
