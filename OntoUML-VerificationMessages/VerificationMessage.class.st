"
I represent negative verification result.

My responsibility is to store reference to verification, verified object, and text containing brief descritpion of the broken rule.

"
Class {
	#name : #VerificationMessage,
	#superclass : #Object,
	#instVars : [
		'objectReference',
		'verification',
		'messageText'
	],
	#category : #'OntoUML-VerificationMessages'
}

{ #category : #'instance creation' }
VerificationMessage class >> createFor: aObject withVerification: aVerification withText: aText [
	| message |
	message := self basicNew.
	message objectReference: aObject;
	verification: aVerification;
	messageText: aText.
	^ message.
]

{ #category : #'instance creation' }
VerificationMessage class >> new [
	^ self shouldNotImplement.
]

{ #category : #accessing }
VerificationMessage >> messageText [
	^ messageText.
]

{ #category : #accessing }
VerificationMessage >> messageText: aText [
	^ messageText := aText.
]

{ #category : #accessing }
VerificationMessage >> objectReference [
	^ objectReference.
]

{ #category : #accessing }
VerificationMessage >> objectReference: aObject [
	^ objectReference := aObject.
]

{ #category : #accessing }
VerificationMessage >> verification [
	^ verification.
]

{ #category : #accessing }
VerificationMessage >> verification: aVerificationReference [
	^ verification := aVerificationReference.
]
