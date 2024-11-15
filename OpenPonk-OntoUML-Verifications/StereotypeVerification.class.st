"
I represent specialisation of  (abstract) Verification class. I add stereotype check to canVerify: method.

My subclasses should override verifiedStereotypes and verifyObject:withModel: methods.

Overriden methods: canVerify.

New methods: canVerifyStereotype:, verifiedStereotypes.
"
Class {
	#name : 'StereotypeVerification',
	#superclass : 'Verification',
	#category : 'OpenPonk-OntoUML-Verifications-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Verification-Classes'
}

{ #category : 'instance creation' }
StereotypeVerification class >> abbreviation [
	^ 'StereotypeVerification'.
]

{ #category : 'instance creation' }
StereotypeVerification class >> canVerify: aVerifiedObject [
	^ (super canVerify: aVerifiedObject) and: (self canVerifyStereotype: aVerifiedObject).
]

{ #category : 'instance creation' }
StereotypeVerification class >> canVerifyStereotype: aVerifiedObject [
	| stereotype |
	stereotype := self getStereotype: aVerifiedObject.
	stereotype ifNil: [ ^false ].
	^ self verifiedStereotypes anySatisfy: [ :class | class = stereotype class ].
]

{ #category : 'testing' }
StereotypeVerification class >> isAbstract [

	^ self = StereotypeVerification
]

{ #category : 'constants' }
StereotypeVerification class >> verifiedStereotypes [
	^ {}.	
]
