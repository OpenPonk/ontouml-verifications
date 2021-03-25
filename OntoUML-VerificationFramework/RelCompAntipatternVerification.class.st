Class {
	#name : #RelCompAntipatternVerification,
	#superclass : #Verification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
RelCompAntipatternVerification class >> verifiedClass [
	^ OPUMLAssociation.
]

{ #category : #verification }
RelCompAntipatternVerification >> checkBoundsFor: aEnd [
	| upper lower |
	upper := aEnd upperBound = '*' ifTrue: [ Float infinity. ] ifFalse: [ aEnd upperBound ].
	lower := aEnd lowerBound = '*' ifTrue: [ Float infinity. ] ifFalse: [ aEnd lowerBound ].
	^ (upper > 1) and: (lower > 0).
		
	
]

{ #category : #verification }
RelCompAntipatternVerification >> contains: aOriginSet ancestorOrSelfOf: aTarget [
	| ancestorSet |
	(aOriginSet includes: aTarget) ifTrue: [ ^ true ].
	ancestorSet := OntoUMLModelQuery getAncestorsFor: aTarget.
	^ aOriginSet anySatisfy: [ :origin | (ancestorSet includes: origin) ].
]

{ #category : #verification }
RelCompAntipatternVerification >> createWarningMessageFor: aVerifiedObject and: aAssociation [
	^ VerificationMessageWarning 
			createFor: aVerifiedObject 
			withVerification: self 
			withText: 'Association ' ,
				(OntoUMLModelQuery getAssociationName: aVerifiedObject) ,
				' is in RelComp anti-pattern with  ' ,
				(OntoUMLModelQuery getAssociationName: aAssociation)
			documentationReference: ''.
]

{ #category : #verification }
RelCompAntipatternVerification >> relCompExistsBetween: aAssociationA and: aAssociationB [
	| sourceA targetA sourceB targetB sourceAncestorsB targetAncestorsB |	
	aAssociationA = aAssociationB ifTrue: [ ^ false. ].	
	(self checkBoundsFor: (OntoUMLModelQuery getTargetEndFrom: aAssociationA)) ifFalse: [ ^ false. ].
	
	sourceA := OntoUMLModelQuery getSourceFrom: aAssociationA.
	targetA := OntoUMLModelQuery getTargetFrom: aAssociationA.
	sourceB := OntoUMLModelQuery getSourceFrom: aAssociationB.
	targetB := OntoUMLModelQuery getTargetFrom: aAssociationB.
	sourceAncestorsB := OntoUMLModelQuery getAncestorsFor: sourceB.
	sourceAncestorsB add: sourceB.	
	targetAncestorsB := OntoUMLModelQuery getAncestorsFor: targetB.
	targetAncestorsB add: targetB.
	
	^ ((sourceAncestorsB includes: targetA) and: (targetAncestorsB includes: targetA))
		or: ((sourceAncestorsB includes: sourceA) and: (targetAncestorsB includes: sourceA)).
]

{ #category : #verification }
RelCompAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	(aVerifiedModel select: [ :element | (element isKindOf: OPUMLAssociation) and: element ~= aVerifiedObject])
			do: [ :association |
				(self relCompExistsBetween: aVerifiedObject and: association )
				ifTrue: [ ^ {self createWarningMessageFor: aVerifiedObject and: association }. ]. ].
	"else"
	^ {}.
	
]
