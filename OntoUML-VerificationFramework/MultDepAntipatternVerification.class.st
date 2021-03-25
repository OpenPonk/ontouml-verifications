Class {
	#name : #MultDepAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
MultDepAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
MultDepAntipatternVerification class >> verifiedStereotypes [ 
	^ { OntoUMLKind. OntoUMLQuantity. OntoUMLCollective. OntoUMLRole. OntoUMLPhase. OntoUMLSubKind. OntoUMLCategory. OntoUMLMixin. OntoUMLRoleMixin.}.
]

{ #category : #verification }
MultDepAntipatternVerification >> checkForRelatorOverlap: aRelators [
	| accumulator tmpAccumulator |
	accumulator := Set new.
	aRelators do: 
		[ :relator | tmpAccumulator := OntoUMLModelQuery getAncestorsFor: relator.
			tmpAccumulator add: relator. 
			tmpAccumulator do: 
			[ :elementOrAncestor | (accumulator includes: elementOrAncestor)
				ifTrue: [ ^ true. ]
				ifFalse: [ accumulator add: elementOrAncestor.].
			].
		].
	^ false.
]

{ #category : #verification }
MultDepAntipatternVerification >> relatorHierarchyExistsFor: aAssociationSet with: aVerifiedObject [
	| relators |
	relators := aAssociationSet collect: [ :association | (OntoUMLModelQuery getSourceFrom: association) = aVerifiedObject 
			ifFalse: [ (OntoUMLModelQuery getSourceFrom: association) ] 
			ifTrue: [ (OntoUMLModelQuery getTargetFrom: association) ] ].
	^ self checkForRelatorOverlap: relators.
]

{ #category : #verification }
MultDepAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| stereotype associations |
	stereotype := (OntoUMLModelQuery getStereotype: aVerifiedObject).
	(stereotype oclIsKindOf: 'Sortal') ifFalse: [ ^ {}. ].
	associations := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel withStereotype: OntoUMLMediation filterBy: 
		[ :object | (object memberEnds first type == aVerifiedObject) or: (object memberEnds second type == aVerifiedObject)].
	(associations size < 2) ifTrue: [ ^ {}. ].
	(self relatorHierarchyExistsFor: associations with: aVerifiedObject) ifTrue: [ ^ {}. ]. 
	^ {VerificationMessageWarning createFor: aVerifiedObject 
			withVerification: self
			withText:  'Sortal ' , aVerifiedObject name , ' is directly connected to two or more mediations.'
			documentationReference: ''}.
]
