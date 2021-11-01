"
I am verification for DecInt anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for DecInt anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForDecInt.
"
Class {
	#name : #DecIntAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
DecIntAntipatternVerification class >> abbreviation [
	^ 'DecInt'.
]

{ #category : #constants }
DecIntAntipatternVerification class >> allowedSupertypes [
	^ { OntoUMLMixin. OntoUMLRoleMixin. OntoUMLCategory. OntoUMLPhaseMixin. }
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
DecIntAntipatternVerification >> getConcreteParentsFor: aVerifiedObject from: aVerifiedModel [
	| suspiciousParents |
	suspiciousParents :=  (OntoUMLModelQuery getParentsOf: aVerifiedObject)
				reject: [ :element |
					 self class allowedSupertypes includes: (OntoUMLModelQuery getStereotypeClass: element) ].
	^ suspiciousParents reject: [ :parent |
		(OntoUMLModelQuery getGeneralizationsFrom: aVerifiedModel
			filterBy: [ :generalization | generalization general = parent ])
				anySatisfy: [ :generalization | generalization generalizationSets anySatisfy: 
					[ :genSet | (genSet isCovering) ]. ]. ].
]

{ #category : #verification }
DecIntAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| supertypes |
	supertypes := self getConcreteParentsFor: aVerifiedObject from: aVerifiedModel .
	supertypes size > 1 ifFalse: [ ^ {}. ].
	"ifTrue"
	^ { VerificationMessageWarning createFor: aVerifiedObject 
			withVerification: self 
			withText: 'Element ' , aVerifiedObject name , ' has more than one non-abstract parent.' 
			documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForDecInt. }.
]
