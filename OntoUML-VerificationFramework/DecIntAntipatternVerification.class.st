Class {
	#name : #DecIntAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
DecIntAntipatternVerification class >> allowedSupertypes [
	^ { OntoUMLMixin. OntoUMLRoleMixin. OntoUMLCategory. }
]

{ #category : #constants }
DecIntAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
DecIntAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLSubKind. OntoUMLPhase. OntoUMLMode. OntoUMLRole. OntoUMLRelator.}.
]

{ #category : #verification }
DecIntAntipatternVerification >> getSuspiciousParentsFor: aVerifiedObject [
	^ (OntoUMLModelQuery getParentsOf: aVerifiedObject)
		reject: [ :element | self class allowedSupertypes includes: (OntoUMLModelQuery getStereotypeClass: element) ].
]

{ #category : #verification }
DecIntAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| supertypes |
	supertypes := self getSuspiciousParentsFor: aVerifiedObject.
	supertypes size > 1 ifFalse: [ ^ {}. ].
	"ifTrue"
	^ { VerificationMessageWarning createFor: aVerifiedObject 
			withVerification: self 
			withText: 'Element ' , aVerifiedObject name , ' has more than one non-abstract parent.' 
			documentationReference: '' }.
]
