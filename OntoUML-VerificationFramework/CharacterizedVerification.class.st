"
I am verification for Characterized rule. 

Overriden methods: verifiedClass, verifyObject:withModel:, verifiedStereotypes.

New methods: verifyMultiplicity:forCharacterization:.
"
Class {
	#name : #CharacterizedVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-VerificationFramework-Verification-Classes'
}

{ #category : #constants }
CharacterizedVerification class >> abbreviation [
	^ 'Characterized'.
]

{ #category : #constants }
CharacterizedVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
CharacterizedVerification class >> verifiedStereotypes [
	^ { OntoUMLMode. OntoUMLQuality. }.
]

{ #category : #verification }
CharacterizedVerification >> verifyMultiplicity: aVerifiedObject forCharacterization: aCharacterization [
	| multiplicity |
	multiplicity := (aCharacterization memberEnds reject: [ :characterizationProperty | (characterizationProperty type = aVerifiedObject) ]) at: 1.
	(multiplicity lower = 1 and: multiplicity upper = 1) ifFalse: [ ^ {VerificationMessageError createFor: aVerifiedObject withVerification: self 
		withText: (self class getStereotype: aVerifiedObject) class name  , ' characterization is invalid because other end of characteristion does not have multiplicity set to 1.' }].
	^ {}.
]

{ #category : #verification }
CharacterizedVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
 	| characterizations |
	characterizations := (aVerifiedModel select: [ :element | element isKindOf: OPUMLAssociation ])		
		select: [ :association | (self class getStereotype: association) class = OntoUMLCharacterization and: (association memberEnds anySatisfy: [ :property | property type = aVerifiedObject ]) ].
	characterizations size < 1 ifTrue: [ ^ {VerificationMessageError createFor: aVerifiedObject withVerification: self withText: (self class getStereotype: aVerifiedObject) class name , ' has to have at least one characterization.'} ].
	^ characterizations flatCollect: [ :characterization | self verifyMultiplicity: aVerifiedObject forCharacterization: characterization ].
	
]
