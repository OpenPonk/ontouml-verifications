"
I am verification for RelOver anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for RelOver anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForRelOver.
"
Class {
	#name : 'RelOverAntipatternVerification',
	#superclass : 'StereotypeVerification',
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : 'OpenPonk-OntoUML-Verifications-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
RelOverAntipatternVerification class >> abbreviation [
	^ 'RelOver'.
]

{ #category : 'constants' }
RelOverAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
RelOverAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : 'verification' }
RelOverAntipatternVerification >> checkForOverlap: aMediatedEnds [
	| accumulator tmpAccumulator |
	accumulator := Set new.
	aMediatedEnds do: 
		[ :end | tmpAccumulator := Set new.
			tmpAccumulator add: end type. 
			OntoUMLModelQuery  getAncestorsFor: end type into: tmpAccumulator.
			tmpAccumulator do: 
			[ :elementOrAncestor | (accumulator includes: elementOrAncestor)
				ifTrue: [ ^ true. ]
				ifFalse: [ accumulator add: elementOrAncestor.].
			].
		].
	^ false.
]

{ #category : 'verification' }
RelOverAntipatternVerification >> checkOverlapForMixins: aMixinCollection from: aModel [
	| children accumulator |
	accumulator := Set new.
	aMixinCollection do: [ :mixin | 
		children := (OntoUMLModelQuery getDescendantsFor: mixin from: aModel) 
			select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'Sortal' ].
		children do: [ :child | (accumulator includes: child) ifTrue: [ ^ true. ] ifFalse: [ accumulator add: child. ]. ]. ].	
	^ false.
]

{ #category : 'verification' }
RelOverAntipatternVerification >> checkUpperMultiplicityFor: aMediatedEnds [
	^ (aMediatedEnds collect: [ :end | end upper = '*' ifTrue: [ Float infinity. ] ifFalse: [ end upper. ]. ]) sumNumbers > 2.
	
]

{ #category : 'verification' }
RelOverAntipatternVerification >> getMediatedEndsFor: aRelator from: aModel [	
	^ (OntoUMLModelQuery getAssociationsFrom: aModel
			withStereotype: OntoUMLMediation
			filterBy: [ :mediation |
				mediation memberEnds first type = aRelator or: mediation memberEnds second type = aRelator. ])
			flatCollect:  [ :mediation | mediation memberEnds reject: [ :end | end type = aRelator ]. ].

	
]

{ #category : 'verification' }
RelOverAntipatternVerification >> verifyObject: aVerifiedRelator withModel: aVerifiedModel [
	| mediatedEnds mixins |
	mediatedEnds := self getMediatedEndsFor: aVerifiedRelator from: aVerifiedModel.
	mediatedEnds ifEmpty: [ ^{} ].
	mixins := mediatedEnds select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'MixinClass'. ].
	((self checkUpperMultiplicityFor: mediatedEnds) and: 
		((self checkForOverlap: mediatedEnds) "or: [self checkOverlapForMixins: mixins from: aVerifiedModel]")) ifFalse: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning 
			createFor: aVerifiedRelator 
			withVerification: self 
			withText: 'Relator ' ,
				aVerifiedRelator name,
				' is mediated by multiple elements with possible overlap.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForRelOver. }
]
