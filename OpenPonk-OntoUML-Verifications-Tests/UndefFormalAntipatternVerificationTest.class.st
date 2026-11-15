"
Verifies detection algorithms and diagnostic results for the OntoUML Undefined Formal antipattern.
"
Class {
	#name : 'UndefFormalAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
UndefFormalAntipatternVerificationTest >> getTestedClass [
	^ UndefFormalAntipatternVerification.
]

{ #category : 'constants' }
UndefFormalAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'constants' }
UndefFormalAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLDomainFormal. }.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testAttributesExistFor [

	| kind |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	self
		deny: (self getTestedClass basicNew attributesExistFor: kind)
		description: 'Class without ownedAttributes must report no attributes'.
	kind ownedAttributes: { OPUMLProperty new }.
	self
		assert: (self getTestedClass basicNew attributesExistFor: kind)
		description: 'Class with ownedAttribute must report existing attributes'
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testInvalidModel [

	| firstKind secondKind firstAssociation model result message |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	firstAssociation := self createAssociationFrom: firstKind to: secondKind.
	firstAssociation applyStereotype: OntoUMLDomainFormal new.
	model := {
		         firstKind.
		         secondKind.
		         firstAssociation }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: firstAssociation withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: firstAssociation.
	self assert: message verification class identicalTo: UndefFormalAntipatternVerification.
	self
		assert: message messageText
		equals:
		'Formal association firstKind->secondKind joins two elements and one or both of the elements don''t have attribute/quality.'.
	self
		assert: message documentationReference
		equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefFormal/index.html'
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testQualitiesExistForInModel [

	| kind quality characterisation model |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	model := { kind }.
	self
		deny: (self getTestedClass basicNew qualitiesExistFor: kind inModel: model)
		description: 'Class without characterizing quality must report no qualities'.

	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.
	characterisation := self createAssociationFrom: kind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.
	model := {
		         kind.
		         characterisation.
		         quality }.
	self
		assert: (self getTestedClass basicNew qualitiesExistFor: kind inModel: model)
		description: 'Class connected by characterization to quality must report existing qualities'
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testValidModel [

	| firstKind secondKind quality domainFormal characterisation model result |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	firstKind ownedAttributes: { OPUMLProperty new }.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.
	domainFormal := self createAssociationFrom: firstKind to: secondKind.
	domainFormal applyStereotype: OntoUMLDomainFormal new.
	characterisation := self createAssociationFrom: secondKind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.
	model := {
		         firstKind.
		         secondKind.
		         domainFormal.
		         characterisation.
		         quality }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: domainFormal withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
