Class {
	#name : #HomoFuncAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
HomoFuncAntipatternVerification class >> verifiedClass [
	^ OPUMLAssociation.
]

{ #category : #constants }
HomoFuncAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLComponentOf. }.
]

{ #category : #testing }
HomoFuncAntipatternVerification >> getSortalDescendantsFor: aElement from: aModel [
	^ (OntoUMLModelQuery getDescendantsFor: aElement from: aModel)
	 		select: [ :descendant | (OntoUMLModelQuery getStereotype: descendant) oclIsKindOf: 'Sortal'. ].
]

{ #category : #testing }
HomoFuncAntipatternVerification >> hasKindAsAncestor: aElement [
	^ (OntoUMLModelQuery getAncestorsFor: aElement)
	 		anySatisfy:	[ :ancestor | 
				(self class getStereotype: ancestor) class = OntoUMLKind. ].
]

{ #category : #testing }
HomoFuncAntipatternVerification >> isFunctionalComplex: aElement in: aModel [
	| stereotype | 
	stereotype := (OntoUMLModelQuery getStereotype: aElement).
	"if aElement stereotype = kind -> return true"
	stereotype class = OntoUMLKind ifTrue: [ ^ true. ].
	"if aElement stereotype is either subkind, role or phase, and it has kind as direct or indirect parent -> return true"
	({ OntoUMLSubKind. OntoUMLRole. OntoUMLPhase. } includes: stereotype class)
		ifTrue: [ ^ self hasKindAsAncestor: aElement ].
	"if aElement stereotype is non-sortal and all its sortal children fullfil previous two conditions -> return true"
	^ ((stereotype oclIsKindOf: 'Sortal') not) 
		and: ((self getSortalDescendantsFor: aElement from: aModel) 
			allSatisfy: [ :child | self isFunctionalComplex: child in: aModel. ] ).
]

{ #category : #verification }
HomoFuncAntipatternVerification >> verifyObject: aVerifiedAssociation withModel: aVerifiedModel [
	| whole partEnd wholeAndChildren |
	whole :=	OntoUMLModelQuery getSourceFrom: aVerifiedAssociation.
	partEnd := OntoUMLModelQuery getTargetEndFrom: aVerifiedAssociation.	
	"lowerBound multiplicity for part must be >= 2"
	((partEnd lower = '*') or: (partEnd lower >= 2)) ifFalse: [ ^ {}. ].
	"whole has to be functional complex"
	(self isFunctionalComplex: whole in: aVerifiedModel) ifFalse: [ ^ {}. ].
	"whole cannot have any other direct or indirect componentOf connections"
	wholeAndChildren := OntoUMLModelQuery getDescendantsFor: whole from: aVerifiedModel.
	wholeAndChildren add: whole.
	((OntoUMLModelQuery getAssociationsFrom: aVerifiedModel  withStereotype: OntoUMLComponentOf)
			anySatisfy: [ :componentOf | (wholeAndChildren includes: componentOf memberEnds first type)
				 and: (componentOf memberEnds second type ~= partEnd type). ])
		ifTrue: [ ^ {}. ].
	"else"
	^ { VerificationMessageWarning 
			createFor: whole 
			withVerification: self 
			withText: 'Functional complex ' ,
				whole name,
				' is composed from single unique type of part.'
			documentationReference: ''. }.
]
