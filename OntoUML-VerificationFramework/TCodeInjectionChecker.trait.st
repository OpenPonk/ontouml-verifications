Trait {
	#name : 'TCodeInjectionChecker',
	#category : 'OntoUML-VerificationFramework-Traits',
	#package : 'OntoUML-VerificationFramework',
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
