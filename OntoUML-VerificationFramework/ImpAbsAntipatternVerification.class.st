"
I am verification for ImpAbs anti-pattern. 

Overriden methods: verifiedClass, verifyObject:withModel:

Documentation for ImpAbs anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForImpAbs.
"
Class {
	#name : 'ImpAbsAntipatternVerification',
	#superclass : 'Verification',
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : 'OntoUML-VerificationFramework-Antipattern-Classes',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
ImpAbsAntipatternVerification class >> abbreviation [
	^ 'ImpAbs'.
]

{ #category : 'constants' }
ImpAbsAntipatternVerification class >> verifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'verification' }
ImpAbsAntipatternVerification >> checkNumberOfChildrenFor: aElementEnd from: aModel [
 	^ (OntoUMLModelQuery getChildrenOf: aElementEnd type from: aModel) size >= 2.
]

{ #category : 'verification' }
ImpAbsAntipatternVerification >> checkUpperMultiplicityFor: aEnd [
	^ aEnd upperBound = '*' ifTrue: [ ^ true. ] ifFalse: [ ^ aEnd upperBound >= 2 ].
]

{ #category : 'verification' }
ImpAbsAntipatternVerification >> verifyObject: aVerifiedAssociation withModel: aVerifiedModel [
	| sourceEnd targetEnd |
	sourceEnd := OntoUMLModelQuery getSourceEndFrom: aVerifiedAssociation.
	targetEnd := OntoUMLModelQuery getTargetEndFrom: aVerifiedAssociation.
	(((self checkUpperMultiplicityFor: sourceEnd) and: (self checkNumberOfChildrenFor: sourceEnd from: aVerifiedModel))
		or: ((self checkUpperMultiplicityFor: targetEnd) and: (self checkNumberOfChildrenFor: targetEnd from: aVerifiedModel)))
			ifFalse: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning
		createFor: aVerifiedAssociation
		withVerification: self
		withText: 'Association ' , (OntoUMLModelQuery getAssociationName: aVerifiedAssociation) , 
		' is connected to element that has multiple subtypes and upper bound for its multiplicity is >= 2.'
		documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForImpAbs. }.
]
