"
I am verification for HetColl anti-pattern. 

Overriden methods: verifiedClass, verifiedSterotypes, verifyObject:withModel:

Documentation for HetColl anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForHetColl.
"
Class {
	#name : #HetCollAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #updating }
HetCollAntipatternVerification class >> abbreviation [
	^ 'HetColl'.
]

{ #category : #constants }
HetCollAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
HetCollAntipatternVerification class >> verifiedStereotypes [
	^ {OntoUMLCollective. OntoUMLSubKind. OntoUMLRole. OntoUMLPhase. OntoUMLMixin. OntoUMLRoleMixin. OntoUMLPhaseMixin. OntoUMLCategory.}.
]

{ #category : #verification }
HetCollAntipatternVerification >> isApplicableFor: aElement in: aModel [
	| ancestors stereotype | 
	stereotype := OntoUMLModelQuery getStereotypeClass: aElement.
	stereotype = OntoUMLCollective ifTrue: [^true].
	ancestors := OntoUMLModelQuery getAncestorsFor: aElement.
	({ OntoUMLRole. OntoUMLPhase. OntoUMLSubKind. } includes: stereotype) ifTrue: 
		[ (ancestors anySatisfy: [ :ancestor | 
			(OntoUMLModelQuery getStereotypeClass: ancestor) = OntoUMLCollective. ]) ifTrue: [ ^true ]. ].
	({ OntoUMLRoleMixin. OntoUMLMixin. OntoUMLCategory. OntoUMLPhaseMixin. } includes: stereotype) ifTrue: 
		[ ^ ((OntoUMLModelQuery getChildrenOf: aElement from: aModel) select: [ :child |
			 OntoUMLModelQuery isStereotypeOf: child oclKindOf: 'Sortal' ]) 
				allSatisfy: [:child | self isApplicableFor: child in: aModel]. ].
	^false.
]

{ #category : #verification }
HetCollAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| parts ancestorsAndSelf |
	(self isApplicableFor: aVerifiedObject in: aVerifiedModel) ifFalse:[ ^{}. ].
	
	ancestorsAndSelf := OntoUMLModelQuery getAncestorsFor: aVerifiedObject.
	ancestorsAndSelf add: aVerifiedObject.
	
	parts := OntoUMLModelQuery getAssociationsFrom: aVerifiedModel
		withStereotype: OntoUMLMemberOf 
		filterBy: [ :memberOf | ancestorsAndSelf includes: (memberOf memberEnds second type). ].
		
	parts size > 1 ifTrue: [ 
		^ {VerificationMessageWarning createFor: aVerifiedObject 
			withVerification: self 
			withText: 'Collective ' , aVerifiedObject name , ' contains multiple different parts.'
			documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForHetColl. } ].
	^{}.
]
