Class {
	#name : #HetCollAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
HetCollAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
HetCollAntipatternVerification class >> verifiedStereotypes [
	^ {OntoUMLCollective.}.
]

{ #category : #verification }
HetCollAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| parts |
	parts := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel
		withStereotype: OntoUMLComponentOf 
		filterBy: [ :componentOf | (componentOf memberEnds second type == aVerifiedObject ) ].
		
	parts size > 1 ifTrue: [ 
		^ {VerificationMessageWarning createFor: aVerifiedObject 
			withVerification: self 
			withText: 'Collective ' , aVerifiedObject name , ' contains multiple different parts.'
			documentationReference: ''} ].
	^{}.
]
