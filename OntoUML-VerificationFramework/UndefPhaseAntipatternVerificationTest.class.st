"
I represent tests for UndefPhaseAntipatternVerification.
"
Class {
	#name : #UndefPhaseAntipatternVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> getTestedClass [
	^ UndefPhaseAntipatternVerification.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLGeneralizationSet.
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
	"self canVerifyTest."
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testInvalidModel [
	| kind phase generalization generalizationSet model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	phase := self createClass: 'phase' withStereotype: OntoUMLPhase.	
	generalization := self createGeneralizationFor: kind withSpecific: phase.
	generalizationSet := OPUMLGeneralizationSet new.
	generalization generalizationSets: { generalizationSet }.
	model := { kind. phase. generalization. generalizationSet }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: generalizationSet withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testValidModel [
	| kind phase generalization quality characterisation generalizationSet model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	phase := self createClass: 'phase' withStereotype: OntoUMLPhase.	
	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.	
	generalization := self createGeneralizationFor: kind withSpecific: phase.
	characterisation := self createAssociationFrom: kind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.
	generalizationSet := OPUMLGeneralizationSet new.
	generalization generalizationSets: { generalizationSet }.
	model := { kind. phase. generalization. characterisation. generalizationSet }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: generalizationSet withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #constants }
UndefPhaseAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
