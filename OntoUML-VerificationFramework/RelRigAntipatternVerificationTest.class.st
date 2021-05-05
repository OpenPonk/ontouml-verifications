"
I represent tests for RelRigAntipatternVerification.
"
Class {
	#name : #RelRigAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
RelRigAntipatternVerificationTest >> getTestedClass [
	^ RelRigAntipatternVerification.
]

{ #category : #constants }
RelRigAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RelRigAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #tests }
RelRigAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RelRigAntipatternVerificationTest >> testInvalidModel [
	| kind relator mediation model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	mediation := self createAssociationFrom: kind to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	model := { kind. relator. mediation. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
RelRigAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
RelRigAntipatternVerificationTest >> testValidModel [
	| kind role relator mediation generalization model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	generalization := self createGeneralizationFor: kind withSpecific: role.
	mediation := self createAssociationFrom: role to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	model := { kind. role. relator. mediation. generalization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
RelRigAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
RelRigAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
RelRigAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
