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
RelationDependencyVerificationTest >> testFulfillsRelationalDependencyTargetZeroLowerBound [

	| kind role mediation |
	kind := self createClass: 'Person' withStereotype: OntoUMLKind.
	role := self createClass: 'Student' withStereotype: OntoUMLRole.
	mediation := self createAssociationFrom: kind to: role.
	mediation memberEnds second lowerValue value: 0.
	self
		deny: (RelationDependencyVerification basicNew fulfillsRelationalDependency: mediation)
		description: 'Relation with lower bound 0 on target end must not fulfill relational dependency'
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
RelationDependencyVerificationTest >> testValidModelInheritingRelationFromParentRoleMixinAndCycleSafety [

	| roleMixin childRole cycleRoleA cycleRoleB targetKind material genToMixin genCycle1 genCycle2 model |
	roleMixin := self createClass: 'Customer' withStereotype: OntoUMLRoleMixin.
	childRole := self createClass: 'PersonalCustomer' withStereotype: OntoUMLRole.
	cycleRoleA := self createClass: 'CycleRoleA' withStereotype: OntoUMLRole.
	cycleRoleB := self createClass: 'CycleRoleB' withStereotype: OntoUMLRole.
	targetKind := self createClass: 'Company' withStereotype: OntoUMLKind.
	genToMixin := self createGeneralizationFor: roleMixin withSpecific: childRole.
	genCycle1 := self createGeneralizationFor: cycleRoleB withSpecific: cycleRoleA.
	genCycle2 := self createGeneralizationFor: cycleRoleA withSpecific: cycleRoleB.
	material := self createAssociationFrom: roleMixin to: targetKind with: OntoUMLMaterial new.
	model := {
		         roleMixin.
		         childRole.
		         cycleRoleA.
		         cycleRoleB.
		         targetKind.
		         genToMixin.
		         genCycle1.
		         genCycle2.
		         material }.
	self assertEmpty: (RelationDependencyVerification verify: childRole withModel: model).
	self assert: (RelationDependencyVerification verify: cycleRoleA withModel: model) size equals: 1
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
