Class {
	#name : 'DepPhaseAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Antipattern-Tests',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Antipattern-Tests'
}

{ #category : 'constants' }
DepPhaseAntipatternVerificationTest >> getTestedClass [
	^ DepPhaseAntipatternVerification.
]

{ #category : 'constants' }
DepPhaseAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'constants' }
DepPhaseAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLMediation. }.
]

{ #category : 'tests' }
DepPhaseAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
DepPhaseAntipatternVerificationTest >> testInvalidModel [
	| kind phase relator generalization mediation model result |
	kind := self createClass: 'kind'  withStereotype: OntoUMLKind.
	phase := self createClass: 'phase'  withStereotype: OntoUMLPhase.
	relator := self createClass: 'relator'  withStereotype: OntoUMLRelator.	
	generalization := self createGeneralizationFor: kind withSpecific: phase.
	mediation := self createAssociationFrom: phase to: relator.
	mediation applyStereotype: OntoUMLMediation new.
		
	model := { kind. phase. relator. generalization. mediation. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: mediation withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning ]) size equals: 1.
]

{ #category : 'tests' }
DepPhaseAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
DepPhaseAntipatternVerificationTest >> testValidModel [
	| kind role relator generalization mediation model result |
	kind := self createClass: 'kind'  withStereotype: OntoUMLKind.
	role := self createClass: 'role'  withStereotype: OntoUMLRole.
	relator := self createClass: 'relator'  withStereotype: OntoUMLRelator.	
	generalization := self createGeneralizationFor: kind withSpecific: role.
	mediation := self createAssociationFrom: kind to: relator. 
	mediation applyStereotype: OntoUMLMediation new.
		
	model := { kind. role. relator. generalization. mediation. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: mediation withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning ]) size equals: 0.
]

{ #category : 'tests' }
DepPhaseAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
DepPhaseAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
DepPhaseAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
