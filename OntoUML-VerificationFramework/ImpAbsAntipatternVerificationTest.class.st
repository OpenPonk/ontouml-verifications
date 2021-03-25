Class {
	#name : #ImpAbsAntipatternVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> getTestedClass [
	^ ImpAbsAntipatternVerification.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testCheckNumberOfChildrenForFrom [
	| source taget directChildA directChildB indirectChild association directGenA directGenB indirectGen model |
	source := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	taget := self createClass: 'tagetA' withStereotype: OntoUMLKind.	
	directChildA := self createClass: 'directChildA' withStereotype: OntoUMLSubKind.
	directChildB := self createClass: 'directChildB' withStereotype: OntoUMLSubKind.
	indirectChild := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	directGenA := self createGeneralizationFor: source withSpecific: directChildA.
	directGenB := self createGeneralizationFor: source withSpecific: directChildB.
	indirectGen := self createGeneralizationFor: directChildA withSpecific: indirectChild.	
	association := self createAssociationFrom: source to: taget.
	model := { source. taget. directChildA. directChildB. indirectChild. association. directGenA. indirectGen. }.
	self assert: (self getTestedClass basicNew checkNumberOfChildrenFor: association memberEnds first from: model) equals: false.
	model := { source. taget. directChildA. directChildB. indirectChild. association. directGenA. directGenB. indirectGen. }. 
	self assert: (self getTestedClass basicNew checkNumberOfChildrenFor: association memberEnds first from: model) equals: true.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testCheckUpperMultiplicityFor [
	| kindA kindB association end testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	kindA := self createClass: 'kindA' withStereotype: OntoUMLKind.
	kindB := self createClass: 'kindB' withStereotype: OntoUMLKind.
	association := self createAssociationFrom: kindA to: kindB.
	end := association memberEnds second.
	end upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	self assert: (testedClassInstance checkUpperMultiplicityFor: end) equals: true.
	end upperValue value: 2.
	self assert: (testedClassInstance checkUpperMultiplicityFor: end) equals: true.
	end upperValue value: 1.
	self assert: (testedClassInstance checkUpperMultiplicityFor: end) equals: false.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testInvalidModel [
	| source taget childA childB association generalizationA generalizationB model result |
	source := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	taget := self createClass: 'tagetA' withStereotype: OntoUMLKind.	
	childA := self createClass: 'sourceB' withStereotype: OntoUMLSubKind.
	childB := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	generalizationA := self createGeneralizationFor: taget withSpecific: childA.
	generalizationB := self createGeneralizationFor: taget withSpecific: childB.	
	association := self createAssociationFrom: source to: taget.
	association memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: '*').
	model := { source. taget. childA. childB. association. generalizationA. generalizationB. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testValidModel [
	| source taget childA childB association generalizationA generalizationB model result |
	source := self createClass: 'sourceA' withStereotype: OntoUMLKind.
	taget := self createClass: 'tagetA' withStereotype: OntoUMLKind.	
	childA := self createClass: 'sourceB' withStereotype: OntoUMLSubKind.
	childB := self createClass: 'targetB' withStereotype: OntoUMLSubKind.
	generalizationA := self createGeneralizationFor: taget withSpecific: childA.
	generalizationB := self createGeneralizationFor: taget withSpecific: childB.	
	association := self createAssociationFrom: source to: taget.
	association memberEnds second upperValue: (OPUMLLiteralUnlimitedNatural new value: 1).
	model := { source. taget. childA. childB. association. generalizationA. generalizationB. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #constants }
ImpAbsAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
