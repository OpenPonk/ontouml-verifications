Trait {
	#name : #TClassUpdater,
	#category : #'OntoUML-VerificationFramework-Traits'
}

{ #category : #updating }
TClassUpdater classSide >> updateMessage: aMessageCode withClassification: aClassification [
	self class compile: aMessageCode classified: aClassification.
]
