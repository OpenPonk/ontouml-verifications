"
I represent tests for RelCompAntipatternVerification.
"
Class {
	#name : 'RelCompAntipatternVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> getInvalidModel [

	| sourceA tagetA sourceB targetB associationA associationB firstGeneralization secondGeneralization |
	sourceA := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	tagetA := self createClass: 'tagetA' withStereotype: OntoUMLKind.
	sourceB := self createClass: 'sourceB' withStereotype: OntoUMLSubKind.
	targetB := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	firstGeneralization := self createGeneralizationFor: tagetA withSpecific: sourceB.
	secondGeneralization := self createGeneralizationFor: tagetA withSpecific: targetB.
	associationA := self createAssociationFrom: sourceA to: tagetA.
	associationA memberEnds second lowerValue: (OPUMLLiteralInteger new value: 1).
	associationA memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	associationB := self createAssociationFrom: sourceB to: targetB.
	associationB applyStereotype: OntoUMLMediation new.
	^ {
		  associationA.
		  associationB.
		  sourceA.
		  tagetA.
		  sourceB.
		  targetB.
		  firstGeneralization.
		  secondGeneralization }
]

{ #category : 'constants' }
RelCompAntipatternVerificationTest >> getTestedClass [
	^ RelCompAntipatternVerification.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> getValidModel [

	| sourceA tagetA sourceB targetB associationA associationB firstGeneralization secondGeneralization |
	sourceA := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	tagetA := self createClass: 'tagetA' withStereotype: OntoUMLKind.
	sourceB := self createClass: 'sourceB' withStereotype: OntoUMLSubKind.
	targetB := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	firstGeneralization := self createGeneralizationFor: tagetA withSpecific: sourceB.
	secondGeneralization := self createGeneralizationFor: tagetA withSpecific: targetB.
	associationA := self createAssociationFrom: sourceA to: tagetA.
	associationA memberEnds second lowerValue: (OPUMLLiteralInteger new value: 0).
	associationA memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 1).
	associationB := self createAssociationFrom: sourceB to: targetB.
	associationB applyStereotype: OntoUMLMediation new.
	^ {
		  associationA.
		  associationB.
		  sourceA.
		  tagetA.
		  sourceB.
		  targetB.
		  firstGeneralization.
		  secondGeneralization }
]

{ #category : 'constants' }
RelCompAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testCheckBoundsFor [

	| kindA kindB associationA associationB testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	kindA := self createClass: 'kindA' withStereotype: OntoUMLKind.
	kindB := self createClass: 'kindB' withStereotype: OntoUMLKind.
	associationA := self createAssociationFrom: kindA to: kindB.
	associationA memberEnds first lowerValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	associationA memberEnds first upperValue value: 3.
	associationA memberEnds second lowerValue value: 4.
	associationA memberEnds second upperValue value: 1.
	associationB := self createAssociationFrom: kindA to: kindB.
	associationB memberEnds first lowerValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	associationB memberEnds first upperValue value: 1.
	associationB memberEnds second lowerValue value: 0.
	associationB memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	self
		assert: (testedClassInstance checkBoundsFor: associationA memberEnds first)
		description: 'End with upper > 1 and lower > 0 must satisfy checkBoundsFor:'.
	self
		deny: (testedClassInstance checkBoundsFor: associationA memberEnds second)
		description: 'End with upper = 1 must not satisfy checkBoundsFor:'.
	self
		deny: (testedClassInstance checkBoundsFor: associationB memberEnds first)
		description: 'End with upper = 1 must not satisfy checkBoundsFor:'.
	self
		deny: (testedClassInstance checkBoundsFor: associationB memberEnds second)
		description: 'End with lower = 0 must not satisfy checkBoundsFor:'
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testContainsAncestorOrSelfOf [

	| kind subkindA subkindB subkindC kindB testedClassInstance ancestorTree |
	testedClassInstance := self getTestedClass basicNew.
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	kindB := self createClass: 'kindB' withStereotype: OntoUMLKind.
	subkindA := self createClass: 'subkindA' withStereotype: OntoUMLSubKind.
	subkindB := self createClass: 'subkindB' withStereotype: OntoUMLSubKind.
	subkindC := self createClass: 'subkindC' withStereotype: OntoUMLSubKind.
	self createGeneralizationFor: kind withSpecific: subkindA.
	self createGeneralizationFor: kind withSpecific: subkindB.
	self createGeneralizationFor: subkindB withSpecific: subkindC.

	ancestorTree := OntoUMLModelQuery getAncestorsFor: subkindA.
	ancestorTree add: subkindA.
	self
		assert: (testedClassInstance contains: ancestorTree ancestorOrSelfOf: subkindC)
		description: 'Ancestor tree containing common kind ancestor must match subkindC'.
	self
		deny: (testedClassInstance contains: ancestorTree ancestorOrSelfOf: kindB)
		description: 'Ancestor tree must not match unrelated kindB'
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testInvalidModel [

	| associationA model result message |
	model := self getInvalidModel.
	associationA := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: associationA withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: associationA.
	self assert: message verification class identicalTo: RelCompAntipatternVerification.
	self assert: message messageText equals: 'Association sourceA->tagetA is in RelComp anti-pattern with  sourceB->targetB'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelComp/index.html'
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testRelCompExistsBetweenAnd [

	| model associationA associationB |
	model := self getValidModel.
	associationA := model first.
	associationB := model second.
	self
		deny: (self getTestedClass basicNew relCompExistsBetween: associationA and: associationB)
		description: 'Valid model associations must not trigger RelComp'.

	model := self getInvalidModel.
	associationA := model first.
	associationB := model second.
	self
		assert: (self getTestedClass basicNew relCompExistsBetween: associationA and: associationB)
		description: 'Invalid model associations must trigger RelComp'
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testValidModel [

	| associationA model result |
	model := self getValidModel.
	associationA := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: associationA withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
