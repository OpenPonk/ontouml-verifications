"
I represent tests for MixIdenAntipatternVerification.
"
Class {
	#name : #MixIdenAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
MixIdenAntipatternVerificationTest >> getTestedClass [
	^ MixIdenAntipatternVerification.
]

{ #category : #constants }
MixIdenAntipatternVerificationTest >> getVerifiedClass [
 ^ OPUMLClass.
]

{ #category : #constants }
MixIdenAntipatternVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLMixin. OntoUMLRoleMixin. OntoUMLCategory.}.
]

{ #category : #tests }
MixIdenAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : #tests }
MixIdenAntipatternVerificationTest >> testInvalidModel [
	| nonsortal sortalA sortalB identityProvider genIA genIB genNA genNB model result |
	sortalA := self createClass: 'sortalA' withStereotype: OntoUMLSubKind.
	sortalB := self createClass: 'sortalB' withStereotype: OntoUMLSubKind.	
	nonsortal := self createClass: 'nonsortal' withStereotype: OntoUMLCategory.	
	identityProvider := self createClass: 'identityProvider' withStereotype: OntoUMLKind.
	genIA := self createGeneralizationFor: identityProvider withSpecific: sortalA.
	genIB := self createGeneralizationFor: identityProvider withSpecific: sortalB.
	genNA := self createGeneralizationFor: nonsortal withSpecific: sortalA.
	genNB := self createGeneralizationFor: nonsortal withSpecific: sortalB.
	model := { nonsortal. sortalA. sortalB. identityProvider. genIA. genIB. genNA. genNB. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: nonsortal withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
MixIdenAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
MixIdenAntipatternVerificationTest >> testValidModel [
	| nonsortal sortalA sortalB identityProviderA identityProviderB genIA genIB genNA genNB model result |
	sortalA := self createClass: 'sortalA' withStereotype: OntoUMLSubKind.
	sortalB := self createClass: 'sortalB' withStereotype: OntoUMLSubKind.	
	nonsortal := self createClass: 'nonsortal' withStereotype: OntoUMLCategory.	
	identityProviderA := self createClass: 'identityProviderA' withStereotype: OntoUMLKind.
	identityProviderB := self createClass: 'identityProviderB' withStereotype: OntoUMLKind.
	genIA := self createGeneralizationFor: identityProviderA withSpecific: sortalA.
	genIB := self createGeneralizationFor: identityProviderB withSpecific: sortalB.
	genNA := self createGeneralizationFor: nonsortal withSpecific: sortalA.
	genNB := self createGeneralizationFor: nonsortal withSpecific: sortalB.
	model := { nonsortal. sortalA. sortalB. identityProviderA. identityProviderB. genIA. genIB. genNA. genNB. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: nonsortal withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
MixIdenAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
MixIdenAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
MixIdenAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
