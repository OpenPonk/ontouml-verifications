Class {
	#name : #Verification,
	#superclass : #Object,
	#traits : 'TProfileGatherer',
	#classTraits : 'TProfileGatherer classTrait',
	#category : #'OntoUML-Verifications'
}

{ #category : #'instance creation' }
Verification class >> canVerify: arg1 [
	^ arg1 class = self verifiedClass
]

{ #category : #'instance creation' }
Verification class >> new [
	^ self shouldNotImplement
]

{ #category : #constants }
Verification class >> verifiedClass [
	^ nil
]

{ #category : #'instance creation' }
Verification class >> verify: arg1 withModel: arg2 [
	| tmp1 |
	(self canVerify: arg1)
		ifFalse: [ ^ {} ].
	tmp1 := self basicNew.
	^ tmp1 verifyObject: arg1 withModel: arg2
]

{ #category : #verification }
Verification >> verifyObject: arg1 withModel: arg2 [
	self subclassResponsibility
]
