"
I represent negative verification result with severity ""Warning"".

At the moment I inherit all my variables and messages from my super class VerificationMessage.
"
Class {
	#name : #VerificationMessageWarning,
	#superclass : #VerificationMessage,
	#category : #'OntoUML-VerificationFramework-Messages'
}

{ #category : #accessing }
VerificationMessageWarning >> severity [
	^ 'Warning'
]
