"
I represent tests for PartOfGeneralizationSetVerification.
"
Class {
	#name : 'PartOfGeneralizationSetVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
PartOfGeneralizationSetVerificationTest >> getTestedClass [
	^ PartOfGeneralizationSetVerification.
]

{ #category : 'constants' }
PartOfGeneralizationSetVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
PartOfGeneralizationSetVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLPhase.}.
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testInvalidModel [

	| phase model result message |
	phase := OPUMLClass new.
	phase applyStereotype: OntoUMLPhase new.
	model := { phase }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: phase withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageError.
	self assert: message objectReference identicalTo: phase.
	self assert: message verification class identicalTo: PartOfGeneralizationSetVerification.
	self
		assert: message messageText
		equals: 'OntoUMLPhase has to be part of one or more generalisation sets that are disjoint and complete.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/classes/sortals/phase/index.html'
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testInvalidModelWithNonDisjointOrIncompleteGeneralizationSet [

	| kind phase generalization generalizationSet model result message |
	phase := self createClass: 'Child' withStereotype: OntoUMLPhase.
	kind := self createClass: 'Person' withStereotype: OntoUMLKind.
	generalization := self createGeneralizationFor: kind withSpecific: phase.
	generalizationSet := OPUMLGeneralizationSet new
		                     generalizations: { generalization };
		                     isDisjoint: false;
		                     isCovering: true;
		                     yourself.
	generalization generalizationSets: { generalizationSet }.
	model := {
		         kind.
		         phase.
		         generalization.
		         generalizationSet }.
	result := VerificationResults new.
	result addResults: (PartOfGeneralizationSetVerification verify: phase withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageError.
	self assert: message objectReference identicalTo: phase.
	self assert: message verification class identicalTo: PartOfGeneralizationSetVerification.
	self
		assert: message messageText
		equals: 'OntoUMLPhase is part of one or more generalisation sets that are not disjoint or not complete.'.
	generalizationSet
		isDisjoint: true;
		isCovering: false.
	self assert: (PartOfGeneralizationSetVerification verify: phase withModel: model) size equals: 1
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testValidModel [

	| kind phase generalization generalizationSet model result |
	phase := OPUMLClass new.
	phase applyStereotype: OntoUMLPhase new.
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	generalization := OPUMLGeneralization new.
	generalization general: kind.
	generalization specific: phase.
	generalizationSet := OPUMLGeneralizationSet new.
	generalizationSet generalizations: { generalization }.
	generalizationSet isDisjoint: true.
	generalizationSet isCovering: true.
	generalization generalizationSets: { generalizationSet }.
	model := {
		         kind.
		         phase.
		         generalization.
		         generalizationSet }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: phase withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : 'tests' }
PartOfGeneralizationSetVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
