"
I represent tests for BinOverAntipatternVerification.
"
Class {
	#name : 'BinOverAntipatternVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
BinOverAntipatternVerificationTest >> getTestedClass [
	^ BinOverAntipatternVerification.
]

{ #category : 'constants' }
BinOverAntipatternVerificationTest >> getVerifiedClass [
 ^ OPUMLAssociation.
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testCheckBinOverForMixinsWithDisjointAncestors [
	| parentMixinA parentMixinB childMixinA childMixinB genA genB association model result |
	parentMixinA := self createClass: 'ParentMixinA' withStereotype: OntoUMLCategory.
	parentMixinB := self createClass: 'ParentMixinB' withStereotype: OntoUMLCategory.
	childMixinA := self createClass: 'ChildMixinA' withStereotype: OntoUMLCategory.
	childMixinB := self createClass: 'ChildMixinB' withStereotype: OntoUMLCategory.
	genA := self createGeneralizationFor: parentMixinA withSpecific: childMixinA.
	genB := self createGeneralizationFor: parentMixinB withSpecific: childMixinB.
	association := self createAssociationFrom: childMixinA to: childMixinB.
	model := { parentMixinA . parentMixinB . childMixinA . childMixinB . genA . genB . association }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testCheckOverlapForAnd [

	| kind subkind role |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	subkind := self createClass: 'subkind' withStereotype: OntoUMLSubKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	self
		deny: (self getTestedClass basicNew checkOverlapFor: { kind } asSet and: {
					 subkind.
					 role } asSet)
		description: 'Disjoint kind and subkind/role sets must not overlap'.
	self
		assert: (self getTestedClass basicNew
				 checkOverlapFor: {
						 kind.
						 subkind } asSet
				 and: {
						 subkind.
						 role } asSet)
		description: 'Sets sharing subkind must report overlap'
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testInvalidModel [

	| kind association model result message |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	association := self createAssociationFrom: kind to: kind.
	model := {
		         kind.
		         association }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: association.
	self assert: message verification class identicalTo: BinOverAntipatternVerification.
	self
		assert: message messageText
		equals: 'Both ends of the kind->kind association can be represented by the same individual: kind'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/BinOver/index.html'
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testValidModel [

	| kind secondKind association model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	association := self createAssociationFrom: kind to: secondKind.
	model := {
		         kind.
		         secondKind.
		         association }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
BinOverAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
