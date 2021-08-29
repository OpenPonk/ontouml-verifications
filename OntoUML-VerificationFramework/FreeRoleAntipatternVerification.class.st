"
I am verification for FreeRole anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for FreeRole anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForFreeRole.
"
Class {
	#name : #FreeRoleAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
FreeRoleAntipatternVerification class >> abbreviation [
	^ 'FreeRole'.
]

{ #category : #constants }
FreeRoleAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
FreeRoleAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLRole. }.
]

{ #category : #verification }
FreeRoleAntipatternVerification >> fulfillsMediationDependency: aMediation [
	| sourceLowerBound targetUpperBound |
	sourceLowerBound := (OntoUMLModelQuery getSourceEndFrom: aMediation) lower value.
	targetUpperBound := (OntoUMLModelQuery getTargetEndFrom: aMediation) lower value.
	^ (sourceLowerBound = '*' ifTrue: [ true ] ifFalse: [sourceLowerBound >= 1])
		and: (targetUpperBound = '*' ifTrue: [ true ] ifFalse: [targetUpperBound >= 1]).
]

{ #category : #verification }
FreeRoleAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| mediations roleAncestors ancestorsAndSelf |
	roleAncestors := (OntoUMLModelQuery getAncestorsFor: aVerifiedObject) select: [ :ancestor |
		 (OntoUMLModelQuery isStereotypeOf: ancestor oclKindOf: 'Role')].
	ancestorsAndSelf := roleAncestors.
	ancestorsAndSelf add: aVerifiedObject.
	
	mediations := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel
		withStereotype: OntoUMLMediation
		filterBy: [ :association |
			association memberEnds anySatisfy: [ :end | ancestorsAndSelf includes: end type ]. ].
	mediations := mediations select: [ :mediation | self fulfillsMediationDependency: mediation ].
	
	(mediations anySatisfy: [ :mediation | mediation memberEnds anySatisfy: [ :end | end type = aVerifiedObject ] ]) ifTrue: [ ^{ }. ].
	(mediations anySatisfy: [ :mediation | mediation memberEnds anySatisfy: [ :end | roleAncestors includes: end type ] ]) ifTrue: [ 
		^ { VerificationMessageWarning createFor: aVerifiedObject 
				withVerification: self 
				withText: 'Role ' , aVerifiedObject name , ' should be directly connected with at least one mediation.'
				documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForFreeRole. } ].
	^ {}.
]
