Trait {
	#name : 'TClassUpdater',
	#category : 'OntoUML-VerificationFramework-Traits',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Traits'
}

{ #category : 'updating' }
TClassUpdater classSide >> updateMessage: aMessageCode withClassification: aClassification [
	self class compile: aMessageCode classified: aClassification.
]
