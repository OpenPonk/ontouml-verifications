"
I represent tests for UndefPhaseAntipatternVerification.
"
Class {
	#name : 'UndefPhaseAntipatternVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
UndefPhaseAntipatternVerificationTest >> getTestedClass [
	^ UndefPhaseAntipatternVerification.
]

{ #category : 'constants' }
UndefPhaseAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLGeneralizationSet.
]

{ #category : 'constants' }
UndefPhaseAntipatternVerificationTest >> getVerifiedClassInstance [
	| parent child gen gs |
	parent := OPUMLClass new name: 'Parent'.
	parent applyStereotype: OntoUMLKind new.
	child := OPUMLClass new name: 'Child'.
	child applyStereotype: OntoUMLPhase new.
	gen := OPUMLGeneralization new
		general: parent;
		specific: child.
	gs := OPUMLGeneralizationSet new.
	gs generalizations add: gen.
	^ gs
]

{ #category : 'tests' }
UndefPhaseAntipatternVerificationTest >> testAspectsExistForInModel [

	| kind quality characterisation model |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	model := { kind }.
	self
		deny: (self getTestedClass basicNew aspectsExistFor: kind inModel: model)
		description: 'Class without characterizing aspect must report no aspects'.

	quality := self createClass: 'quality' withStereotype: OntoUMLQuality.
	characterisation := self createAssociationFrom: kind to: quality.
	characterisation applyStereotype: OntoUMLCharacterization new.
	model := {
		         kind.
		         characterisation.
		         quality }.
	self
		assert: (self getTestedClass basicNew aspectsExistFor: kind inModel: model)
		description: 'Class connected by characterization to quality must report existing aspects'
]

{ #category : 'tests' }
UndefPhaseAntipatternVerificationTest >> testAttributesExistFor [

	| kind |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	self
		deny: (self getTestedClass basicNew attributesExistFor: kind)
		description: 'Class without ownedAttributes must report no attributes'.
	kind ownedAttributes: { OPUMLProperty new }.
	self
		assert: (self getTestedClass basicNew attributesExistFor: kind)
		description: 'Class with ownedAttribute must report existing attributes'
]

{ #category : 'tests' }
UndefPhaseAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : 'tests' }
UndefPhaseAntipatternVerificationTest >> testInvalidModel [

	| kind phase generalization generalizationSet model result message |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	phase := self createClass: 'phase' withStereotype: OntoUMLPhase.
	generalization := self createGeneralizationFor: kind withSpecific: phase.
	generalizationSet := OPUMLGeneralizationSet new.
	generalization generalizationSets: { generalizationSet }.
	model := {
		         kind.
		         phase.
		         generalization.
		         generalizationSet }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: generalizationSet withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: phase.
	self assert: message verification class identicalTo: UndefPhaseAntipatternVerification.
	self assert: message messageText equals: 'Parents of phase phase don''t have any attributes or qualities.'.
	self
		assert: message documentationReference
		equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefPhase/index.html'
]

{ #category : 'constants' }
UndefPhaseAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
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
	model := {
		         kind.
		         phase.
		         generalization.
		         characterisation.
		         generalizationSet }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: generalizationSet withModel: model).
	self assertEmpty: result results
]

{ #category : 'constants' }
UndefPhaseAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'constants' }
UndefPhaseAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
