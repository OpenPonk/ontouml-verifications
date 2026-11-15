"
I represent tests for MultDepAntipatternVerification.
"
Class {
	#name : 'MultDepAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
MultDepAntipatternVerificationTest >> getTestedClass [
	^ MultDepAntipatternVerification.
]

{ #category : 'constants' }
MultDepAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
MultDepAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLKind. OntoUMLQuantity. OntoUMLCollective. OntoUMLRole. OntoUMLPhase. OntoUMLSubKind. OntoUMLCategory. OntoUMLMixin. OntoUMLRoleMixin.}.
]

{ #category : 'tests' }
MultDepAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : 'tests' }
MultDepAntipatternVerificationTest >> testInvalidModel [

	| kind secondKind collective firstMediation secondMediation model result message |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	collective := self createClass: 'collective' withStereotype: OntoUMLCollective.
	firstMediation := self createAssociationFrom: kind to: secondKind.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondMediation := self createAssociationFrom: kind to: collective.
	secondMediation applyStereotype: OntoUMLMediation new.
	model := {
		         kind.
		         secondKind.
		         collective.
		         firstMediation.
		         secondMediation }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: kind withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: kind.
	self assert: message verification class identicalTo: MultDepAntipatternVerification.
	self assert: message messageText equals: 'Sortal kind is directly connected to two or more mediations.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MultDep/index.html'
]

{ #category : 'tests' }
MultDepAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
MultDepAntipatternVerificationTest >> testValidModel [

	| kind secondKind collective firstMediation secondAssociation model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	collective := self createClass: 'collective' withStereotype: OntoUMLCollective.
	firstMediation := self createAssociationFrom: kind to: secondKind.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondAssociation := self createAssociationFrom: kind to: collective.
	model := {
		         kind.
		         secondKind.
		         collective.
		         firstMediation.
		         secondAssociation }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: secondKind withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
MultDepAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
MultDepAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
