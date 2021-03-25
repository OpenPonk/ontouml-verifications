Class {
	#name : #RelOverAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
RelOverAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RelOverAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #verification }
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

{ #category : #verification }
RelOverAntipatternVerification >> checkUpperCardinalitiesFor: aMediatedEnds [
	^ (aMediatedEnds collect: [ :end | end upper = '*' ifTrue: [ Float infinity ] ifFalse: [ end upper ]]) sumNumbers > 2.
	
]

{ #category : #verification }
RelOverAntipatternVerification >> getMediatedEndsFor: aRelator from: aModel [	
	^ (OntoUMLModelQuery getAssociationsFrom: aModel
			withStereotype: OntoUMLMediation
			filterBy: [ :mediation |
				mediation memberEnds first type = aRelator or: mediation memberEnds second type = aRelator. ])
			flatCollect:  [ :mediation | mediation memberEnds reject: [ :end | end type = aRelator ]. ].

	
]

{ #category : #verification }
RelOverAntipatternVerification >> verifyObject: aVerifiedRelator withModel: aVerifiedModel [
	| mediatedEnds |
	mediatedEnds :=  self getMediatedEndsFor: aVerifiedRelator from: aVerifiedModel.
	((self checkUpperCardinalitiesFor: mediatedEnds) and: (self checkForOverlap: mediatedEnds)) ifFalse: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning 
			createFor: aVerifiedRelator 
			withVerification: self 
			withText: 'Relator ' ,
				aVerifiedRelator name,
				' is mediated by multiple elements with possible overlap.'
			documentationReference: ''. }
]
