Trait {
	#name : 'TClassUpdater',
	#category : 'OpenPonk-OntoUML-Verifications-Traits',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Traits'
}

{ #category : 'updating' }
TClassUpdater classSide >> updateMessage: aMessageCode withClassification: aClassification [
	self class compile: aMessageCode classified: aClassification.
]
