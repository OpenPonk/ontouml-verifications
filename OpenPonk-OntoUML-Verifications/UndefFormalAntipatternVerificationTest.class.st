Class {
	#name : 'UndefFormalAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Antipattern-Tests',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Antipattern-Tests'
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
	self assert: (self getTestedClass basicNew attributesExistFor: kind) equals: false.
	kind ownedAttributes: { OPUMLProperty new }.
	self assert: (self getTestedClass basicNew attributesExistFor: kind) equals: true.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testInvalidModel [
	| firstKind secondKind firstAssociation model result |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstAssociation := self createAssociationFrom: firstKind to: secondKind.
	firstAssociation applyStereotype: OntoUMLDomainFormal new.
	model := { firstKind. secondKind. firstAssociation. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: firstAssociation withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testQualitiesExistForInModel [
	| kind quality characterisation model |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.	
	model := { kind. }.
	self assert: (self getTestedClass basicNew qualitiesExistFor: kind inModel: model) equals: false.
	
	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.	
	characterisation := self createAssociationFrom: kind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.	
	model := { kind. characterisation. quality. }.
	self assert: (self getTestedClass basicNew qualitiesExistFor: kind inModel: model) equals: true.
]

{ #category : 'tests' }
UndefFormalAntipatternVerificationTest >> testValidModel [
	| firstKind secondKind quality domainFormal characterisation model result |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	firstKind ownedAttributes: { OPUMLProperty new. }.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.	
	domainFormal := self createAssociationFrom: firstKind to: secondKind.
	domainFormal applyStereotype: OntoUMLDomainFormal new.
	characterisation := self createAssociationFrom: secondKind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.
	model := { firstKind. secondKind. domainFormal. characterisation. quality. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: domainFormal withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
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
