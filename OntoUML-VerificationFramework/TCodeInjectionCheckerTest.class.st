Class {
	#name : 'TCodeInjectionCheckerTest',
	#superclass : 'TestCase',
	#category : 'OntoUML-VerificationFramework-Traits',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Traits'
}

{ #category : 'tests' }
TCodeInjectionCheckerTest >> testCheckStringForCodeInjection [
	self shouldnt: [ TCodeInjectionChecker checkStringForCodeInjection: 'TestCode' ] raise: PossibleCodeInjection. 
	self should: [ TCodeInjectionChecker checkStringForCodeInjection: '. self shouldNotImplement.' ] raise: PossibleCodeInjection. 
]

{ #category : 'tests' }
TCodeInjectionCheckerTest >> testCheckUrlForCodeInjection [
	self shouldnt: [ TCodeInjectionChecker checkUrlForCodeInjection: 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/mixin/index.html' ] raise: PossibleCodeInjection. 
	self should: [ TCodeInjectionChecker checkUrlForCodeInjection: '''. self shouldNotImplement.' ] raise: PossibleCodeInjection. 
]
