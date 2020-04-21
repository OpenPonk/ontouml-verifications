"
I represent abstract test class.

My responsibility lies in defining unified interface for my subclasses.
"
Class {
	#name : #AbstractVerificationTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #tests }
AbstractVerificationTest >> canVerifyTest [
	self assert: (self getTestedClass canVerify: self getNotVerifiedClassInstance) equals: false.	
	self assert: (self getTestedClass canVerify: self getVerifiedClassInstance) equals: true.
]

{ #category : #'tests - utility' }
AbstractVerificationTest >> createAssociationFrom: aSource to: aEnd [
	| association leftProp rightProp |
	association := OPUMLAssociation new.
	(leftProp := OPUMLProperty new)
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: association;
		type: aSource.
	(rightProp := OPUMLProperty new)
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: association;
		type: aEnd.
	association memberEnds addAll: association ownedEnds asArray.
	^ association
]

{ #category : #constants }
AbstractVerificationTest >> getNotVerifiedClass [
	^ Object.
]

{ #category : #constants }
AbstractVerificationTest >> getNotVerifiedClassInstance [
	^ self getNotVerifiedClass new.
]

{ #category : #constants }
AbstractVerificationTest >> getTestedClass [
	self subclassResponsibility.
]

{ #category : #constants }
AbstractVerificationTest >> getVerifiedClass [
	self subclassResponsibility.
]

{ #category : #constants }
AbstractVerificationTest >> getVerifiedClassInstance [
	^ self getVerifiedClass new.
]

{ #category : #tests }
AbstractVerificationTest >> newTest [
	self should: [ self getTestedClass new. ] raise: ShouldNotImplement.
]

{ #category : #tests }
AbstractVerificationTest >> testUpdateFrom [
	"Each of my subclasses that contains test for updateable verification should implement this method."
	
]

{ #category : #tests }
AbstractVerificationTest >> verifiedClassTest [
	self assert: self getTestedClass verifiedClass equals: self getVerifiedClass.
]
