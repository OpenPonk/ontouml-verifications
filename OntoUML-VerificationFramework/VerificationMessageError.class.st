"
I represent negative verification result with severity ""Error"".

At the moment I inherit all my variables and messages from my super class VerificationMessage.
"
Class {
	#name : #VerificationMessageError,
	#superclass : #VerificationMessage,
	#category : #'OntoUML-VerificationFramework-Messages'
}

{ #category : #accessing }
VerificationMessageError >> severity [
	^ 'Error'
]
