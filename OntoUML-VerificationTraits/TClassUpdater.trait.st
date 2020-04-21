Trait {
	#name : #TClassUpdater,
	#category : #'OntoUML-VerificationTraits'
}

{ #category : #updating }
TClassUpdater classSide >> updateMessage: aMessageCode withClassification: aClassification [
	self class compile: aMessageCode classified: aClassification.
]
