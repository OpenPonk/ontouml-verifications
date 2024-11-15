"
I represent negative verification result with severity ""Error"".

At the moment I inherit all my variables and messages from my super class VerificationMessage.
"
Class {
	#name : 'VerificationMessageError',
	#superclass : 'VerificationMessage',
	#category : 'OpenPonk-OntoUML-Verifications-Messages',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Messages'
}

{ #category : 'accessing' }
VerificationMessageError >> severity [
	^ 'Error'
]
