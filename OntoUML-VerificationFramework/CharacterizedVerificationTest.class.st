"
I represent tests for CharacterizedVerification.
"
Class {
	#name : #CharacterizedVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Verification-Tests'
}

{ #category : #constants }
CharacterizedVerificationTest >> getTestedClass [
	^ CharacterizedVerification.
]

{ #category : #constants }
CharacterizedVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
CharacterizedVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLMode. OntoUMLQuality. }.
]

{ #category : #tests }
CharacterizedVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
CharacterizedVerificationTest >> testInvalidModel [
	| quality kind model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	quality := OPUMLClass new.
	quality applyStereotype: OntoUMLQuality new.
	model := { kind. quality. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: quality withModel: model).
	self assert: result results size equals: 1.
]

{ #category : #tests }
CharacterizedVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
CharacterizedVerificationTest >> testValidModel [
	| quality association kind model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	quality := OPUMLClass new.
	quality applyStereotype: OntoUMLQuality new.
	association := self createAssociationFrom: kind to: quality.
	association applyStereotype: OntoUMLCharacterization new.
	model := { kind. quality. association. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: quality withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifyMultiplicityForCharacterization [
	| kind mode characterization |
	kind := (OPUMLClass new) applyStereotype: OntoUMLKind new.
	mode := (OPUMLClass new) applyStereotype: OntoUMLMode new.
	characterization := self createAssociationFrom: kind to: mode.
	self assert: (self getTestedClass basicNew verifyMultiplicity: mode forCharacterization: characterization) isEmpty equals: true.
	(characterization memberEnds at:1) lowerValue value: 0.
	self assert: (self getTestedClass basicNew verifyMultiplicity: mode forCharacterization: characterization) isEmpty equals: false.
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
