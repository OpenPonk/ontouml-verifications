"
I represent tests for IdentityRequiredVerification.
"
Class {
	#name : #IdentityRequiredVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Verification-Tests'
}

{ #category : #constants }
IdentityRequiredVerificationTest >> getExpectedUpdatedMessageCode [
	^ '"I return list of all OntoUML identity providers." 
identityProviders
	^ { OntoUMLKind. OntoUMLQuality. OntoUMLTest. }'.
]

{ #category : #constants }
IdentityRequiredVerificationTest >> getMockVerificationUpdater [
	| mockUpdater |
	mockUpdater := OntoUMLVerificationUpdater new.
	mockUpdater classSpecifications: { (MockOntoUMLClassStereotypeYaml new name: 'Kind') providesIdentity: 'true'. 
		(MockOntoUMLClassStereotypeYaml new name: 'Mode') providesIdentity: 'false'.
		(MockOntoUMLClassStereotypeYaml new name: 'Quality') providesIdentity: 'true'.
		(MockOntoUMLClassStereotypeYaml new name: 'Test') providesIdentity: 'true'. }.
 	^ mockUpdater.
]

{ #category : #constants }
IdentityRequiredVerificationTest >> getTestedClass [
	^ IdentityRequiredVerification.
]

{ #category : #constants }
IdentityRequiredVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
IdentityRequiredVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLSubKind. OntoUMLPhase. OntoUMLRole.}.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> invalidObjectTest [
	| kind subkind generalization model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new.
	subkind applyStereotype: OntoUMLSubKind new.
	generalization := OPUMLGeneralization new.
	generalization general: kind.
	generalization specific: subkind.
	model := { kind. subkind. generalization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: subkind withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testCountIdentitySourcesFromModelWithAccumulator [
	| kind kind2 role model gen1 gen2 |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	kind2 := OPUMLClass new applyStereotype: OntoUMLKind new.
	role := OPUMLClass new applyStereotype: OntoUMLRole new.
	gen1 := OPUMLGeneralization new.
	gen2 := OPUMLGeneralization new.
	gen1 general: kind; specific: role.
	gen2 general: kind2; specific: role.
	model := { kind. kind2. role. gen1. gen2. }.	
	self assert: (self getTestedClass basicNew countIdentitySources: role fromModel: model withAccumulator: Set new) equals: 2.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testGetSuperClassesFromModel [
	| kind subkind role model gen1 gen2 |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	role := OPUMLClass new applyStereotype: OntoUMLRole new.
	gen1 := OPUMLGeneralization new.
	gen2 := OPUMLGeneralization new.
	gen1 general: kind; specific: subkind.
	gen2 general: subkind; specific: role.
	model := { kind. subkind. role. gen1. gen2. }.	
	self assert: ((self getTestedClass basicNew getSuperClasses: role fromModel: model) at:1) equals: subkind.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testGetUpdatedMessageCode [
	| mockVerificationUpdater updatedCode |
	mockVerificationUpdater := self getMockVerificationUpdater.
	updatedCode := self getTestedClass getUpdatedMessageCode: mockVerificationUpdater.
	self assert: updatedCode equals: self getExpectedUpdatedMessageCode.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testHasIdentity [
	| kind subkind |
	kind := OntoUMLKind new.
	subkind := OntoUMLSubKind new.
	self assert: (self getTestedClass basicNew hasIdentity: kind) equals: true. 
	self assert: (self getTestedClass basicNew hasIdentity: subkind) equals: false.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testIdentityProviders [
	self assert: (self getTestedClass identityProviders isKindOf: Collection) equals: true.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifyObjectWithModel [
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifyWithModel [
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
IdentityRequiredVerificationTest >> validObjectTest [
	| kind subkind generalization model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new.
	subkind applyStereotype: OntoUMLSubKind new.
	generalization := OPUMLGeneralization new.
	generalization general: subkind.
	generalization specific: kind.
	model := { kind. subkind. generalization. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: subkind withModel: model).
	self assert: result results size equals: 1.
]