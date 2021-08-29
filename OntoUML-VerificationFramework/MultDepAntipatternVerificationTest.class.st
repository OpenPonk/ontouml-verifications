"
I represent tests for MultDepAntipatternVerification.
"
Class {
	#name : #MultDepAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
MultDepAntipatternVerificationTest >> getTestedClass [
	^ MultDepAntipatternVerification.
]

{ #category : #constants }
MultDepAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
MultDepAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLKind. OntoUMLQuantity. OntoUMLCollective. OntoUMLRole. OntoUMLPhase. OntoUMLSubKind. OntoUMLCategory. OntoUMLMixin. OntoUMLRoleMixin.}.
]

{ #category : #tests }
MultDepAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : #tests }
MultDepAntipatternVerificationTest >> testInvalidModel [
	| kind secondKind collective firstMediation secondMediation model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	collective := self createClass: 'collective' withStereotype: OntoUMLCollective.
	firstMediation := self createAssociationFrom: kind to: secondKind.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondMediation := self createAssociationFrom: kind to: collective.
	secondMediation applyStereotype: OntoUMLMediation new.
	model := { kind. secondKind. collective. firstMediation. secondMediation. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: kind withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
MultDepAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
MultDepAntipatternVerificationTest >> testValidModel [
	| kind secondKind collective firstMediation secondAssociation model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind' withStereotype: OntoUMLKind.
	collective := self createClass: 'collective' withStereotype: OntoUMLCollective.
	firstMediation := self createAssociationFrom: kind to: secondKind.
	firstMediation applyStereotype: OntoUMLMediation new.
	secondAssociation := self createAssociationFrom: kind to: collective.
	model := { kind. secondKind. collective. firstMediation. secondAssociation. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: secondKind withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
MultDepAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
MultDepAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
