"
I represent tests for RelOverAntipatternVerification.
"
Class {
	#name : #RelOverAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #tests }
RelOverAntipatternVerificationTest >> getInvalidModel [
	| relator kind subkind firstMediation secondMediation generalization |
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	subkind := self createClass: 'subkind' withStereotype: OntoUMLKind.	
	firstMediation := self createAssociationFrom: relator to: kind.
	firstMediation applyStereotype: OntoUMLMediation new.
	firstMediation memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 2).
	secondMediation := self createAssociationFrom: relator to: subkind.
	secondMediation applyStereotype: OntoUMLMediation new.
	subkind := self createAssociationFrom: relator to: subkind.
	subkind applyStereotype: OntoUMLMediation new.
	generalization := self createGeneralizationFor: kind withSpecific: subkind.
	^ { relator. kind. subkind. firstMediation. firstMediation. generalization .}.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> getTestedClass [
	^ RelOverAntipatternVerification.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> getValidModel [
	| relator firstKind secondKind firstMediation secondMediation |
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	firstKind := self createClass: 'firstKind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.	
	firstMediation := self createAssociationFrom: relator to: firstKind.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondMediation := self createAssociationFrom: relator to: secondKind.
	secondMediation applyStereotype: OntoUMLMediation new.
	^ { relator. firstKind. secondKind. firstMediation. secondMediation. }.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testCheckForOverlap [
	| relator mediatedObjects model testedClass |
	testedClass := self getTestedClass basicNew.
	model := self getValidModel.
	relator := ((model select: [ :object | object isKindOf: OPUMLClass. ]) select: [ :entity | entity name = 'relator' ]) first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model. 
	self assert: (testedClass checkForOverlap: mediatedObjects) equals: false.
	
	model := self getInvalidModel.
	relator := ((model select: [ :object | object isKindOf: OPUMLClass. ]) select: [ :entity | entity name = 'relator' ]) first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model. 
	self assert: (testedClass checkForOverlap: mediatedObjects) equals: true.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testCheckUpperMultiplicityFor [
	| relator mediatedObjects model testedClass |
	testedClass := self getTestedClass basicNew.
	model := self getValidModel.
	relator := ((model select: [ :object | object isKindOf: OPUMLClass. ]) select: [ :entity | entity name = 'relator' ]) first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model. 
	self assert: (testedClass checkUpperMultiplicityFor: mediatedObjects) equals: false.
	
	model := self getInvalidModel.
	relator := ((model select: [ :object | object isKindOf: OPUMLClass. ]) select: [ :entity | entity name = 'relator' ]) first.
	mediatedObjects := testedClass getMediatedEndsFor: relator from: model. 
	self assert: (testedClass checkUpperMultiplicityFor: mediatedObjects) equals: true.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testGetMediatedEndsForFrom [	
	| relator mediatedObjects model |
	model := self getValidModel.
	relator := ((model select: [ :object | object isKindOf: OPUMLClass. ]) select: [ :entity | entity name = 'relator' ]) first.
	mediatedObjects := ((model select: [ :object | object isKindOf: OPUMLAssociation. ])
		collect: [ :association | association memberEnds second. ]) asOrderedCollection.
	self assert: (self getTestedClass basicNew getMediatedEndsFor: relator from: model) asOrderedCollection equals: mediatedObjects.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testInvalidModel [
	| relator model result |	
	model := self getInvalidModel.
	relator := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testValidModel [
	| relator model result |	
	model := self getValidModel.
	relator := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
RelOverAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
