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
	^ super getVerifiedClassInstance applyStereotype: (self getVerifiedStereotypes at: 1) new.
]

{ #category : 'constants' }
StereotypeVerificationTest >> getVerifiedStereotypes [
	self subclassResponsibility.
]

{ #category : 'testing' }
StereotypeVerificationTest >> isAbstract [

	^ self = StereotypeVerificationTest
]

{ #category : 'tests' }
StereotypeVerificationTest >> testCanVerifyStereotype [
	self assert: (self getTestedClass canVerify: OPUMLClass new) equals: false.	
]

{ #category : 'tests' }
StereotypeVerificationTest >> testVerifiedStereotypes [
	self assert: (self getTestedClass verifiedStereotypes isKindOf: Collection) equals: true.	
]
