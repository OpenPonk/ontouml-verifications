Class {
	#name : #VerificationResults,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#category : #'OntoUML-VerificationResults'
}

{ #category : #adding }
VerificationResults >> addResult: arg1 [
	results add: arg1
]

{ #category : #adding }
VerificationResults >> addResults: arg1 [
	results addAll: arg1
]

{ #category : #testing }
VerificationResults >> hasErrors: arg1 [
	^ self selectErrors
		anySatisfy: [ :arg2 | arg2 objectReference = arg1 ]
]

{ #category : #testing }
VerificationResults >> hasWarnings: arg1 [
	^ self selectWarnings
		anySatisfy: [ :arg2 | arg2 objectReference = arg1 ]
]

{ #category : #initialization }
VerificationResults >> initialize [
	super initialize.
	results := Set new
]

{ #category : #accessing }
VerificationResults >> results [
	^ results
]

{ #category : #testing }
VerificationResults >> selectErrors [
	^ results select: [ :arg1 | arg1 class = VerificationMessageError ]
]

{ #category : #testing }
VerificationResults >> selectWarnings [
	^ results select: [ :arg1 | arg1 class = VerificationMessageWarning ]
]
