"
I am verification for UndefPhase anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for UndefPhase anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForUndefPhase.
"
Class {
	#name : #UndefPhaseAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
UndefPhaseAntipatternVerification class >> abbreviation [
	^ 'UndefPhase'.
]

{ #category : #constants }
UndefPhaseAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
UndefPhaseAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLPhase. }.
]

{ #category : #verification }
UndefPhaseAntipatternVerification >> aspectsExistFor: aObject inModel: aModel [
	| ancestorsAndSelf characterisations |
	characterisations := OntoUMLModelQuery getAssociationsFrom: aModel
		withStereotype: OntoUMLCharacterization 
		filterBy: [ :characterisation |
			(self class getStereotype: characterisation memberEnds second type) class == OntoUMLQuality ].
	characterisations ifEmpty: [ ^ false ].
	ancestorsAndSelf := OntoUMLModelQuery getAncestorsFor: aObject.
	ancestorsAndSelf add: aObject.
	^ characterisations
		anySatisfy: [ :characterisation | ancestorsAndSelf includes: characterisation memberEnds first type ].
]

{ #category : #verification }
UndefPhaseAntipatternVerification >> attributesExistFor: aClass [
	^ aClass ownedAttributes isNotNil and: aClass ownedAttributes isNotEmpty.
]

{ #category : #verification }
UndefPhaseAntipatternVerification >> verifyObject: aVerifiedPhase withModel: aVerifiedModel [
	| parents result |
	parents := aVerifiedPhase generalizations collect: [ :generalization | generalization general. ].
	result := parents anySatisfy: [ :parent | (self attributesExistFor: parent) or: (self aspectsExistFor: parent inModel: aVerifiedModel) ].
	result ifTrue: [ ^ {}. ].
	^ { VerificationMessageWarning 
			createFor: aVerifiedPhase 
			withVerification: self 
			withText: 'Parents of ',  aVerifiedPhase name,
				' phase don''t have any attributes or qualities.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForUndefPhase. }

]
