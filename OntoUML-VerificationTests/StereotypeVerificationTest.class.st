Class {
	#name : #StereotypeVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
StereotypeVerificationTest >> getNotVerifiedClass [
	^ OPUMLAssociation
]

{ #category : #constants }
StereotypeVerificationTest >> getTestedClass [
	^ StereotypeVerification
]

{ #category : #constants }
StereotypeVerificationTest >> getVerifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
StereotypeVerificationTest >> getVerifiedClassInstance [
	^ super getVerifiedClassInstance
		applyStereotype: (self getVerifiedStereotypes at: 1) new
]

{ #category : #constants }
StereotypeVerificationTest >> getVerifiedStereotypes [
	self subclassResponsibility
]

{ #category : #tests }
StereotypeVerificationTest >> testCanVerifyStereotype [
	self
		assert: (self getTestedClass canVerify: OPUMLClass new)
		equals: false
]

{ #category : #tests }
StereotypeVerificationTest >> testVerifiedStereotypes [
	self
		assert: (self getTestedClass verifiedStereotypes isKindOf: Collection)
		equals: true
]
