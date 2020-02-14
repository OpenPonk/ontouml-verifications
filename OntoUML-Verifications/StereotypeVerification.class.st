Class {
	#name : #StereotypeVerification,
	#superclass : #Verification,
	#category : #'OntoUML-Verifications'
}

{ #category : #'instance creation' }
StereotypeVerification class >> canVerify: arg1 [
	^ (super canVerify: arg1) and: (self canVerifyStereotype: arg1)
]

{ #category : #'instance creation' }
StereotypeVerification class >> canVerifyStereotype: arg1 [
	| tmp1 |
	tmp1 := self getStereotype: arg1.
	tmp1 ifNil: [ ^ false ].
	^ self verifiedStereotypes anySatisfy: [ :arg2 | arg2 = tmp1 class ]
]

{ #category : #constants }
StereotypeVerification class >> verifiedStereotypes [
	^ {}
]
