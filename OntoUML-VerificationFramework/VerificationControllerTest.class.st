Class {
	#name : #VerificationControllerTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationFramework-Controllers'
}

{ #category : #tests }
VerificationControllerTest >> testGetAntiPatternVerifications [
	| controller antiPatternVerifications  |
	controller := VerificationController new.
	antiPatternVerifications := controller getAntiPatternVerifications.
	self assert: (antiPatternVerifications isKindOf: Collection).
	self assert: (antiPatternVerifications isEmpty) equals: false.
	self assert: (antiPatternVerifications allSatisfy: [ :verificationClass | verificationClass tags asSet includes: 'Antipattern-Classes'. ]) equals: true.
]

{ #category : #tests }
VerificationControllerTest >> testGetVerifications [
	| controller verifications |
	controller := VerificationController new.
	verifications := controller getVerifications.
	self assert: (verifications isKindOf: Collection).
	self assert: (verifications isEmpty) equals: false.
	self assert: (verifications anySatisfy: [ :verificationClass | verificationClass = Verification ]) equals: true.
	self assert: (verifications allSatisfy: [ :verificationClass | verificationClass tags asSet includes: 'Verification-Classes'. ]) equals: true.
]

{ #category : #tests }
VerificationControllerTest >> testGetVerifiedObjects [
	| model kind subkind generalization note controller collection |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	generalization := OPUMLGeneralization new.
	generalization general: kind.
	generalization specific: subkind.
	note := OPUMLNode new.
	model := OPUMLPackage new.
	collection  := {kind. subkind. generalization. note.} asOrderedCollection.
	model packagedElements: collection.
	collection := {kind. subkind. generalization.} asOrderedCollection.
	controller := VerificationController new.
	self assert: (controller getVerifiedObjects: model) equals: collection.
]

{ #category : #tests }
VerificationControllerTest >> testVerify [
	| kind subkind controller array results model |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new applyStereotype: OntoUMLSubKind new.	
	array := {kind. subkind}.
	model := OPUMLPackage new.
	model packagedElements: array.
	controller := VerificationController new.
	results := controller verify:model.
	self assert: (results isKindOf: VerificationResults) equals: true.
	self assert: (results hasErrors: kind) equals: false.
	self assert: (results hasErrors: subkind) equals: true.
]

{ #category : #tests }
VerificationControllerTest >> testVerifySingleObjectWithVerificationsWithModelWithResults [
	| kind subkind controller array results |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new applyStereotype: OntoUMLSubKind new.	
	array := {kind. subkind}.
	controller := VerificationController new.
	results := VerificationResults new.
	controller verifySingleObject: kind withVerifications: controller getVerifications withModel: array withResults: results.
	self assert: (results results) isEmpty equals: true.
	controller verifySingleObject: subkind withVerifications: controller getVerifications withModel: array withResults: results.
	self assert: (results hasErrors: subkind) equals: true.
]
