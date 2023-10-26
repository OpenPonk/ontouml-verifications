"
I represent tests for FreeRoleAntipatternVerification.
"
Class {
	#name : #FreeRoleAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
FreeRoleAntipatternVerificationTest >> getTestedClass [
	^ FreeRoleAntipatternVerification.
]

{ #category : #constants }
FreeRoleAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
FreeRoleAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRole. }.
]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testFulfillsMediationDependency [
	| kind relator mediation sourceEnd targetEnd testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	relator := self createClass: 'relator' withStereotype: OntoUMLRelator.
	mediation := self createAssociationFrom: kind to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	sourceEnd := mediation memberEnds first.
	targetEnd := mediation memberEnds second.
	sourceEnd lowerValue value: 1.
	targetEnd lowerValue value: 1.
	self assert: (testedClassInstance fulfillsRelationalDependency: mediation) equals: true.
	targetEnd lowerValue value: (OPUMLLiteralUnlimitedNatural new value: '*').
	self assert: (testedClassInstance fulfillsRelationalDependency: mediation) equals: true.
	sourceEnd lowerValue value: 0.
	targetEnd lowerValue value: 1.
	self assert: (testedClassInstance fulfillsRelationalDependency: mediation) equals: false.
	sourceEnd lowerValue value: 1.
	targetEnd lowerValue value: 0.
	self assert: (testedClassInstance fulfillsRelationalDependency: mediation) equals: false.
	sourceEnd lowerValue value: 0.
	self assert: (testedClassInstance fulfillsRelationalDependency: mediation) equals: false.

]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testInvalidModel [
	| kind parentRole childRole relator mediation firstGeneralization secondGeneralization model result |
	kind := self createClass: 'kind'  withStereotype: OntoUMLKind.
	parentRole := self createClass: 'parentRole'  withStereotype: OntoUMLRole.
	childRole := self createClass: 'childRole'  withStereotype: OntoUMLRole.
	relator := self createClass: 'relator'  withStereotype: OntoUMLRelator.
	firstGeneralization := self createGeneralizationFor: kind withSpecific: parentRole.
	secondGeneralization := self createGeneralizationFor: parentRole withSpecific: childRole.
	mediation := self createAssociationFrom: parentRole to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	
	model := { kind. parentRole. childRole. relator. mediation. firstGeneralization. secondGeneralization.}.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: childRole withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testValidModel [
	| kind role relator mediation firstGeneralization model result |
	kind := self createClass: 'kind'  withStereotype: OntoUMLKind.
	role := self createClass: 'role'  withStereotype: OntoUMLRole.
	relator := self createClass: 'relator'  withStereotype: OntoUMLRelator.
	firstGeneralization := self createGeneralizationFor: kind withSpecific: role.
	mediation := self createAssociationFrom: role to: relator.
	mediation applyStereotype: OntoUMLMediation new.
	model := { kind. role. relator. mediation. firstGeneralization.}.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
FreeRoleAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
