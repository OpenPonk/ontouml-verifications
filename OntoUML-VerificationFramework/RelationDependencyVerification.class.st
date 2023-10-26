"
I am verification for RoleMediationDependency rule. 

Overriden methods: verifiedClass, verifyObject:withModel:, verifiedStereotypes.

New methods: calculateMultiplicity:, calculateMultiplicity:forMediation:, fulfilsMediationDependecy:.
"
Class {
	#name : #RelationDependencyVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-VerificationFramework-Verification-Classes'
}

{ #category : #constants }
RelationDependencyVerification class >> abbreviation [
	^ 'RoleMediationDependency'.
]

{ #category : #constants }
RelationDependencyVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RelationDependencyVerification class >> verifiedStereotypes [
	^ { OntoUMLRole.}.
]

{ #category : #verification }
RelationDependencyVerification >> fulfillsRelationalDependency: aRelation [
	| sourceLowerBound targetLowerBound |
	sourceLowerBound := (OntoUMLModelQuery getSourceEndFrom: aRelation) lower value.
	targetLowerBound := (OntoUMLModelQuery getTargetEndFrom: aRelation) lower value.
	^ (sourceLowerBound = '*' ifTrue: [ true. ] ifFalse: [ sourceLowerBound >= 1. ])
		and: (targetLowerBound = '*' ifTrue: [ true. ] ifFalse: [ targetLowerBound >= 1. ]).
]

{ #category : #verification }
RelationDependencyVerification >> isMandatoryRelationConnectedTo: aObjectCollection withModel: aVerifiedModel [
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

{ #category : #verification }
RelationDependencyVerification >> putRoleAndItsPredecessors: aRole intoSet: aSet [
	aSet add: aRole.
	aRole generalizations ifEmpty: [ ^ self. ].
	aRole generalizations do: [ :generalization | 
		   ({ OntoUMLRole. OntoUMLRoleMixin. } includes: (self class getStereotype: generalization general) class) ifTrue: [ 
			(aSet includes: generalization general) ifFalse: [
				(self putRoleAndItsPredecessors: generalization general intoSet: aSet) ]. ]. ].	
]

{ #category : #verification }
RelationDependencyVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| roleTree |
	roleTree := Set new.
	self putRoleAndItsPredecessors: aVerifiedObject intoSet: roleTree.
	(self isMandatoryRelationConnectedTo: roleTree withModel: aVerifiedModel)
		ifFalse: [ ^ {VerificationMessageError 
			createFor: aVerifiedObject 
			withVerification: self 
			withText:(self class getStereotype: aVerifiedObject) class name , ' has to have at least one association stereotyped as mediation, material, componentOf, memberOf or subCollectionOf, with multiplicities on both ends >= 1.'} ].
	^ {}.
	

]
