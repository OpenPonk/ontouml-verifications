"
I represent tests for RelRigAntipatternVerification.
"
Class {
	#name : 'RelRigAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
RelRigAntipatternVerificationTest >> getTestedClass [
	^ RelRigAntipatternVerification.
]

{ #category : 'constants' }
RelRigAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
RelRigAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : 'tests' }
RelRigAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
RelRigAntipatternVerificationTest >> testInvalidModel [

	| kind relator mediation model result message |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	mediation := self createAssociationFrom: kind to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	model := {
		         kind.
		         relator.
		         mediation }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: relator.
	self assert: message verification class identicalTo: RelRigAntipatternVerification.
	self assert: message messageText equals: 'Relator relator is directly conected to rigid element'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelRig/index.html'
]

{ #category : 'tests' }
RelRigAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
RelRigAntipatternVerificationTest >> testValidModel [

	| kind role relator mediation generalization model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	generalization := self createGeneralizationFor: kind withSpecific: role.
	mediation := self createAssociationFrom: role to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	model := {
		         kind.
		         role.
		         relator.
		         mediation.
		         generalization }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
RelRigAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
RelRigAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
RelRigAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
