"
I represent tests for ImpAbsAntipatternVerification.
"
Class {
	#name : 'ImpAbsAntipatternVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
ImpAbsAntipatternVerificationTest >> getTestedClass [
	^ ImpAbsAntipatternVerification.
]

{ #category : 'constants' }
ImpAbsAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'constants' }
ImpAbsAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
ImpAbsAntipatternVerificationTest >> testCheckNumberOfChildrenForFrom [

	| source taget directChildA directChildB indirectChild association directGenA directGenB indirectGen model |
	source := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	taget := self createClass: 'tagetA' withStereotype: OntoUMLKind.
	directChildA := self createClass: 'directChildA' withStereotype: OntoUMLSubKind.
	directChildB := self createClass: 'directChildB' withStereotype: OntoUMLSubKind.
	indirectChild := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	directGenA := self createGeneralizationFor: source withSpecific: directChildA.
	indirectGen := self createGeneralizationFor: directChildA withSpecific: indirectChild.
	association := self createAssociationFrom: source to: taget.
	model := {
		         source.
		         taget.
		         directChildA.
		         directChildB.
		         indirectChild.
		         association.
		         directGenA.
		         indirectGen }.
	self
		deny: (self getTestedClass basicNew checkNumberOfChildrenFor: association memberEnds first from: model)
		description: 'Source with only one direct child must not trigger multiple-children check'.
	directGenB := self createGeneralizationFor: source withSpecific: directChildB.
	model := {
		         source.
		         taget.
		         directChildA.
		         directChildB.
		         indirectChild.
		         association.
		         directGenA.
		         directGenB.
		         indirectGen }.
	self
		assert: (self getTestedClass basicNew checkNumberOfChildrenFor: association memberEnds first from: model)
		description: 'Source with two direct children must trigger multiple-children check'
]

{ #category : 'tests' }
ImpAbsAntipatternVerificationTest >> testCheckUpperMultiplicityFor [

	| kindA kindB association end testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	kindA := self createClass: 'kindA' withStereotype: OntoUMLKind.
	kindB := self createClass: 'kindB' withStereotype: OntoUMLKind.
	association := self createAssociationFrom: kindA to: kindB.
	end := association memberEnds second.
	end upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	self assert: (testedClassInstance checkUpperMultiplicityFor: end) description: 'Unlimited upper bound * must be >= 2'.
	end upperValue value: 2.
	self assert: (testedClassInstance checkUpperMultiplicityFor: end) description: 'Upper bound 2 must be >= 2'.
	end upperValue value: 1.
	self deny: (testedClassInstance checkUpperMultiplicityFor: end) description: 'Upper bound 1 must not be >= 2'
]

{ #category : 'tests' }
ImpAbsAntipatternVerificationTest >> testInvalidModel [

	| source taget childA childB association generalizationA generalizationB model result message |
	source := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	taget := self createClass: 'tagetA' withStereotype: OntoUMLKind.
	childA := self createClass: 'sourceB' withStereotype: OntoUMLSubKind.
	childB := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	generalizationA := self createGeneralizationFor: taget withSpecific: childA.
	generalizationB := self createGeneralizationFor: taget withSpecific: childB.
	association := self createAssociationFrom: source to: taget.
	association memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	model := {
		         source.
		         taget.
		         childA.
		         childB.
		         association.
		         generalizationA.
		         generalizationB }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: association.
	self assert: message verification class identicalTo: ImpAbsAntipatternVerification.
	self
		assert: message messageText
		equals:
		'Association sourceA->tagetA is connected to element that has multiple subtypes and upper bound for its multiplicity is >= 2.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/ImpAbs/index.html'
]

{ #category : 'constants' }
ImpAbsAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
ImpAbsAntipatternVerificationTest >> testValidModel [

	| source taget childA childB association generalizationA generalizationB model result |
	source := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	taget := self createClass: 'tagetA' withStereotype: OntoUMLKind.
	childA := self createClass: 'sourceB' withStereotype: OntoUMLSubKind.
	childB := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	generalizationA := self createGeneralizationFor: taget withSpecific: childA.
	generalizationB := self createGeneralizationFor: taget withSpecific: childB.
	association := self createAssociationFrom: source to: taget.
	association memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 1).
	model := {
		         source.
		         taget.
		         childA.
		         childB.
		         association.
		         generalizationA.
		         generalizationB }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assertEmpty: result results
]

{ #category : 'constants' }
ImpAbsAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'constants' }
ImpAbsAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
