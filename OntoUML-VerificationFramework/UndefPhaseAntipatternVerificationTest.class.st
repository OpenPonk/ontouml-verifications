"
I represent tests for UndefPhaseAntipatternVerification.
"
Class {
	#name : #UndefPhaseAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> getTestedClass [
	^ UndefPhaseAntipatternVerification.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLPhase. }.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testAspectsExistForInModel [
	| kind quality characterisation model |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.	
	model := { kind. }.
	self assert: (self getTestedClass basicNew aspectsExistFor: kind inModel: model) equals: false.
	
	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.	
	characterisation := self createAssociationFrom: kind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.	
	model := { kind. characterisation. quality. }.
	self assert: (self getTestedClass basicNew aspectsExistFor: kind inModel: model) equals: true.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testAttributesExistFor [
	| kind |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	self assert: (self getTestedClass basicNew attributesExistFor: kind) equals: false.
	kind ownedAttributes: { OPUMLProperty new }.
	self assert: (self getTestedClass basicNew attributesExistFor: kind) equals: true.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testInvalidModel [
	| kind phase generalization model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	phase := self createClass: 'phase' withStereotype: OntoUMLPhase.	
	generalization := self createGeneralizationFor: kind withSpecific: phase.
	model := { kind. phase. generalization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: phase withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testValidModel [
	| kind phase generalization quality characterisation model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	phase := self createClass: 'phase' withStereotype: OntoUMLPhase.	
	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.	
	generalization := self createGeneralizationFor: kind withSpecific: phase.
	characterisation := self createAssociationFrom: kind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.
	model := { kind. phase. generalization. characterisation. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: phase withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
