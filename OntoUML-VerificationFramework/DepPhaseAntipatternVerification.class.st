"
I am verification for DepPhase anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for DepPhase anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionRefereceForDepPhase.
"
Class {
	#name : #DepPhaseAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
DepPhaseAntipatternVerification class >> abbreviation [
	^ 'DepPhase'.
]

{ #category : #constants }
DepPhaseAntipatternVerification class >> verifiedClass [
	^ OPUMLAssociation.
]

{ #category : #constants }
DepPhaseAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLMediation. }.
]

{ #category : #verification }
DepPhaseAntipatternVerification >> verifyObject: aVerifiedMediation withModel: aVerifiedModel [
	| phases source target |
	phases := Bag new.
	source := OntoUMLModelQuery getSourceFrom: aVerifiedMediation.
	target := OntoUMLModelQuery getTargetFrom: aVerifiedMediation.
	
	(OntoUMLModelQuery getStereotypeClass: source) = OntoUMLPhase ifTrue: [ phases add: source. ].
	(OntoUMLModelQuery getStereotypeClass: target) = OntoUMLPhase ifTrue: [ phases add: target. ].	
	phases size < 1 ifTrue: [ ^ {}. ]. 
	"else"
	^ phases collect: 
		[:phase |
				VerificationMessageWarning createFor: phase
					withVerification: self 
					withText: 'Phase ' , phase name , ' is part of Mediation association.' 
					documentationReference: OntoUMLDotOrgReferences getDefinitionRefereceForDepPhase. ].
]
