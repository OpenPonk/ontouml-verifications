"
I am verification for GSRig anti-pattern. 

Overriden methods: verifiedClass, verifyObject:withModel:

Documentation for GSRig anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionRefereceForGSRig.
"
Class {
	#name : #GSRigAntipatternVerification,
	#superclass : #Verification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
GSRigAntipatternVerification class >> getAntiRigidTypes [
	^ { OntoUMLRole. OntoUMLRoleMixin. OntoUMLPhase. OntoUMLPhaseMixin. }.
]

{ #category : #constants }
GSRigAntipatternVerification class >> getRigidTypes [
	^ {  OntoUMLKind. OntoUMLSubKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLRelator. OntoUMLMode. OntoUMLQuality. OntoUMLCategory. }.
]

{ #category : #constants }
GSRigAntipatternVerification class >> verifiedClass [
	^ OPUMLGeneralizationSet.
]

{ #category : #verification }
GSRigAntipatternVerification >> createWarningMessagesFor: aGenSet [
	^ aGenSet generalizations collect: [ :generalization | VerificationMessageWarning 
			createFor: generalization 
			withVerification: self 
			withText: 'Generalization set ', aGenSet name,
				' contains rigid subtype that has both rigid and anti-rigid subtype.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionRefereceForGSRig. ]
]

{ #category : #verification }
GSRigAntipatternVerification >> includesAntiRigidSubtype: aVerifiedGeneralizationSet [
	^ (aVerifiedGeneralizationSet generalizations anySatisfy: 
		[ :generalization | self class getAntiRigidTypes includes: 
			(OntoUMLModelQuery getStereotypeClass: generalization specific). ]).
	
]

{ #category : #verification }
GSRigAntipatternVerification >> includesRigidSubtype: aVerifiedGeneralizationSet [
	^ (aVerifiedGeneralizationSet generalizations anySatisfy: 
		[ :generalization | self class getRigidTypes includes: 
			(OntoUMLModelQuery getStereotypeClass: generalization specific). ]).
	
]

{ #category : #verification }
GSRigAntipatternVerification >> isSupertypeRigid: aVerifiedGeneralizationSet [
	^ (aVerifiedGeneralizationSet generalizations allSatisfy: 
		[ :generalization | self class getRigidTypes includes: 
			(OntoUMLModelQuery getStereotypeClass: generalization general). ]).
	
]

{ #category : #verification }
GSRigAntipatternVerification >> verifyObject: aVerifiedGeneralizationSet withModel: aVerifiedModel [
	((self isSupertypeRigid: aVerifiedGeneralizationSet) and: 
		((self includesRigidSubtype: aVerifiedGeneralizationSet) 
			and: (self includesAntiRigidSubtype: aVerifiedGeneralizationSet)))
		ifFalse: [ ^ {}. ]
		ifTrue: [ ^ self createWarningMessagesFor: aVerifiedGeneralizationSet. ].
]
