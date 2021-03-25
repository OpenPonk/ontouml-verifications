Class {
	#name : #BinOverAntipatternVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
BinOverAntipatternVerificationTest >> getTestedClass [
	^ BinOverAntipatternVerification.
]

{ #category : #constants }
BinOverAntipatternVerificationTest >> getVerifiedClass [
 ^ OPUMLAssociation.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testInvalidModel [
	| kind association model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	kind name: 'kind'.
	association := self createAssociationFrom: kind to: kind.
	model := { kind. association. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: result results size equals: 1.
	self assert: (result results anySatisfy: [ :message | message isKindOf: VerificationMessageWarning. ]).
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testValidModel [
	| kind secondKind association model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	kind name: 'kind'.
	secondKind := OPUMLClass new.
	secondKind applyStereotype: OntoUMLKind new.
	secondKind name: 'secondKind'.
	association := self createAssociationFrom: kind to: secondKind.
	model := { kind. secondKind. association. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: association withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
BinOverAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
