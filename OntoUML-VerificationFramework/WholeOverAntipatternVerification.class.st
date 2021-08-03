"
I am verification for WholeOver anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for WholeOver anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionRefereceForWholeOver.
"
Class {
	#name : #WholeOverAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
WholeOverAntipatternVerification class >> abbreviation [
	^ 'WholeOver'.
]

{ #category : #constants }
WholeOverAntipatternVerification class >> partWholeAssociations [
	^ { OntoUMLSubCollectionOf. OntoUMLSubQuantityOf. OntoUMLMemberOf. OntoUMLComponentOf. }.
]

{ #category : #constants }
WholeOverAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
WholeOverAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLSubKind. OntoUMLPhase. OntoUMLRole. OntoUMLRoleMixin. OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : #verification }
WholeOverAntipatternVerification >> checkForOverlap: aPartEnds inModel: aModel [
	| accumulator tmpAccumulator |
	accumulator := Set new.
	aPartEnds do: 
		[ :end | tmpAccumulator := Set new.
			tmpAccumulator add: end type. 
			OntoUMLModelQuery getAncestorsFor: end type into: tmpAccumulator.
			OntoUMLModelQuery getDescendantsFor: end type from: aModel into: tmpAccumulator. 
			tmpAccumulator do: 
			[ :elementOrAncestor | (accumulator includes: elementOrAncestor)
				ifTrue: [ ^ true. ]
				ifFalse: [ accumulator add: elementOrAncestor.].
			].
		].
	^ false.
]

{ #category : #verification }
WholeOverAntipatternVerification >> checkOverlapForMixins: aMixinCollection from: aModel [
	| children accumulator |
	accumulator := Set new.
	aMixinCollection do: [ :mixin | 
		children := (OntoUMLModelQuery getDescendantsFor: mixin from: aModel) 
			select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'Sortal' ].
		children do: [ :child | (accumulator includes: child) ifTrue: [ ^ true. ] ifFalse: [ accumulator add: child. ]. ]. ].	
	^ false.
]

{ #category : #verification }
WholeOverAntipatternVerification >> checkUpperMultiplicityFor: aPartEnds [
	^ (aPartEnds collect: [ :end | end upper = '*' ifTrue: [ Float infinity ] ifFalse: [ end upper ]]) sumNumbers >= 2.
]

{ #category : #verification }
WholeOverAntipatternVerification >> getPartEndsFor: aWhole from: aModel [
	^ (OntoUMLModelQuery getAssociationsFrom: aModel filterBy: [ :association |
		(self class partWholeAssociations includes: (OntoUMLModelQuery getStereotypeClass: association))
			and: (OntoUMLModelQuery getSourceFrom: association) = aWhole ])
		collect:  [ :association | association memberEnds second. ].
]

{ #category : #verification }
WholeOverAntipatternVerification >> verifyObject: aVerifiedWhole withModel: aVerifiedModel [
	| partEnds mixins |
	partEnds :=  self getPartEndsFor: aVerifiedWhole from: aVerifiedModel.
	mixins := partEnds select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'MixinClass'. ].
	((self checkUpperMultiplicityFor: partEnds) and: 
		((self checkForOverlap: partEnds inModel: aVerifiedModel) or: (self checkOverlapForMixins: mixins from: aVerifiedModel))) ifFalse: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning 
			createFor: aVerifiedWhole 
			withVerification: self 
			withText: 'Whole ' ,
				aVerifiedWhole name,
				' has multiple parts with possible overlap.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionRefereceForWholeOver. }
]
