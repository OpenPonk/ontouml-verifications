"
I am verification for FreeRole anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for FreeRole anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForFreeRole.
"
Class {
	#name : 'FreeRoleAntipatternVerification',
	#superclass : 'StereotypeVerification',
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : 'OntoUML-VerificationFramework-Antipattern-Classes',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
FreeRoleAntipatternVerification class >> abbreviation [
	^ 'FreeRole'.
]

{ #category : 'constants' }
FreeRoleAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
FreeRoleAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLRole. }.
]

{ #category : 'verification' }
FreeRoleAntipatternVerification >> fulfillsMediationDependency: aMediation [
	| sourceLowerBound targetLowerBound |
	sourceLowerBound := (OntoUMLModelQuery getSourceEndFrom: aMediation) lower value.
	targetLowerBound := (OntoUMLModelQuery getTargetEndFrom: aMediation) lower value.
	^ (sourceLowerBound = '*' ifTrue: [ true ] ifFalse: [sourceLowerBound >= 1])
		and: (targetLowerBound = '*' ifTrue: [ true ] ifFalse: [targetLowerBound >= 1]).
]

{ #category : 'verification' }
FreeRoleAntipatternVerification >> fulfillsRelationalDependency: aRelation [
	| sourceLowerBound targetLowerBound |
	sourceLowerBound := (OntoUMLModelQuery getSourceEndFrom: aRelation) lower value.
	targetLowerBound := (OntoUMLModelQuery getTargetEndFrom: aRelation) lower value.
	^ (sourceLowerBound = '*' ifTrue: [ true. ] ifFalse: [ sourceLowerBound >= 1. ])
		and: (targetLowerBound = '*' ifTrue: [ true. ] ifFalse: [ targetLowerBound >= 1. ]).
]

{ #category : 'verification' }
FreeRoleAntipatternVerification >> isFreeRoleOccuringFor: aVerifiedObject withModel: aVerifiedModel [
	| roleAncestors |
	 "Get all ancestors stereotyped as Rolen."
	roleAncestors := (OntoUMLModelQuery getAncestorsFor: aVerifiedObject) select: [ :ancestor |
		 (OntoUMLModelQuery isStereotypeOf: ancestor oclKindOf: 'Role'). ].
	"Check if there is at least one mandatory relation connected to object in the roleAncestors collection."
	^ self isMandatoryRelationConnectedTo: roleAncestors withModel: aVerifiedModel.
]

{ #category : 'verification' }
FreeRoleAntipatternVerification >> isMandatoryMediationConnectedTo: aObjectCollection withModel: aVerifiedModel [
	| mediations |
	"Get all mediations connected to one or more objects from aObjectCollection."
	mediations := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel
		withStereotype: OntoUMLMediation
		filterBy: [ :association |
			association memberEnds anySatisfy: [ :end | aObjectCollection includes: end type ]. ].
	"Filter out all mediations that don't fulfill mediation dependecy."	
	^ mediations anySatisfy: [ :mediation | self fulfillsMediationDependency: mediation ].
]

{ #category : 'verification' }
FreeRoleAntipatternVerification >> isMandatoryRelationConnectedTo: aObjectCollection withModel: aVerifiedModel [
	| relations |
	"Get all relations connected to one or more objects from aObjectCollection."
	relations := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel
		filterBy: [ :association |
			({OntoUMLMediation. OntoUMLMaterial. OntoUMLComponentOf. OntoUMLMemberOf. OntoUMLSubCollectionOf.}
				includes: (self class getStereotype: association) class)
					and: [ association memberEnds anySatisfy: [ :end | aObjectCollection includes: end type ]. ]. ].
	"Filter out all relations that don't fulfill relation dependecy."	
	^ relations anySatisfy: [ :relation | self fulfillsRelationalDependency: relation ].
]

{ #category : 'verification' }
FreeRoleAntipatternVerification >> isRelationDependencyFulfilledFor: aVerifiedObject withModel: aVerifiedModel [
	| ancestorsAndSelf |
	"Get all ancestors stereotyped as RoleMixin."
	ancestorsAndSelf := (OntoUMLModelQuery getAncestorsFor: aVerifiedObject) select: [ :ancestor |
		 (OntoUMLModelQuery isStereotypeOf: ancestor oclKindOf: 'RoleMixin') ].
	"Add verified object to the collection."
	ancestorsAndSelf add: aVerifiedObject.
	"Check if there is at least one mandatory relation connected to object in the ancestorsAndSelf collection."
	^ self isMandatoryRelationConnectedTo: ancestorsAndSelf withModel: aVerifiedModel.
]

{ #category : 'verification' }
FreeRoleAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	"If relational dependecy is fulfilled directly or through relator, free role doesn't occur."
	(self isRelationDependencyFulfilledFor: aVerifiedObject withModel: aVerifiedModel) ifTrue: [ ^{}. ].
	"Check for FreeRole occurence."
	(self isFreeRoleOccuringFor: aVerifiedObject withModel: aVerifiedModel) ifTrue: [ 
		^ { VerificationMessageWarning createFor: aVerifiedObject 
				withVerification: self 
				withText: 'Role ' , aVerifiedObject name , ' should be directly connected with at least one relation.'
				documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForFreeRole. } ].
	"Role with unfullfiled relation dependency is covered by verifications."
	^ {}.
]
