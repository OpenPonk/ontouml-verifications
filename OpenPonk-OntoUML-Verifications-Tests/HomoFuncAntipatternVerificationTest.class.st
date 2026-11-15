"
I represent tests for HomoFuncAntipatternVerification.
"
Class {
	#name : 'HomoFuncAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
HomoFuncAntipatternVerificationTest >> getTestedClass [
	^ HomoFuncAntipatternVerification.
]

{ #category : 'constants' }
HomoFuncAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'constants' }
HomoFuncAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLComponentOf. }.
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testGetSortalDescendantsForFrom [
	| ancestor kindA kindB mixin roleMixin model |
	ancestor := self createClass: 'ancestor' withStereotype: OntoUMLMixin.
	kindA := self createClass: 'kindA' withStereotype: OntoUMLKind.
	kindB := self createClass: 'kindB' withStereotype: OntoUMLKind.
	mixin := self createClass: 'mixin' withStereotype: OntoUMLMixin.
	roleMixin := self
		createClass: 'roleMixin'
		withStereotype: OntoUMLRoleMixin.
	model := {ancestor.
	kindA.
	kindB.
	mixin.
	roleMixin.
	(self createGeneralizationFor: ancestor withSpecific: kindA).
	(self createGeneralizationFor: ancestor withSpecific: mixin).
	(self createGeneralizationFor: mixin withSpecific: roleMixin).
	(self createGeneralizationFor: mixin withSpecific: kindB)}.
	self
		assertCollection:
			(self getTestedClass basicNew
				getSortalDescendantsFor: ancestor
				from: model) asOrderedCollection
		hasSameElements:
			{kindA.
			kindB} asOrderedCollection
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testHasKindAsAncestor [

	| kindA subkindA roleA roleMixin roleB testedClassInstance |
	kindA := self createClass: 'kindA' withStereotype: OntoUMLKind.
	subkindA := self createClass: 'subkindA' withStereotype: OntoUMLSubKind.
	roleA := self createClass: 'roleA' withStereotype: OntoUMLRole.
	roleMixin := self createClass: 'roleMixin' withStereotype: OntoUMLRoleMixin.
	roleB := self createClass: 'roleB' withStereotype: OntoUMLRole.
	self createGeneralizationFor: kindA withSpecific: subkindA.
	self createGeneralizationFor: subkindA withSpecific: roleA.
	self createGeneralizationFor: roleMixin withSpecific: roleB.
	testedClassInstance := self getTestedClass basicNew.
	self
		assert: (testedClassInstance hasKindAsAncestor: roleA)
		description: 'Role specializing subkind under kind must have kind as ancestor'.
	self
		deny: (testedClassInstance hasKindAsAncestor: roleB)
		description: 'Role specializing only roleMixin must not have kind as ancestor'
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testInvalidModel [

	| whole funcComplex part generalization componentOf model result message |
	whole := self createClass: 'whole' withStereotype: OntoUMLKind.
	funcComplex := self createClass: 'funcComplex' withStereotype: OntoUMLSubKind.
	part := self createClass: 'part' withStereotype: OntoUMLKind.
	generalization := self createGeneralizationFor: whole withSpecific: funcComplex.
	componentOf := self createAssociationFrom: funcComplex to: part.
	componentOf applyStereotype: OntoUMLComponentOf new.
	componentOf memberEnds second lowerValue: (OPUMLLiteralInteger new value: 2).
	componentOf memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 8).
	self assert: componentOf memberEnds second lower equals: 2.
	model := {
		         whole.
		         funcComplex.
		         part.
		         generalization.
		         componentOf }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: componentOf withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: funcComplex.
	self assert: message verification class identicalTo: HomoFuncAntipatternVerification.
	self assert: message messageText equals: 'Functional complex funcComplex is composed from single unique type of part.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/HomoFunc/index.html'
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testIsFunctionalComplexIn [

	| kind mixin subkind roleMixin role model collective testedClassInstance |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	mixin := self createClass: 'mixin' withStereotype: OntoUMLMixin.
	subkind := self createClass: 'subkind' withStereotype: OntoUMLSubKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	roleMixin := self createClass: 'roleMixin' withStereotype: OntoUMLRoleMixin.
	collective := self createClass: 'collective' withStereotype: OntoUMLCollective.
	model := {
		         kind.
		         mixin.
		         subkind.
		         roleMixin.
		         role.
		         collective.
		         (self createGeneralizationFor: mixin withSpecific: kind).
		         (self createGeneralizationFor: mixin withSpecific: roleMixin).
		         (self createGeneralizationFor: roleMixin withSpecific: role).
		         (self createGeneralizationFor: kind withSpecific: role).
		         (self createGeneralizationFor: kind withSpecific: subkind) }.
	testedClassInstance := self getTestedClass basicNew.
	self
		assert: (testedClassInstance isFunctionalComplex: kind in: model)
		description: 'Kind must be recognized as functional complex'.
	self
		assert: (testedClassInstance isFunctionalComplex: mixin in: model)
		description: 'Mixin with functional complex descendants must be recognized as functional complex'.
	self
		assert: (testedClassInstance isFunctionalComplex: subkind in: model)
		description: 'SubKind specializing kind must be recognized as functional complex'.
	self
		assert: (testedClassInstance isFunctionalComplex: roleMixin in: model)
		description: 'RoleMixin with functional complex descendant must be recognized as functional complex'.
	self
		deny: (testedClassInstance isFunctionalComplex: collective in: model)
		description: 'Collective must not be recognized as functional complex'
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testValidModel [

	| whole funcComplex partA partB generalization componentOfA componentOfB model result |
	whole := self createClass: 'whole' withStereotype: OntoUMLKind.
	funcComplex := self createClass: 'subkind' withStereotype: OntoUMLSubKind.
	partA := self createClass: 'partA' withStereotype: OntoUMLKind.
	partB := self createClass: 'partB' withStereotype: OntoUMLKind.
	generalization := self createGeneralizationFor: whole withSpecific: funcComplex.
	componentOfA := self createAssociationFrom: funcComplex to: partA.
	componentOfA applyStereotype: OntoUMLComponentOf new.
	componentOfA memberEnds second lowerValue: (OPUMLLiteralInteger new value: 2).
	componentOfA memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 8).
	componentOfB := self createAssociationFrom: funcComplex to: partB.
	componentOfB applyStereotype: OntoUMLComponentOf new.
	model := {
		         whole.
		         funcComplex.
		         partA.
		         partB.
		         generalization.
		         componentOfA.
		         componentOfB }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: componentOfA withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
HomoFuncAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
