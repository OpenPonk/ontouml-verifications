"
I represent tests for RelSpecsAntipatternVerification.
"
Class {
	#name : #RelSpecsAntipatternVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> getInvalidModel [
	| firstKind firstSubKind secondKind secondSubKind firstAssociation secondAssociation firstGeneralization secondGeneralization |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstSubKind := self createClass: 'firstSubKind' withStereotype: OntoUMLSubKind.
	secondSubKind := self createClass: 'secondSubKind' withStereotype: OntoUMLSubKind.
	firstGeneralization := self createGeneralizationFor: firstKind withSpecific: firstSubKind.
	secondGeneralization := self createGeneralizationFor: secondKind withSpecific: secondSubKind.	
	firstAssociation := self createAssociationFrom: firstKind to: secondKind.
	firstAssociation applyStereotype: OntoUMLMediation new.
	secondAssociation := self createAssociationFrom: secondSubKind to: firstSubKind.
	secondAssociation applyStereotype: OntoUMLMediation new.
	^ { firstAssociation. secondAssociation. firstKind. firstSubKind. secondKind. secondSubKind.  firstGeneralization. secondGeneralization. }.
]

{ #category : #constants }
RelSpecsAntipatternVerificationTest >> getTestedClass [
	^ RelSpecAntipatternVerification.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> getValidModel [
	| firstKind firstSubKind secondKind secondSubKind thirdKind firstAssociation secondAssociation firstGeneralization secondGeneralization |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstSubKind := self createClass: 'firstSubKind' withStereotype: OntoUMLSubKind.
	secondSubKind := self createClass: 'secondSubKind' withStereotype: OntoUMLSubKind.
	thirdKind := self createClass: 'thirdKind' withStereotype: OntoUMLKind.
	firstGeneralization := self createGeneralizationFor: firstKind withSpecific: firstSubKind.
	secondGeneralization := self createGeneralizationFor: secondKind withSpecific: secondSubKind.	
	firstAssociation := self createAssociationFrom: firstKind to: secondKind.
	firstAssociation applyStereotype: OntoUMLMediation new.
	firstAssociation memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 2).
	secondAssociation := self createAssociationFrom: firstSubKind to: thirdKind.
	secondAssociation applyStereotype: OntoUMLMediation new.
   ^ { firstAssociation. secondAssociation. firstKind. firstSubKind. secondKind. secondSubKind. thirdKind. firstGeneralization. secondGeneralization. }.
]

{ #category : #constants }
RelSpecsAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testContainsAncestorOrSelfOf [
	| firstKind firstSubKind secondKind secondSubKind ancestorSet |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstSubKind := self createClass: 'firstSubKind' withStereotype: OntoUMLSubKind.
	secondSubKind := self createClass: 'secondSubKind' withStereotype: OntoUMLSubKind.
	self createGeneralizationFor: firstKind withSpecific: firstSubKind.
	self createGeneralizationFor: secondKind withSpecific: secondSubKind.
	ancestorSet := { firstSubKind. firstKind. }.
	self assert: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: firstSubKind) equals: true.
	self assert: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: firstKind) equals: true.
	self assert: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: secondSubKind) equals: false.
	self assert: (self getTestedClass basicNew contains: ancestorSet ancestorOrSelfOf: secondKind) equals: false.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testInvalidModel [
	| firstAssociation model result |	
	model := self getInvalidModel.
	firstAssociation := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: firstAssociation withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testRelSpecsExistsBetweenAnd [
	| firstAssociation secondAssociation model |
	model := self getValidModel.
	firstAssociation := model first.
	secondAssociation := model second.
	self assert: (self getTestedClass basicNew relSpecsExistsBetween: firstAssociation and: secondAssociation) equals: false.
	
	model := self getInvalidModel.
	firstAssociation := model first.
	secondAssociation := model second.
	self assert: (self getTestedClass basicNew relSpecsExistsBetween: firstAssociation and: secondAssociation) equals: true.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testValidModel [
	| firstAssociation model result |
	model := self getValidModel.
	firstAssociation := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: firstAssociation withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
RelSpecsAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
