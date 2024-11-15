"
I am verification for UndefPhase anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for UndefPhase anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForUndefPhase.
"
Class {
	#name : 'UndefPhaseAntipatternVerification',
	#superclass : 'Verification',
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : 'OpenPonk-OntoUML-Verifications-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
UndefPhaseAntipatternVerification class >> abbreviation [
	^ 'UndefPhase'.
]

{ #category : 'instance creation' }
UndefPhaseAntipatternVerification class >> canVerify: aVerifiedObject [
	"Checks that aVerifiedObject is generalization set."
	(super canVerify: aVerifiedObject) ifFalse: [ ^ false. ].	
	"Checks that generalization set contains at least one generalization."
	(aVerifiedObject generalizations ifNil: [ ^ false. ]) ifEmpty: [ ^ false. ].
	"Checks that the general is not non-sortal."
	(OntoUMLModelQuery isStereotypeOf: aVerifiedObject generalizations first oclKindOf: 'MixinClass') ifTrue: [ ^ false. ].
	"Allow only if all specifics are phases."
	^ aVerifiedObject generalizations allSatisfy: [ :generalization | (OntoUMLModelQuery getStereotypeClass: generalization specific) = OntoUMLPhase. ].
]

{ #category : 'constants' }
UndefPhaseAntipatternVerification class >> verifiedClass [
	^ OPUMLGeneralizationSet.
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> aspectsExistFor: aElement inModel: aModel [
	^ self aspectsExistFor: aElement inModel: aModel includeAncestors: true. 
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> aspectsExistFor: aElement inModel: aModel includeAncestors: aIncludeBoolean [
	| ancestorsAndSelf characterisations |
	characterisations := OntoUMLModelQuery getAssociationsFrom: aModel
		withStereotype: OntoUMLCharacterization 
		filterBy: [ :characterisation |
			OntoUMLModelQuery isStereotypeOf: (characterisation memberEnds second type) oclKindOf: 'IntrinsicMoment'. ].
	characterisations ifEmpty: [ ^ false ].
	ancestorsAndSelf := Set new.
	aIncludeBoolean ifTrue: [ ancestorsAndSelf addAll: (OntoUMLModelQuery getAncestorsFor: aElement). ].
	ancestorsAndSelf add: aElement.
	^ characterisations
		anySatisfy: [ :characterisation | ancestorsAndSelf includes: characterisation memberEnds first type ].
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> attributesExistFor: aClass [
	^ aClass ownedAttributes isNotNil and: aClass ownedAttributes isNotEmpty.
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> createVerificationMessageFor: aVerifiedPhase [	
	^ VerificationMessageWarning 
			createFor: aVerifiedPhase 
			withVerification: self 
			withText: 'Parents of ',  aVerifiedPhase name,
				' phase don''t have any attributes or qualities.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForUndefPhase.
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> verifyGeneralFor: aVerifiedGeneralizationSet withModel: aVerifiedModel [
	^ (self attributesExistFor: aVerifiedGeneralizationSet generalizations first general) 
			or: [ self aspectsExistFor: aVerifiedGeneralizationSet generalizations first general inModel: aVerifiedModel. ].
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> verifyObject: aVerifiedGeneralizationSet withModel: aVerifiedModel [
	(self verifyGeneralFor: aVerifiedGeneralizationSet withModel: aVerifiedModel) ifTrue: [ ^{}. ].
	(self verifyPhasesIn: aVerifiedGeneralizationSet withModel: aVerifiedModel) ifTrue: [ ^{}. ].
	^ aVerifiedGeneralizationSet generalizations collect: [ :generalization | self createVerificationMessageFor: generalization specific. ].
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> verifyPhase: aVerifiedPhase withModel: aVerifiedModel [
"Checks if phase has at least one attribute or aspect."
	^ (self attributesExistFor: aVerifiedPhase) or: [ self aspectsExistFor: aVerifiedPhase inModel: aVerifiedModel includeAncestors: false. ]. 
]

{ #category : 'verification' }
UndefPhaseAntipatternVerification >> verifyPhasesIn: aVerifiedGenSet withModel: aVerifiedModel [
"Checks if all phases in the generalization set have either attribute or aspect connected to them."
	| results |
	results := aVerifiedGenSet generalizations collect: [ :generalization | self verifyPhase: generalization specific withModel: aVerifiedModel ].
	((results size = 1) and: [ results first = false ]) ifTrue: [ ^ false. ].
	^  (results reject: [ :result | result. "all values are boolean so we can just reject" ]) size <= 1. "One phase without attribute/aspect is allowed." 
]
