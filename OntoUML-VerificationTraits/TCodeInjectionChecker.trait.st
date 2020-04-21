Trait {
	#name : #TCodeInjectionChecker,
	#category : #'OntoUML-VerificationTraits'
}

{ #category : #checking }
TCodeInjectionChecker classSide >> checkStringForCodeInjection: aString [
	(RBScanner isSelector: aString) ifFalse: [ ^ PossibleCodeInjection signal. ].
]
