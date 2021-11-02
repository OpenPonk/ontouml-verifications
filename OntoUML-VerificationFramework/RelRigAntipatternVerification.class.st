"
I am verification for RelRig anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for RelRig anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForRelRig.
"
Class {
	#name : #RelRigAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #checking }
RelRigAntipatternVerification class >> abbreviation [
	^ 'RelRig'.
]

{ #category : #checking }
RelRigAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #checking }
RelRigAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #verification }
RelRigAntipatternVerification >> verifyObject: aVerifiedRelator withModel: aVerifiedModel [
	| associations |
	associations := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel withStereotype: OntoUMLMediation filterBy: 
		[ :association | association memberEnds anySatisfy: [ :end | end type = aVerifiedRelator ] ].
	
	(associations anySatisfy: [ :association |	association memberEnds anySatisfy: [ :end |
			 (end type ~= aVerifiedRelator and: (OntoUMLModelQuery isStereotypeOf: end type oclKindOf: 'RigidSortal')) and: (end isReadOnly not)]])
		ifFalse: [ ^ {} ].
		
	^ { VerificationMessageWarning
		createFor: aVerifiedRelator
		withVerification: self
		withText: 'Relator ' , aVerifiedRelator name , ' is directly conected to rigid element'
		documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForRelRig. }
]
