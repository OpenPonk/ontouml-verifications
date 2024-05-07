"
I represent tests for RelCompAntipatternVerification.
"
Class {
	#name : 'RelCompAntipatternVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OntoUML-VerificationFramework-Antipattern-Tests',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Antipattern-Tests'
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
	associationA memberEnds second lowerValue: (OPUMLLiteralUnlimitedNatural new value: 1).
	associationA memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	associationB := self createAssociationFrom: sourceB to: targetB.
	associationB applyStereotype: OntoUMLMediation new.
	^ { associationA. associationB. sourceA. tagetA. sourceB. targetB. firstGeneralization. secondGeneralization. }.
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
	associationA memberEnds second lowerValue: (OPUMLLiteralUnlimitedNatural new value: 0).
	associationA memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 1).
	associationB := self createAssociationFrom: sourceB to: targetB.
	associationB applyStereotype: OntoUMLMediation new.
	^ { associationA. associationB. sourceA. tagetA. sourceB. targetB. firstGeneralization. secondGeneralization. }.
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
	self assert: (testedClassInstance checkBoundsFor: associationA memberEnds first) equals: true.
	self assert: (testedClassInstance checkBoundsFor: associationA memberEnds second) equals: false.
	self assert: (testedClassInstance checkBoundsFor: associationB memberEnds first) equals: false.
	self assert: (testedClassInstance checkBoundsFor: associationB memberEnds second) equals: false.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testContainsAncestorOrSelfOf [
	| kind subkindA subkindB subkindC kindB testedClassInstance ancestorTree  |
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
	self assert: (testedClassInstance contains: ancestorTree ancestorOrSelfOf: subkindC) equals: true.
	self assert: (testedClassInstance contains: ancestorTree ancestorOrSelfOf: kindB) equals: false.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testInvalidModel [
	| associationA model result |
	model := self getInvalidModel.
	associationA := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: associationA withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
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
	self assert: (self getTestedClass basicNew relCompExistsBetween: associationA and: associationB) equals: false.
	
	model := self getInvalidModel.
	associationA := model first.
	associationB := model second.
	self assert: (self getTestedClass basicNew relCompExistsBetween: associationA and: associationB) equals: true.
]

{ #category : 'tests' }
RelCompAntipatternVerificationTest >> testValidModel [
	| associationA  model result |	
	model := self getValidModel.
	associationA := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: associationA withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
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
