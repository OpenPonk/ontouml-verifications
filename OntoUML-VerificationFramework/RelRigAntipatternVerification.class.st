Class {
	#name : #RelRigAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

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
	associations := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel filterBy: 
		[ :association | association memberEnds anySatisfy: [ :end | end type = aVerifiedRelator ] ].
	
	(associations anySatisfy: [ :association |	association memberEnds anySatisfy: [ :end |
			 end type ~= aVerifiedRelator and: ( OntoUMLModelQuery isStereotypeOf: end type oclKindOf: 'RigidSortal')]])
		ifFalse: [ ^ {} ].
		
	^ { VerificationMessageWarning
		createFor: aVerifiedRelator
		withVerification: self
		withText: 'Relator ' , aVerifiedRelator name , ' is directly conected to rigid element'
		documentationReference: ''. }
]
