"
I am verification for PartOver anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for PartOver anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionRefereceForPartOver.
"
Class {
	#name : #PartOverAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
PartOverAntipatternVerification class >> abbreviation [
	^ 'PartOver'.
]

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
PartOverAntipatternVerification >> checkOverlapForMixins: aMixinCollection from: aModel [
	| children accumulator |
	accumulator := Set new.
	aMixinCollection do: [ :mixin | 
		children := (OntoUMLModelQuery getDescendantsFor: mixin from: aModel) 
			select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'Sortal' ].
		children do: [ :child | (accumulator includes: child) ifTrue: [ ^ true. ] ifFalse: [ accumulator add: child. ]. ]. ].	
	^ false.
]

{ #category : #verification }
PartOverAntipatternVerification >> checkUpperMultiplicityFor: aPartWholeEnds [
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
	| partWholeAs mixins |
	partWholeAs := self getPartWholeAssociationsFor: aVerifiedPart from: aVerifiedModel.
	partWholeAs ifEmpty: [ ^{}. ].	
	mixins := (partWholeAs collect: [ :association | OntoUMLModelQuery getSourceFrom: association. ]) 
		select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'MixinClass'. ].
	((self checkUpperMultiplicityFor: partWholeAs) and: 
		((self checkForOverlap: partWholeAs) or: (self checkOverlapForMixins: mixins from: aVerifiedModel))) ifFalse: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning 
			createFor: aVerifiedPart 
			withVerification: self 
			withText: aVerifiedPart name,
				' is part of multiple wholes that have possible overlap.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionRefereceForPartOver. }
]
