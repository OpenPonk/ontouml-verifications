Class {
	#name : #PartOverAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
PartOverAntipatternVerification class >> partWholeAssociations [
	^ { OntoUMLSubCollectionOf. OntoUMLSubQuantityOf. OntoUMLMemberOf. OntoUMLComponentOf. }.
]

{ #category : #constants }
PartOverAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
PartOverAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLSubKind. OntoUMLPhase. OntoUMLRole. OntoUMLRoleMixin. OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : #verification }
PartOverAntipatternVerification >> checkForOverlap: aMediatedEnds [
	| accumulator tmpAccumulator |
	accumulator := Set new.
	aMediatedEnds do: 
		[ :association | tmpAccumulator := OntoUMLModelQuery getAncestorsFor: (OntoUMLModelQuery getSourceFrom: association).
			tmpAccumulator add: (OntoUMLModelQuery getSourceFrom: association). 
			tmpAccumulator do: 
			[ :elementOrAncestor | (accumulator includes: elementOrAncestor)
				ifTrue: [ ^ true. ]
				ifFalse: [ accumulator add: elementOrAncestor.].
			].
		].
	^ false.
]

{ #category : #verification }
PartOverAntipatternVerification >> checkUpperCardinalitiesFor: aPartWholeEnds [
	^ (aPartWholeEnds collect: [ :association | association memberEnds second upper = '*'
			ifTrue: [ Float infinity ]
			ifFalse: [ association memberEnds second upper ]]) sumNumbers >= 2.
	
]

{ #category : #verification }
PartOverAntipatternVerification >> getPartWholeAssociationsFor: aPart from: aModel [
	^ OntoUMLModelQuery getAssociationsFrom: aModel filterBy: [ :association |
		(self class partWholeAssociations includes: (OntoUMLModelQuery getStereotype: association) class)
			and: ((OntoUMLModelQuery getTargetFrom: association) = aPart) ].
]

{ #category : #verification }
PartOverAntipatternVerification >> verifyObject: aVerifiedPart withModel: aVerifiedModel [
	| partWholeAs  |
	partWholeAs := self getPartWholeAssociationsFor: aVerifiedPart from: aVerifiedModel.
	((self checkUpperCardinalitiesFor: partWholeAs) and: (self checkForOverlap: partWholeAs)) ifFalse: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning 
			createFor: aVerifiedPart 
			withVerification: self 
			withText: aVerifiedPart name,
				' is part of multiple wholes that have possible overlap.'
			documentationReference: ''. }
]
