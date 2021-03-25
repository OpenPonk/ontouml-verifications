"
I am (abstract) verification. All other verifications should be my subclasses.
"
Class {
	#name : #Verification,
	#superclass : #Object,
	#traits : 'TProfileGatherer',
	#classTraits : 'TProfileGatherer classTrait',
	#category : #'OntoUML-VerificationFramework-Verification-Classes'
}

{ #category : #'instance creation' }
Verification class >> canVerify: aVerifiedObject [
	^ aVerifiedObject class = self verifiedClass.
]

{ #category : #updating }
Verification class >> expandAllowedClassStereotypesIn: aCollection from: aUpdater [
	 aCollection isString ifTrue: [ ^ self expandClassStereotype: aCollection fromUpdater: aUpdater. ]
			ifFalse: [ ^ (aCollection collect: [ :item | self expandClassStereotype: item fromUpdater: aUpdater ]) flattened asSet. ].
]

{ #category : #updating }
Verification class >> expandClassStereotype: aString fromUpdater: aUpdater [
	(aString = '*' or: aString = 'Functional complex') ifTrue: [ ^ aUpdater classSpecifications collect: [ :spec | spec name ] ]
		ifFalse: [ ^ { aString. }. ]. 
]

{ #category : #'instance creation' }
Verification class >> new [
	^ self shouldNotImplement.
]

{ #category : #updating }
Verification class >> updateFrom: aVerificationUpdater [

]

{ #category : #constants }
Verification class >> verifiedClass [
	^ nil.
]

{ #category : #'instance creation' }
Verification class >> verify: aVerifiedObject withModel: aVerifiedModel [
	| verification |
	(self canVerify: aVerifiedObject) ifFalse: [ ^ {} ].
	verification := self basicNew.
	^ verification verifyObject: aVerifiedObject withModel: aVerifiedModel.
]

{ #category : #verification }
Verification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	self subclassResponsibility.
]
