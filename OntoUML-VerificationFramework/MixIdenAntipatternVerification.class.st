"
I am verification for MixIden anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for MixIden anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionRefereceForMixIden.
"
Class {
	#name : #MixIdenAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
MixIdenAntipatternVerification class >> identityProviders [
	^ { OntoUMLKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLRelator. OntoUMLMode. OntoUMLQuality. }
]

{ #category : #constants }
MixIdenAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
MixIdenAntipatternVerification class >> verifiedStereotypes [
	^ {OntoUMLMixin. OntoUMLRoleMixin. OntoUMLCategory.}.
]

{ #category : #verification }
MixIdenAntipatternVerification >> checkForIdentityOverlapFor: aElements [
	| identityProviders |
	identityProviders := (aElements collect: [ :element | self getIdentityProviderFor: element ]) asSet.
	^ (identityProviders includes: nil) not and: identityProviders size = 1.
]

{ #category : #verification }
MixIdenAntipatternVerification >> getIdentityProviderFor: aElement [
	| identityProvider accumulator | 
	(self providesIdentity: aElement) ifTrue: [ ^ aElement. ].
	accumulator := Set new.
	accumulator add: self.
	aElement generalizations do: [ :generalization | 
		identityProvider := self getIdentityProviderFor: generalization general withAccumulator: accumulator. 
		identityProvider ifNotNil: [ ^ identityProvider. ]. ].
	^ nil.
]

{ #category : #verification }
MixIdenAntipatternVerification >> getIdentityProviderFor: aElement withAccumulator: aAccumulator [
	| identityProvider | 		
	(self providesIdentity: aElement) ifTrue: [ ^ aElement. ].	
	(aAccumulator includes: self) ifTrue: [ ^nil ].
	aAccumulator add: self.	
	aElement generalizations do: [ :generalization | 
		identityProvider := self getIdentityProviderFor: generalization general withAccumulator: aAccumulator. 
		identityProvider ifNotNil: [ ^ identityProvider. ]. ].
	^ nil.
]

{ #category : #verification }
MixIdenAntipatternVerification >> providesIdentity: aElement [
	^ self class identityProviders includes: (OntoUMLModelQuery getStereotypeClass: aElement).
]

{ #category : #verification }
MixIdenAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| subtypes |
	subtypes := OntoUMLModelQuery getChildrenOf: aVerifiedObject from: aVerifiedModel.
	((subtypes allSatisfy: [ :subtype | OntoUMLModelQuery isStereotypeOf: subtype oclKindOf: 'Sortal' ]) 
		and: (self checkForIdentityOverlapFor: subtypes))
			ifFalse: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning 
			createFor: aVerifiedObject 
			withVerification: self 
			withText: aVerifiedObject name,
				' has only sortal subtypes that follow the same identity principle.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionRefereceForMixIden. }
]
