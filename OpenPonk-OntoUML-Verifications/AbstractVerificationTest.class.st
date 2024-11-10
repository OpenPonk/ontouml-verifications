"
I represent abstract test class.

My responsibility lies in defining unified interface for my subclasses.
"
Class {
	#name : 'AbstractVerificationTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Verification-Tests',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Verification-Tests'
}

{ #category : 'testing' }
AbstractVerificationTest class >> isAbstract [

	^ self = AbstractVerificationTest
]

{ #category : 'tests' }
AbstractVerificationTest >> canVerifyTest [
	self assert: (self getTestedClass canVerify: self getNotVerifiedClassInstance) equals: false.	
	self assert: (self getTestedClass canVerify: self getVerifiedClassInstance) equals: true.
]

{ #category : 'tests - utility' }
AbstractVerificationTest >> createAssociationFrom: aSource to: aEnd [
	| association |
	association := OPUMLAssociation new.
	OPUMLProperty new
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: association;
		type: aSource.
	OPUMLProperty new
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: association;
		type: aEnd.
	association memberEnds addAll: association ownedEnds asArray.
	^ association
]

{ #category : 'tests - utility' }
AbstractVerificationTest >> createAssociationFrom: aSource to: aEnd with: aStereotype [ 
	| association |
	association := self createAssociationFrom: aSource to: aEnd.
	association applyStereotype: aStereotype.
	^ association.
]

{ #category : 'tests - utility' }
AbstractVerificationTest >> createClass: aName withStereotype: aStereotype [
	| result |
	result := OPUMLClass new.
	result applyStereotype: aStereotype new.
	result name: aName.
	^ result.
]

{ #category : 'tests - utility' }
AbstractVerificationTest >> createGeneralizationFor: aGeneral withSpecific: aSpecific [
	| generalization |
	generalization := OPUMLGeneralization new.
	generalization general: aGeneral;
	specific: aSpecific.
	^ generalization.
]

{ #category : 'constants' }
AbstractVerificationTest >> getNotVerifiedClass [
	^ Object.
]

{ #category : 'constants' }
AbstractVerificationTest >> getNotVerifiedClassInstance [
	^ self getNotVerifiedClass new.
]

{ #category : 'constants' }
AbstractVerificationTest >> getTestedClass [
	self subclassResponsibility.
]

{ #category : 'constants' }
AbstractVerificationTest >> getVerifiedClass [
	self subclassResponsibility.
]

{ #category : 'constants' }
AbstractVerificationTest >> getVerifiedClassInstance [
	^ self getVerifiedClass new.
]

{ #category : 'tests' }
AbstractVerificationTest >> newTest [
	self should: [ self getTestedClass new. ] raise: ShouldNotImplement.
]

{ #category : 'tests' }
AbstractVerificationTest >> verifiedClassTest [
	self assert: self getTestedClass verifiedClass equals: self getVerifiedClass.
]
