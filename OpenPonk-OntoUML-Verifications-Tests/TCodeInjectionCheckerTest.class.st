"
Tests security sanitization and expression validation performed by the TCodeInjectionChecker trait.
"
Class {
	#name : 'TCodeInjectionCheckerTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Traits',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Traits'
}

{ #category : 'tests' }
TCodeInjectionCheckerTest >> testCheckStringForCodeInjection [

	self assert: (TCodeInjectionChecker checkStringForCodeInjection: 'TestCode') identicalTo: TCodeInjectionChecker.
	self should: [ TCodeInjectionChecker checkStringForCodeInjection: '. self shouldNotImplement.' ] raise: PossibleCodeInjection
]

{ #category : 'tests' }
TCodeInjectionCheckerTest >> testCheckUrlForCodeInjection [

	self
		assert:
		(TCodeInjectionChecker checkUrlForCodeInjection: 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/mixin/index.html')
		identicalTo: TCodeInjectionChecker.
	self should: [ TCodeInjectionChecker checkUrlForCodeInjection: '''. self shouldNotImplement.' ] raise: PossibleCodeInjection
]
