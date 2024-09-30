"
I am verification for RelSpecs anti-pattern. 

Overriden methods: verifiedClass, verifyObject:withModel:

Documentation for RelSpecs anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForRelSpecs.
"
Class {
	#name : 'RelSpecAntipatternVerification',
	#superclass : 'Verification',
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : 'OntoUML-VerificationFramework-Antipattern-Classes',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Antipattern-Classes'
}

{ #category : 'checking' }
RelSpecAntipatternVerification class >> abbreviation [
	^ 'RelSpec'.
]

{ #category : 'checking' }
RelSpecAntipatternVerification class >> verifiedClass [
	^ OPUMLAssociation .
]

{ #category : 'testing' }
RelSpecAntipatternVerification >> contains: aOriginSet ancestorOrSelfOf: aTarget [
	| ancestorSet |
	(aOriginSet includes: aTarget) ifTrue: [ ^ true ].
	ancestorSet := OntoUMLModelQuery getAncestorsFor: aTarget.
	^ aOriginSet anySatisfy: [ :origin | (ancestorSet includes: origin) ].
]

{ #category : 'verification' }
RelSpecAntipatternVerification >> createWarningMessageFor: aVerifiedObject and: aAssociation [
	^ VerificationMessageWarning 
			createFor: aVerifiedObject 
			withVerification: self 
			withText: 'Association ' ,
				(OntoUMLModelQuery getAssociationName: aVerifiedObject) ,
				' is in RelSpecs anti-pattern with  ' ,
				(OntoUMLModelQuery getAssociationName: aAssociation)
			documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForRelSpec.
]

{ #category : 'verification' }
RelSpecAntipatternVerification >> relSpecsExistsBetween: aAssociationA and: aAssociationB [
	| sourceA targetA sourceB targetB sourceAncestorsB targetAncestorsB |
	sourceA := OntoUMLModelQuery getSourceFrom: aAssociationA.
	targetA := OntoUMLModelQuery getTargetFrom: aAssociationA.
	sourceB := OntoUMLModelQuery getSourceFrom: aAssociationB.
	targetB := OntoUMLModelQuery getTargetFrom: aAssociationB.
	sourceAncestorsB := OntoUMLModelQuery getAncestorsFor: sourceB.
	sourceAncestorsB add: sourceB.	
	targetAncestorsB := OntoUMLModelQuery getAncestorsFor: targetB.
	targetAncestorsB add: targetB.	
	
	^ ((sourceAncestorsB includes: sourceA) and: (targetAncestorsB includes: targetA))
		or: ((sourceAncestorsB includes: targetA) and: (targetAncestorsB includes: sourceA)).
]

{ #category : 'verification' }
RelSpecAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	(aVerifiedModel select: [ :element | (element isKindOf: OPUMLAssociation) and: element ~= aVerifiedObject])
			do: [ :association |
				(self relSpecsExistsBetween: aVerifiedObject and: association )
				ifTrue: [ ^ {self createWarningMessageFor: aVerifiedObject and: association }. ]. ].
	"else"
	^ {}.
	
]
