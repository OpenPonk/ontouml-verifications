Trait {
	#name : #TProfileGatherer,
	#category : #'OntoUML-VerificationTraits'
}

{ #category : #utilities }
TProfileGatherer classSide >> getAssociation: arg1 [
	^ arg1 base_Association
]

{ #category : #utilities }
TProfileGatherer classSide >> getElement: arg1 [
	^ arg1 base_Class
]

{ #category : #utilities }
TProfileGatherer classSide >> getStereotype: arg1 [
	| tmp1 |
	tmp1 := arg1 appliedStereotypes
		select: [ :arg2 | arg2 isKindOf: OntoUMLElement ].
	tmp1 isEmpty
		ifTrue: [ ^ nil ].
	^ tmp1 at: 1
]
