"
I represent tests for DecIntAntipatternVerification.
"
Class {
	#name : 'DecIntAntipatternVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Antipattern-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
DecIntAntipatternVerificationTest >> getTestedClass [
	^ DecIntAntipatternVerification.
]

{ #category : 'constants' }
DecIntAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
DecIntAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLSubKind. OntoUMLPhase. OntoUMLMode. OntoUMLRole. OntoUMLRelator.}.
]

{ #category : 'tests' }
DecIntAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
DecIntAntipatternVerificationTest >> testInvalidModel [

	| firstKind secondKind subKind firstGeneralization secondGeneralization generalizationSet model result message |
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	subKind := self createClass: 'subKind' withStereotype: OntoUMLSubKind.
	firstGeneralization := self createGeneralizationFor: firstKind withSpecific: subKind.
	secondGeneralization := self createGeneralizationFor: secondKind withSpecific: subKind.
	generalizationSet := OPUMLGeneralizationSet new.
	generalizationSet generalizations: {
			firstGeneralization.
			secondGeneralization }.
	generalizationSet isCovering: false.
	model := {
		         firstKind.
		         secondKind.
		         subKind.
		         firstGeneralization.
		         secondGeneralization }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: subKind withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageWarning.
	self assert: message objectReference identicalTo: subKind.
	self assert: message verification class identicalTo: DecIntAntipatternVerification.
	self assert: message messageText equals: 'Element subKind has more than one non-abstract parent.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/anti-patterns/DecInt/index.html'
]

{ #category : 'tests' }
DecIntAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
DecIntAntipatternVerificationTest >> testValidModel [

	| kind role rolemixin firstGeneralization secondGeneralization model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	rolemixin := self createClass: 'rolemixin' withStereotype: OntoUMLRoleMixin.
	firstGeneralization := self createGeneralizationFor: kind withSpecific: role.
	secondGeneralization := self createGeneralizationFor: rolemixin withSpecific: role.
	model := {
		         kind.
		         role.
		         rolemixin.
		         firstGeneralization.
		         secondGeneralization }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
DecIntAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
DecIntAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
DecIntAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
