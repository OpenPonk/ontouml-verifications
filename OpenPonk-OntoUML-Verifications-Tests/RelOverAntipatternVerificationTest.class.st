"
I represent tests for RelOverAntipatternVerification.
"
Class {
	#name : 'RelOverAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> getInvalidModel [

	| relator kind subkind firstMediation secondMediation generalization |
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	subkind := self createClass: 'subkind' withStereotype: OntoUMLSubKind.
	firstMediation := self createAssociationFrom: relator to: kind.
	firstMediation applyStereotype: OntoUMLMediation new.
	firstMediation memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 2).
	secondMediation := self createAssociationFrom: relator to: subkind.
	secondMediation applyStereotype: OntoUMLMediation new.
	generalization := self createGeneralizationFor: kind withSpecific: subkind.
	^ {
		  relator.
		  kind.
		  subkind.
		  firstMediation.
		  secondMediation.
		  generalization }
]

{ #category : 'constants' }
RelOverAntipatternVerificationTest >> getTestedClass [
	^ RelOverAntipatternVerification.
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> getValidModel [
	| relator firstKind secondKind firstMediation secondMediation |
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstMediation := self createAssociationFrom: relator to: firstKind.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondMediation := self createAssociationFrom: relator to: secondKind.
	secondMediation applyStereotype: OntoUMLMediation new.
	^ { relator. firstKind. secondKind. firstMediation. secondMediation. }.
]

{ #category : 'constants' }
RelOverAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
RelOverAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testCheckForOverlap [

	| relator mediatedObjects model testedClass |
	testedClass := self getTestedClass basicNew.
	model := self getValidModel.
	relator := model first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model.
	self deny: (testedClass checkForOverlap: mediatedObjects) description: 'Mediated ends of disjoint kinds must not overlap'.

	model := self getInvalidModel.
	relator := model first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model.
	self assert: (testedClass checkForOverlap: mediatedObjects) description: 'Mediated ends of kind and its subkind must overlap'
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testCheckUpperMultiplicityFor [

	| relator mediatedObjects model testedClass |
	testedClass := self getTestedClass basicNew.
	model := self getValidModel.
	relator := model first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model.
	self
		deny: (testedClass checkUpperMultiplicityFor: mediatedObjects)
		description: 'Mediated ends with total upper multiplicity <= 2 must not trigger check'.

	model := self getInvalidModel.
	relator := model first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model.
	self
		assert: (testedClass checkUpperMultiplicityFor: mediatedObjects)
		description: 'Mediated ends with total upper multiplicity > 2 must trigger check'
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testGetMediatedEndsForFrom [

	| relator mediatedObjects model |
	model := self getValidModel.
	relator := model first.
	mediatedObjects := model
		                   select: [ :object | object isKindOf: OPUMLAssociation ]
		                   thenCollect: [ :association | association memberEnds second ].
	self assertCollection: (self getTestedClass basicNew getMediatedEndsFor: relator from: model) hasSameElements: mediatedObjects
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testInvalidModel [

	| relator model result message |
	model := self getInvalidModel.
	relator := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: relator.
	self assert: message verification class identicalTo: RelOverAntipatternVerification.
	self assert: message messageText equals: 'Relator relator is mediated by multiple elements with possible overlap.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelOver/index.html'
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testValidModel [

	| relator model result |
	model := self getValidModel.
	relator := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
RelOverAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
