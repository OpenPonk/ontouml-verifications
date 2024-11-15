"
I am verification for UndefFormal anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for UndefFormal anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForUndefFormal.
"
Class {
	#name : 'UndefFormalAntipatternVerification',
	#superclass : 'StereotypeVerification',
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : 'OpenPonk-OntoUML-Verifications-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
UndefFormalAntipatternVerification class >> abbreviation [
	^ 'UndefFormal'.
]

{ #category : 'constants' }
UndefFormalAntipatternVerification class >> verifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'constants' }
UndefFormalAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLDomainFormal. }.
]

{ #category : 'verification' }
UndefFormalAntipatternVerification >> attributesExistFor: aClass [
	^ aClass ownedAttributes isNotNil and: aClass ownedAttributes isNotEmpty.
]

{ #category : 'verification' }
UndefFormalAntipatternVerification >> qualitiesExistFor: aObject inModel: aModel [
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

{ #category : 'verification' }
UndefFormalAntipatternVerification >> verifyObject: aVerifiedAssociation withModel: aVerifiedModel [
	| source target result |
	source := (aVerifiedAssociation memberEnds at: 1) type. 
	target := (aVerifiedAssociation memberEnds at: 2) type.
	result := (((self attributesExistFor: source) or: (self qualitiesExistFor: source inModel: aVerifiedModel))
		and: ((self attributesExistFor: target) or: (self qualitiesExistFor: target inModel: aVerifiedModel))).
	result ifTrue: [ ^ {}. ].
	^ { VerificationMessageWarning 
			createFor: aVerifiedAssociation 
			withVerification: self 
			withText: 'Formal association ' ,
				(OntoUMLModelQuery getAssociationName: aVerifiedAssociation) ,
				' joins two elements and one or both of the elements don''t have attribute/quality.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForUndefFormal. }

]
