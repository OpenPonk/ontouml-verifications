"
I am verification for MixRig anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for MixRig anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionRefereceForMixRig.
"
Class {
	#name : #MixRigAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
MixRigAntipatternVerification class >> abbreviation [
	^ 'MixRig'.
]

{ #category : #constants }
MixRigAntipatternVerification class >> getAntiRigidTypes [
	^ { OntoUMLRole. OntoUMLRoleMixin. OntoUMLPhase. OntoUMLPhaseMixin. }.
]

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
MixRigAntipatternVerification >> getDescendansOfMixin: aMixin withModel: aModel into: aCollection [
	| subtypes mixins |
	subtypes := (OntoUMLModelQuery getChildrenOf: aMixin from: aModel) asSet.
	mixins := subtypes select: [ :subtype | (OntoUMLModelQuery getStereotypeClass: subtype) = OntoUMLMixin. ].
	mixins := mixins reject: [ :mixin | aCollection includes: mixin ].
	aCollection addAll: subtypes.
	mixins do: [ :mixin | self getDescendansOfMixin: mixin withModel: aModel into: aCollection ].
]

{ #category : #verification }
MixRigAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| subtypes hasRigidSubtypes hasAntiRigidSubtypes |
	subtypes := OntoUMLModelQuery getChildrenOf: aVerifiedObject from: aVerifiedModel.
	(subtypes select: [ :subtype |
		 (OntoUMLModelQuery getStereotypeClass: subtype) = OntoUMLMixin. ]) do:
		[ :mixin | self getDescendansOfMixin: mixin withModel: aVerifiedModel into: subtypes ].
	hasRigidSubtypes := subtypes anySatisfy: [ :element |
		self class getRigidTypes includes: (OntoUMLModelQuery getStereotypeClass: element) ].
	hasAntiRigidSubtypes := subtypes anySatisfy: [ :element |
		self class getAntiRigidTypes includes: (OntoUMLModelQuery getStereotypeClass: element) ].
	((subtypes asSet size = 1) or: (hasRigidSubtypes and: hasAntiRigidSubtypes) not) ifTrue: 
		[ ^ { VerificationMessageWarning createFor: aVerifiedObject 
				withVerification: self 
				withText: 'All subtypes of Mixin ' , aVerifiedObject name , ' have same rigidity.'
				documentationReference: OntoUMLDotOrgReferences getDefinitionRefereceForMixRig. }. ].
	"else" ^{}.
]
