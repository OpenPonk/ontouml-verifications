Class {
	#name : #FreeRoleAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

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
	| mediations |
	mediations := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel
		withStereotype: OntoUMLMediation
		filterBy: [ :association |
			association memberEnds anySatisfy: [ :property | property type = aVerifiedObject ] ].
	mediations := mediations select: [ :mediation | self fulfillsMediationDependency: mediation ].
	mediations size < 1 ifTrue: [ 
		^ { VerificationMessageWarning createFor: aVerifiedObject 
				withVerification: self 
				withText: 'Role ' , aVerifiedObject name , ' should be directly connected with at least one mediation.'. } ].
	^ {}.
]
