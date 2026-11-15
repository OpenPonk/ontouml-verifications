"
I represent tests for CharacterizedVerification.
"
Class {
	#name : 'CharacterizedVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
CharacterizedVerificationTest >> getTestedClass [
	^ CharacterizedVerification.
]

{ #category : 'constants' }
CharacterizedVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
CharacterizedVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLMode. OntoUMLQuality. }.
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testInvalidModel [

	| quality kind model result message |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	quality := OPUMLClass new.
	quality applyStereotype: OntoUMLQuality new.
	model := {
		         kind.
		         quality }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: quality withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageError.
	self assert: message objectReference identicalTo: quality.
	self assert: message verification class identicalTo: CharacterizedVerification.
	self assert: message messageText equals: 'OntoUMLQuality has to have at least one characterization.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/classes/aspects/quality/index.html'
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testValidModel [

	| quality association kind model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	quality := OPUMLClass new.
	quality applyStereotype: OntoUMLQuality new.
	association := self createAssociationFrom: kind to: quality.
	association applyStereotype: OntoUMLCharacterization new.
	model := {
		         kind.
		         quality.
		         association }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: quality withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testVerifyMultiplicityForCharacterization [

	| kind mode characterization invalidMessages message |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	mode := OPUMLClass new applyStereotype: OntoUMLMode new.
	characterization := self createAssociationFrom: kind to: mode.
	self assertEmpty: (self getTestedClass basicNew verifyMultiplicity: mode forCharacterization: characterization).
	characterization memberEnds first lowerValue value: 0.
	invalidMessages := self getTestedClass basicNew verifyMultiplicity: mode forCharacterization: characterization.
	self assert: invalidMessages size equals: 1.
	message := invalidMessages anyOne.
	self assert: message class identicalTo: VerificationMessageError.
	self assert: message objectReference identicalTo: mode.
	self assert: message verification class identicalTo: CharacterizedVerification.
	self
		assert: message messageText
		equals: 'OntoUMLMode characterization is invalid because other end of characteristion does not have multiplicity set to 1.'
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : 'tests' }
CharacterizedVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
