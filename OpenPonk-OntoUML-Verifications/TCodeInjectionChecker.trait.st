Trait {
	#name : 'TCodeInjectionChecker',
	#category : 'OpenPonk-OntoUML-Verifications-Traits',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Traits'
}

{ #category : 'checking' }
TCodeInjectionChecker classSide >> checkStringForCodeInjection: aString [
	(RBScanner isSelector: aString) ifFalse: [ ^ PossibleCodeInjection signal. ].
]

{ #category : 'checking' }
TCodeInjectionChecker classSide >> checkUrlForCodeInjection: aUrlString [
	((aUrlString findString: '''' ) = 0) ifFalse: [ ^ PossibleCodeInjection signal. ].
]
