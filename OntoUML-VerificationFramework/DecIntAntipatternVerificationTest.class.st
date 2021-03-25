Class {
	#name : #DecIntAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
DecIntAntipatternVerificationTest >> getTestedClass [
	^ DecIntAntipatternVerification.
]

{ #category : #constants }
DecIntAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
DecIntAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLSubKind. OntoUMLPhase. OntoUMLMode. OntoUMLRole. OntoUMLRelator.}.
]

{ #category : #tests }
DecIntAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
DecIntAntipatternVerificationTest >> testInvalidModel [
	| firstKind secondKind subKind firstGeneralization secondGeneralization model result |
	firstKind := self createClass: 'firstKind'  withStereotype: OntoUMLKind.
	secondKind := self createClass: 'secondKind'  withStereotype: OntoUMLKind.
	subKind := self createClass: 'subKind'  withStereotype: OntoUMLSubKind.	
	firstGeneralization := self createGeneralizationFor: firstKind withSpecific: subKind.
	secondGeneralization := self createGeneralizationFor: secondKind withSpecific: subKind.
		
	model := { firstKind. secondKind. subKind. firstGeneralization. secondGeneralization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: subKind withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning ]) size equals: 1.
]

{ #category : #tests }
DecIntAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
DecIntAntipatternVerificationTest >> testValidModel [
	| kind role rolemixin firstGeneralization secondGeneralization model result |
	kind := self createClass: 'kind'  withStereotype: OntoUMLKind.
	role := self createClass: 'role'  withStereotype: OntoUMLRole.
	rolemixin := self createClass: 'rolemixin'  withStereotype: OntoUMLRoleMixin.	
	firstGeneralization := self createGeneralizationFor: kind withSpecific: role.
	secondGeneralization := self createGeneralizationFor: rolemixin withSpecific: role.
	
	model := { kind. role. rolemixin. firstGeneralization. secondGeneralization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageWarning ]) size equals: 0.
]

{ #category : #tests }
DecIntAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
DecIntAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
DecIntAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
