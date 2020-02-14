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
VerificationMessage class >> createFor: arg1 withVerification: arg2 withText: arg3 [
	| tmp1 |
	tmp1 := self basicNew.
	tmp1
		objectReference: arg1;
		verification: arg2;
		messageText: arg3.
	^ tmp1
]

{ #category : #'instance creation' }
VerificationMessage class >> new [
	^ self shouldNotImplement
]

{ #category : #accessing }
VerificationMessage >> messageText [
	^ messageText
]

{ #category : #accessing }
VerificationMessage >> messageText: arg1 [
	^ messageText := arg1
]

{ #category : #accessing }
VerificationMessage >> objectReference [
	^ objectReference
]

{ #category : #accessing }
VerificationMessage >> objectReference: arg1 [
	^ objectReference := arg1
]

{ #category : #accessing }
VerificationMessage >> verification [
	^ verification
]

{ #category : #accessing }
VerificationMessage >> verification: arg1 [
	^ verification := arg1
]
