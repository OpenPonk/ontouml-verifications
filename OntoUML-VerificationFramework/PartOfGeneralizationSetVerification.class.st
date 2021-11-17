"
I am verification for PartOfGeneralizationSet rule. 

Overriden methods: verifiedClass, verifyObject:withModel:, verifiedStereotypes.
"
Class {
	#name : #PartOfGeneralizationSetVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-VerificationFramework-Verification-Classes'
}

{ #category : #constants }
PartOfGeneralizationSetVerification class >> abbreviation [
	^ 'PartOfGenSet'.
]

{ #category : #constants }
PartOfGeneralizationSetVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
PartOfGeneralizationSetVerification class >> verifiedStereotypes [
	^ { OntoUMLPhase.}.
]

{ #category : #verification }
PartOfGeneralizationSetVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| generalizationSets |
	generalizationSets := aVerifiedObject generalizations flatCollect: [ :generalization | generalization generalizationSets ].	
	generalizationSets ifEmpty: [ ^ {VerificationMessageError createFor: aVerifiedObject withVerification: self withText:
		(self class getStereotype: aVerifiedObject) class name , ' has to be part of one or more generalisation sets that are disjoint and complete.'} ].
	((generalizationSets collect: [ :generalizationSet | generalizationSet isDisjoint and: generalizationSet isCovering ]) anySatisfy: [ :result | result not ])
		ifTrue: [ ^ { VerificationMessageError createFor: aVerifiedObject withVerification: self withText:
			(self class getStereotype: aVerifiedObject) class name , ' is part of one or more generalisation sets that are not disjoint or not complete.'} ].
	^ {}.
]
