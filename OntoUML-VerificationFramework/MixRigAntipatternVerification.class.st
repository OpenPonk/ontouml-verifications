Class {
	#name : #MixRigAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
MixRigAntipatternVerification class >> getRigidTypes [
	^ {  OntoUMLKind. OntoUMLSubKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLRelator. OntoUMLMode. OntoUMLQuality. OntoUMLCategory. }.
]

{ #category : #updating }
MixRigAntipatternVerification class >> getUpdatedMessageCode: aVerificationUpdater [
	| getRigidTypesCode |
	getRigidTypesCode := '"I return collections containing all rigid types."
getRigidTypes
	^ { '.
	(aVerificationUpdater classSpecifications select: [ :class | class rigidity = 'rigid' ])
		do: [ :classSpecification | self checkStringForCodeInjection: classSpecification name.
			getRigidTypesCode := getRigidTypesCode , ' OntoUML',
				classSpecification name , '.' ].
	getRigidTypesCode := getRigidTypesCode , ' }.'.
	^ getRigidTypesCode.
]

{ #category : #updating }
MixRigAntipatternVerification class >> updateFrom: aVerificationUpdater [
	self updateMessage: (self getUpdatedMessageCode: aVerificationUpdater) withClassification: 'constants'.
]

{ #category : #constants }
MixRigAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
MixRigAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLMixin. }.
]

{ #category : #verification }
MixRigAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| subtypes |
	subtypes := OntoUMLModelQuery getChildrenOf: aVerifiedObject from: aVerifiedModel.
	subtypes := subtypes collect: [ :element |
		self class getRigidTypes anySatisfy: [ :stereotypeClass |
			stereotypeClass = (OntoUMLModelQuery getStereotype: element) class ]. ].
	subtypes asSet size = 1 ifFalse: [ ^{}. ].
	^ { VerificationMessageWarning createFor: aVerifiedObject 
			withVerification: self 
			withText: 'All subtypes of Mixin ' , aVerifiedObject name , ' have same rigidity.'
			documentationReference: '' }.
]
