Class {
	#name : #TCodeInjectionCheckerTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationTraits'
}

{ #category : #tests }
TCodeInjectionCheckerTest >> testCheckStringForCodeInjection [
	self shouldnt: [ TCodeInjectionChecker checkStringForCodeInjection: 'TestCode' ] raise: PossibleCodeInjection. 
	self should: [ TCodeInjectionChecker checkStringForCodeInjection: '. self shouldNotImplement.' ] raise: PossibleCodeInjection. 
]
