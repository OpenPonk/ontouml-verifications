"
I represent tests for StereotypeVerification.
"
Class {
	#name : 'StereotypeVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Verification-Classes'
}

{ #category : 'testing' }
StereotypeVerificationTest class >> isAbstract [

	^ self = StereotypeVerificationTest
]

{ #category : 'constants' }
StereotypeVerificationTest >> getNotVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'constants' }
StereotypeVerificationTest >> getTestedClass [
	^ StereotypeVerification.
]

{ #category : 'constants' }
StereotypeVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
StereotypeVerificationTest >> getVerifiedClassInstance [

	^ super getVerifiedClassInstance applyStereotype: self getVerifiedStereotypes first new
]

{ #category : 'constants' }
StereotypeVerificationTest >> getVerifiedStereotypes [
	self subclassResponsibility.
]

{ #category : 'tests' }
StereotypeVerificationTest >> testCanVerifyStereotype [

	self
		deny: (self getTestedClass canVerify: self getVerifiedClass new)
		description: 'Stereotype verification must reject verified class instance without stereotype'
]

{ #category : 'tests' }
StereotypeVerificationTest >> testVerifiedStereotypes [

	self assertCollection: self getTestedClass verifiedStereotypes hasSameElements: self getVerifiedStereotypes
]
