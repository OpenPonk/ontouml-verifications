"
I represent collection of verification results.

My responsibility is to store those results and allow other elements to queue for results of those elements.
"
Class {
	#name : 'VerificationResults',
	#superclass : 'Object',
	#instVars : [
		'results'
	],
	#category : 'OntoUML-VerificationFramework-Results',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Results'
}

{ #category : 'adding' }
VerificationResults >> addResult: aVerificationMessage [
	results add: aVerificationMessage.
]

{ #category : 'adding' }
VerificationResults >> addResults: aVerificationMessageCollection [
	results addAll: aVerificationMessageCollection.
]

{ #category : 'testing' }
VerificationResults >> hasErrors: aVerifiedObject [
	^ self selectErrors anySatisfy: [ :verificationMessage | verificationMessage objectReference = aVerifiedObject ].
]

{ #category : 'testing' }
VerificationResults >> hasWarnings: aVerifiedObject [
	^ self selectWarnings anySatisfy: [ :verificationMessage | verificationMessage objectReference = aVerifiedObject ].
]

{ #category : 'initialization' }
VerificationResults >> initialize [
	super initialize.
	results := Set new.
]

{ #category : 'accessing' }
VerificationResults >> results [
	^ results.
]

{ #category : 'testing' }
VerificationResults >> selectErrors [
	^ results select: [ :verificationMessage | verificationMessage class = VerificationMessageError ].
]

{ #category : 'testing' }
VerificationResults >> selectWarnings [
	^ results select: [ :verificationMessage | verificationMessage class = VerificationMessageWarning ].
]
