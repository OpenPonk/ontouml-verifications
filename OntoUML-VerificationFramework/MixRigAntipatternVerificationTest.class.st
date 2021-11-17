"
I represent tests for MixRigAntipatternVerification.
"
Class {
	#name : #MixRigAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
MixRigAntipatternVerificationTest >> getTestedClass [
	^ MixRigAntipatternVerification.
]

{ #category : #constants }
MixRigAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
MixRigAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLMixin. }.
]

{ #category : #tests }
MixRigAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
MixRigAntipatternVerificationTest >> testInvalidModel [
	| kind collective mixin firstGeneralization secondGeneralization model result |
	kind := self createClass: 'kind'  withStereotype: OntoUMLKind.
	collective := self createClass: 'collective'  withStereotype: OntoUMLCollective.
	mixin := self createClass: 'mixin'  withStereotype: OntoUMLMixin.
	firstGeneralization := self createGeneralizationFor: mixin withSpecific: kind.
	secondGeneralization := self createGeneralizationFor: mixin withSpecific: collective.
	
	model := { kind. collective. mixin. firstGeneralization. secondGeneralization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: mixin withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
MixRigAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
MixRigAntipatternVerificationTest >> testValidModel [
	| kind phase mixin firstGeneralization secondGeneralization thirdGeneralization model result |
	kind := self createClass: 'kind'  withStereotype: OntoUMLKind.
	phase := self createClass: 'phase'  withStereotype: OntoUMLPhase.
	mixin := self createClass: 'mixin'  withStereotype: OntoUMLMixin.
	firstGeneralization := self createGeneralizationFor: mixin withSpecific: kind.
	secondGeneralization := self createGeneralizationFor: mixin withSpecific: phase.
	thirdGeneralization := self createGeneralizationFor: kind withSpecific: phase.
	
	model := { kind. phase. mixin. firstGeneralization. secondGeneralization. thirdGeneralization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: mixin withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
MixRigAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
MixRigAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
MixRigAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
