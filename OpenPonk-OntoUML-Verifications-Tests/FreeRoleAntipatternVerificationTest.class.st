"
I represent tests for FreeRoleAntipatternVerification.
"
Class {
	#name : 'FreeRoleAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
FreeRoleAntipatternVerificationTest >> getTestedClass [
	^ FreeRoleAntipatternVerification.
]

{ #category : 'constants' }
FreeRoleAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
FreeRoleAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRole. }.
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testFulfillsRelationalDependency [

	| kind relator mediation sourceEnd targetEnd testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	mediation := self createAssociationFrom: kind to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	sourceEnd := mediation memberEnds first.
	targetEnd := mediation memberEnds second.
	sourceEnd lowerValue value: 1.
	targetEnd lowerValue value: 1.
	self
		assert: (testedClassInstance fulfillsRelationalDependency: mediation)
		description: '1..1 mediation ends must fulfill relational dependency'.
	targetEnd lowerValue value: (OPUMLLiteralUnlimitedNatural new value: '*').
	self
		assert: (testedClassInstance fulfillsRelationalDependency: mediation)
		description: '1..* mediation ends must fulfill relational dependency'.
	sourceEnd lowerValue value: 0.
	targetEnd lowerValue value: 1.
	self
		deny: (testedClassInstance fulfillsRelationalDependency: mediation)
		description: '0..1 mediation ends must not fulfill relational dependency'.
	sourceEnd lowerValue value: 1.
	targetEnd lowerValue value: 0.
	self
		deny: (testedClassInstance fulfillsRelationalDependency: mediation)
		description: '1..0 mediation ends must not fulfill relational dependency'.
	sourceEnd lowerValue value: 0.
	self
		deny: (testedClassInstance fulfillsRelationalDependency: mediation)
		description: '0..0 mediation ends must not fulfill relational dependency'
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testInvalidModel [

	| kind parentRole childRole relator mediation firstGeneralization secondGeneralization model result message |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	parentRole := self createClass: 'parentRole' withStereotype: OntoUMLRole.
	childRole := self createClass: 'childRole' withStereotype: OntoUMLRole.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	firstGeneralization := self createGeneralizationFor: kind withSpecific: parentRole.
	secondGeneralization := self createGeneralizationFor: parentRole withSpecific: childRole.
	mediation := self createAssociationFrom: parentRole to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	model := {
		         kind.
		         parentRole.
		         childRole.
		         relator.
		         mediation.
		         firstGeneralization.
		         secondGeneralization }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: childRole withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: childRole.
	self assert: message verification class identicalTo: FreeRoleAntipatternVerification.
	self assert: message messageText equals: 'Role childRole should be directly connected with at least one relation.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/FreeRole/index.html'
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testValidModel [

	| kind role relator mediation firstGeneralization model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	firstGeneralization := self createGeneralizationFor: kind withSpecific: role.
	mediation := self createAssociationFrom: role to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	model := {
		         kind.
		         role.
		         relator.
		         mediation.
		         firstGeneralization }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
FreeRoleAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
