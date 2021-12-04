"
I represent tests for HetCollAntipatternVerification.
"
Class {
	#name : #HetCollAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
HetCollAntipatternVerificationTest >> getTestedClass [
	^ HetCollAntipatternVerification.
]

{ #category : #constants }
HetCollAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
HetCollAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLCollective. }.
]

{ #category : #tests }
HetCollAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
HetCollAntipatternVerificationTest >> testInvalidModel [
	| firstPart secondPart collective firstComponentOf secondComponentOf model result |
	firstPart := self createClass: 'firstPart'  withStereotype: OntoUMLKind.
	secondPart := self createClass: 'secondPart'  withStereotype: OntoUMLKind.
	collective := self createClass: 'collective'  withStereotype: OntoUMLCollective .
	firstComponentOf := self createAssociationFrom: collective to: firstPart.
	firstComponentOf applyStereotype: OntoUMLMemberOf new.
	secondComponentOf := self createAssociationFrom: collective to:  secondPart.
	secondComponentOf applyStereotype: OntoUMLMemberOf new.
	
	model := { firstPart. secondPart. collective. firstComponentOf. secondComponentOf. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: collective withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
HetCollAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
HetCollAntipatternVerificationTest >> testValidModel [
	| part collective componentOf model result |
	part := self createClass: 'part'  withStereotype: OntoUMLKind.
	collective := self createClass: 'collective'  withStereotype: OntoUMLCollective .
	componentOf := self createAssociationFrom: part to: collective.
	componentOf applyStereotype: OntoUMLComponentOf new.
	
	model := { part. collective. componentOf. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: collective withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
HetCollAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
HetCollAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
HetCollAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
