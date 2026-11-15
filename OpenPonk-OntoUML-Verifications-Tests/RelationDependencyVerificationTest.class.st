"
Tests relational dependency verification rules for role classes.
"
Class {
	#name : 'RelationDependencyVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
RelationDependencyVerificationTest >> getTestedClass [
	^ RelationDependencyVerification.
]

{ #category : 'constants' }
RelationDependencyVerificationTest >> getVerifiedStereotypes [
	^{ OntoUMLRole.}.
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testFulfillsRelationalDependency [

	| kind role mediation |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	role := OPUMLClass new applyStereotype: OntoUMLRole new.
	mediation := self createAssociationFrom: kind to: role.
	self
		assert: (self getTestedClass basicNew fulfillsRelationalDependency: mediation)
		description: 'Mediation with lower bounds >= 1 on both ends must fulfill relational dependency'.
	mediation memberEnds first lowerValue value: 0.
	self
		deny: (self getTestedClass basicNew fulfillsRelationalDependency: mediation)
		description: 'Mediation with lower bound 0 on one end must not fulfill relational dependency'
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testInvalidModel [

	| role model result message |
	role := OPUMLClass new.
	role applyStereotype: OntoUMLRole new.
	model := { role }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageError.
	self assert: message objectReference identicalTo: role.
	self assert: message verification class identicalTo: RelationDependencyVerification.
	self
		assert: message messageText
		equals:
		'OntoUMLRole has to have at least one association stereotyped as mediation, material, componentOf, memberOf or subCollectionOf, with multiplicities on both ends >= 1.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/classes/sortals/role/index.html'
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testValidModel [

	| relator association role model result |
	role := OPUMLClass new.
	role applyStereotype: OntoUMLRole new.
	relator := OPUMLClass new.
	relator applyStereotype: OntoUMLRelator new.
	association := self createAssociationFrom: relator to: role.
	association applyStereotype: OntoUMLMediation new.
	model := {
		         role.
		         relator.
		         association }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : 'tests' }
RelationDependencyVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
