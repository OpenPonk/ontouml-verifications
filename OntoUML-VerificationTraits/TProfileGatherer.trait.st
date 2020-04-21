Trait {
	#name : #TProfileGatherer,
	#category : #'OntoUML-VerificationTraits'
}

{ #category : #utilities }
TProfileGatherer classSide >> getAssociation: aStereotype [
	^ aStereotype base_Association.
]

{ #category : #utilities }
TProfileGatherer classSide >> getElement: aStereotype [
	^ aStereotype base_Class.
]

{ #category : #utilities }
TProfileGatherer classSide >> getStereotype: aElement [
	| stereotypes |
	stereotypes := aElement appliedStereotypes select: [ :stereotype | stereotype isKindOf: OntoUMLElement ].
	stereotypes isEmpty ifTrue: [ ^ nil ] ifFalse: [ ^ stereotypes at: 1 ].
]
