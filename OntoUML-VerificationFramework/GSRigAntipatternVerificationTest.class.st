"
I represent tests for GSRigAntipatternVerification.
"
Class {
	#name : #GSRigAntipatternVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #constants }
GSRigAntipatternVerificationTest >> getTestedClass [
	^ GSRigAntipatternVerification.
]

{ #category : #constants }
GSRigAntipatternVerificationTest >> getVerifiedClass [
 ^ OPUMLGeneralizationSet.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testIncludesAntiRigidSubtype [
	| roleMixin kind mixin genSet |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	mixin := self createClass: 'mixin' withStereotype: OntoUMLMixin.
	roleMixin := self createClass: 'roleMixin' withStereotype: OntoUMLRole.
	genSet := OPUMLGeneralizationSet new.
	genSet generalizations: { 
		self createGeneralizationFor: mixin withSpecific: kind.}.
	self assert: (self getTestedClass basicNew includesAntiRigidSubtype: genSet) equals: false.
	genSet generalizations: { 
		self createGeneralizationFor: mixin withSpecific: roleMixin.
		self createGeneralizationFor: mixin withSpecific: kind. }.
	self assert: (self getTestedClass basicNew includesAntiRigidSubtype: genSet) equals: true.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testIncludesRigidSubtype [
	| role subkindA kind genSet |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	subkindA := self createClass: 'subkindA' withStereotype: OntoUMLSubKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	genSet := OPUMLGeneralizationSet new.
	genSet generalizations: { 
		self createGeneralizationFor: kind withSpecific: role.}.
	self assert: (self getTestedClass basicNew includesRigidSubtype: genSet) equals: false.
	genSet generalizations: { 
		self createGeneralizationFor: kind withSpecific: role.
		self createGeneralizationFor: kind withSpecific: subkindA. }.
	self assert: (self getTestedClass basicNew isSupertypeRigid: genSet) equals: true.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testInvalidModel [
	| kind subkind role genA genB genSet model result |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	subkind := self createClass: 'subkind' withStereotype: OntoUMLSubKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	genA := self createGeneralizationFor: kind withSpecific: subkind.
	genB := self createGeneralizationFor: kind withSpecific: role.
	genSet := OPUMLGeneralizationSet new.
	genSet name: 'genSet'.
	genSet generalizations: { genA. genB. }.
	model := { kind. subkind. role. genA. genB. genSet. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: genSet withModel: model).
	self assert: result results size equals: 2.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testIsSupertypeRigid [
	| role subkindA subkindB kind genSet |
	kind := self createClass: 'kind' withStereotype: OntoUMLKind.
	subkindA := self createClass: 'subkindA' withStereotype: OntoUMLSubKind.
	subkindB := self createClass: 'subkindB' withStereotype: OntoUMLSubKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	genSet := OPUMLGeneralizationSet new.
	genSet generalizations: { 
		self createGeneralizationFor: kind withSpecific: subkindA.
		self createGeneralizationFor: kind withSpecific: subkindB. }.
	self assert: (self getTestedClass basicNew isSupertypeRigid: genSet) equals: true.
	genSet generalizations: { 
		self createGeneralizationFor: kind withSpecific: subkindA.
		self createGeneralizationFor: role withSpecific: subkindB. }.
	self assert: (self getTestedClass basicNew isSupertypeRigid: genSet) equals: false.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testValidModel [
	| mixin subkind role genA genB genSet model result |
	mixin := self createClass: 'mixin' withStereotype: OntoUMLMixin.
	subkind := self createClass: 'subkind' withStereotype: OntoUMLSubKind.
	role := self createClass: 'role' withStereotype: OntoUMLRole.
	genA := self createGeneralizationFor: mixin withSpecific: subkind.
	genB := self createGeneralizationFor: mixin withSpecific: role.
	genSet := OPUMLGeneralizationSet new.
	genSet name: 'genSet'.
	genSet generalizations: { genA. genB. }.
	model := { mixin. subkind. role. genA. genB. genSet. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: genSet withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
GSRigAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
