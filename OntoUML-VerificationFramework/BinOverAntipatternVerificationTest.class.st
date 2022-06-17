"
I represent tests for BinOverAntipatternVerification.
"
Class {
	#name : #BinOverAntipatternVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
BinOverAntipatternVerificationTest >> getTestedClass [
	^ BinOverAntipatternVerification.
]

{ #category : #constants }
BinOverAntipatternVerificationTest >> getVerifiedClass [
 ^ OPUMLAssociation.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testCheckOverlapForAnd [
	| kind subkind role |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
 	subkind := self createClass: 'subkind' withStereotype: OntoUMLSubKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	self assert:  (self getTestedClass basicNew checkOverlapFor: { kind. } asSet and: { subkind. role. } asSet ) equals: false.
	self assert:  (self getTestedClass basicNew checkOverlapFor: { kind.  subkind. } asSet and: { subkind. role. } asSet ) equals: true.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testInvalidModel [
	| kind association model result |
	kind := self createClass: 'kind' withStereotype:  OntoUMLKind.
	association := self createAssociationFrom: kind to: kind.
	model := { kind. association. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: result results size equals: 1.
	self assert: (result results anySatisfy: [ :message | message isKindOf: VerificationMessageWarning. ]).
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testValidModel [
	| kind secondKind association model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	association := self createAssociationFrom: kind to: secondKind.
	model := { kind. secondKind. association. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
