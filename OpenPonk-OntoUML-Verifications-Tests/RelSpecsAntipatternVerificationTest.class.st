"
I represent tests for RelSpecsAntipatternVerification.
"
Class {
	#name : 'RelSpecsAntipatternVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> getInvalidModel [
	| firstKind firstSubKind secondKind secondSubKind firstAssociation secondAssociation firstGeneralization secondGeneralization |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstSubKind := self createClass: 'firstSubKind' withStereotype: OntoUMLSubKind.
	secondSubKind := self createClass: 'secondSubKind' withStereotype: OntoUMLSubKind.
	firstGeneralization := self createGeneralizationFor: firstKind withSpecific: firstSubKind.
	secondGeneralization := self createGeneralizationFor: secondKind withSpecific: secondSubKind.	
	firstAssociation := self createAssociationFrom: firstKind to: secondKind.
	firstAssociation applyStereotype: OntoUMLMediation new.
	secondAssociation := self createAssociationFrom: secondSubKind to: firstSubKind.
	secondAssociation applyStereotype: OntoUMLMediation new.
	^ { firstAssociation. secondAssociation. firstKind. firstSubKind. secondKind. secondSubKind.  firstGeneralization. secondGeneralization. }.
]

{ #category : 'constants' }
RelSpecsAntipatternVerificationTest >> getTestedClass [
	^ RelSpecAntipatternVerification.
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> getValidModel [
	| firstKind firstSubKind secondKind secondSubKind thirdKind firstAssociation secondAssociation firstGeneralization secondGeneralization |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstSubKind := self createClass: 'firstSubKind' withStereotype: OntoUMLSubKind.
	secondSubKind := self createClass: 'secondSubKind' withStereotype: OntoUMLSubKind.
	thirdKind := self createClass: 'thirdKind' withStereotype: OntoUMLKind.
	firstGeneralization := self createGeneralizationFor: firstKind withSpecific: firstSubKind.
	secondGeneralization := self createGeneralizationFor: secondKind withSpecific: secondSubKind.	
	firstAssociation := self createAssociationFrom: firstKind to: secondKind.
	firstAssociation applyStereotype: OntoUMLMediation new.
	firstAssociation memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 2).
	secondAssociation := self createAssociationFrom: firstSubKind to: thirdKind.
	secondAssociation applyStereotype: OntoUMLMediation new.
   ^ { firstAssociation. secondAssociation. firstKind. firstSubKind. secondKind. secondSubKind. thirdKind. firstGeneralization. secondGeneralization. }.
]

{ #category : 'constants' }
RelSpecsAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testContainsAncestorOrSelfOf [

	| firstKind firstSubKind secondKind secondSubKind ancestorSet |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	firstSubKind := self createClass: 'firstSubKind' withStereotype: OntoUMLSubKind.
	secondSubKind := self createClass: 'secondSubKind' withStereotype: OntoUMLSubKind.
	self createGeneralizationFor: firstKind withSpecific: firstSubKind.
	self createGeneralizationFor: secondKind withSpecific: secondSubKind.
	ancestorSet := {
		               firstSubKind.
		               firstKind }.
	self
		assert: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: firstSubKind)
		description: 'Ancestor set must match self firstSubKind'.
	self
		assert: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: firstKind)
		description: 'Ancestor set must match ancestor firstKind'.
	self
		deny: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: secondSubKind)
		description: 'Ancestor set must not match unrelated secondSubKind'.
	self
		deny: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: secondKind)
		description: 'Ancestor set must not match unrelated secondKind'
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testInvalidModel [

	| firstAssociation model result message |
	model := self getInvalidModel.
	firstAssociation := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: firstAssociation withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: firstAssociation.
	self assert: message verification class identicalTo: RelSpecAntipatternVerification.
	self
		assert: message messageText
		equals: 'Association firstKind->secondKind is in RelSpecs anti-pattern with  secondSubKind->firstSubKind'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelSpec/index.html'
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testRelSpecsExistsBetweenAnd [

	| firstAssociation secondAssociation model |
	model := self getValidModel.
	firstAssociation := model first.
	secondAssociation := model second.
	self
		deny: (self getTestedClass basicNew relSpecsExistsBetween: firstAssociation and: secondAssociation)
		description: 'Valid model associations must not trigger RelSpecs'.

	model := self getInvalidModel.
	firstAssociation := model first.
	secondAssociation := model second.
	self
		assert: (self getTestedClass basicNew relSpecsExistsBetween: firstAssociation and: secondAssociation)
		description: 'Invalid model associations must trigger RelSpecs'
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testValidModel [

	| firstAssociation model result |
	model := self getValidModel.
	firstAssociation := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: firstAssociation withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
RelSpecsAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
