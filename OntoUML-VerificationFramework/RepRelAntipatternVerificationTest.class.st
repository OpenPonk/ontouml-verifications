"
I represent tests for RepRelAntipatternVerification.
"
Class {
	#name : #RepRelAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
RepRelAntipatternVerificationTest >> getTestedClass [
	^ RepRelAntipatternVerification.
]

{ #category : #constants }
RepRelAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RepRelAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testGetMediationsForFromModel [
	| kind secondKind relator firstMediation secondMediation model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	secondKind := self
		createClass: 'secondKind'
		withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	firstMediation := self createAssociationFrom: kind to: relator.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondMediation := self createAssociationFrom: secondKind to: relator.
	secondMediation applyStereotype: OntoUMLMediation new.
	model := {kind.
	secondKind.
	relator.
	firstMediation.
	secondMediation}.
	result := self getTestedClass basicNew
		getMediationsFor: {kind}
		fromModel: model.
	self
		assertCollection: result asArray
		hasSameElements: {firstMediation}
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testGetUpperBoundMultiplicityOfFor [
	| kind relator mediation |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	mediation := self createAssociationFrom: kind to: relator.
	mediation applyStereotype: OntoUMLMediation new.	
	mediation memberEnds first upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	mediation memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 2).
	self assert: (self getTestedClass basicNew getUpperBoundMultiplicityOf: mediation for: { kind. }) equals: Float infinity.
	self assert: (self getTestedClass basicNew getUpperBoundMultiplicityOf: mediation for: { relator. }) equals: 2.
	mediation memberEnds first upperValue: (OPUMLLiteralUnlimitedNatural new value: 'test').
	self assert: (self getTestedClass basicNew getUpperBoundMultiplicityOf: mediation for: { kind. }) equals: 0.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testInvalidModel [
	| kind firstRole secondRole relator firstMediation secondMediation firstGeneralization secondGeneralization model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	firstRole := self createClass: 'firstRole' withStereotype: OntoUMLRole.
	secondRole := self createClass: 'secondRole' withStereotype: OntoUMLRole.
	firstGeneralization := self createGeneralizationFor: kind withSpecific: firstRole.
	secondGeneralization := self createGeneralizationFor: kind withSpecific: secondRole.
	firstMediation := self createAssociationFrom: firstRole to: relator.
	firstMediation applyStereotype: OntoUMLMediation new.
	firstMediation memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 2).
	secondMediation := self createAssociationFrom: secondRole to: relator.
	secondMediation applyStereotype: OntoUMLMediation new.
	secondMediation memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	model := { kind. firstRole. secondRole. relator. firstMediation. secondMediation. firstGeneralization. secondGeneralization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testValidModel [
	| kind firstRole secondRole relator firstMediation secondMediation firstGeneralization secondGeneralization model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	firstRole := self createClass: 'firstRole' withStereotype: OntoUMLRole.
	secondRole := self createClass: 'secondRole' withStereotype: OntoUMLRole.
	firstGeneralization := self createGeneralizationFor: kind withSpecific: firstRole.
	secondGeneralization := self createGeneralizationFor: kind withSpecific: secondRole.
	firstMediation := self createAssociationFrom: firstRole to: relator.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondMediation := self createAssociationFrom: secondRole to: relator.
	secondMediation applyStereotype: OntoUMLMediation new.
	model := { kind. firstRole. secondRole. relator. firstMediation. secondMediation. firstGeneralization. secondGeneralization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
RepRelAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
