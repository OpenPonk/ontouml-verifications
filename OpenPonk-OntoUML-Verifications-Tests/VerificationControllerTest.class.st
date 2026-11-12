"
Tests the OntoUML verification controller coordinating model diagnostics and feedback visualizers.
"
Class {
	#name : 'VerificationControllerTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Controllers',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Controllers'
}

{ #category : 'tests' }
VerificationControllerTest >> testExampleBloodDonationPassesVerificationsAndAntipatterns [
	| model controller verifyResults antipatternResults classStereotypes associationStereotypes |
	model := OntoUMLExamples exampleBloodDonation.
	controller := VerificationController new.
	verifyResults := controller verify: model.
	antipatternResults := controller detectAntiPatternsIn: model.
	self assertEmpty: verifyResults results.
	self assertEmpty: antipatternResults results.
	classStereotypes := ((model packagedElements select: [ :each | each isKindOf: OPUMLClass ])
		collect: [ :each | (OntoUMLModelQuery getStereotypeClass: each) ]) asSet.
	self
		assertCollection: classStereotypes
		includesAll: {
			OntoUMLCategory . OntoUMLMixin . OntoUMLRoleMixin . OntoUMLPhaseMixin .
			OntoUMLKind . OntoUMLSubKind . OntoUMLPhase . OntoUMLRole .
			OntoUMLCollective . OntoUMLQuantity . OntoUMLRelator . OntoUMLMode . OntoUMLQuality }.
	associationStereotypes := ((model packagedElements select: [ :each | each isKindOf: OPUMLAssociation ])
		collect: [ :each | (OntoUMLModelQuery getStereotypeClass: each) ]) asSet.
	self
		assertCollection: associationStereotypes
		includesAll: {
			OntoUMLMediation . OntoUMLMaterial . OntoUMLCharacterization .
			OntoUMLMemberOf . OntoUMLSubCollectionOf . OntoUMLSubQuantityOf .
			OntoUMLContainment . OntoUMLComponentOf . OntoUMLDomainFormal }
]

{ #category : 'tests' }
VerificationControllerTest >> testExampleRoleMixinPatternPassesVerificationsAndAntipatterns [
	| model controller verifyResults antipatternResults |
	model := OntoUMLExamples exampleRoleMixinPattern1.
	controller := VerificationController new.
	verifyResults := controller verify: model.
	antipatternResults := controller detectAntiPatternsIn: model.
	self assertEmpty: verifyResults results.
	self assertEmpty: antipatternResults results
]

{ #category : 'tests' }
VerificationControllerTest >> testGetAntiPatternVerifications [

	| controller antiPatternVerifications |
	controller := VerificationController new.
	antiPatternVerifications := controller getAntiPatternVerifications.
	self assert: (antiPatternVerifications isKindOf: Collection).
	self assert: antiPatternVerifications isEmpty equals: false.
	self
		assert:
			(antiPatternVerifications allSatisfy: [ :verificationClass |
				 verificationClass packageTag name = 'Antipattern-Classes' ])
		equals: true
]

{ #category : 'tests' }
VerificationControllerTest >> testGetVerifications [

	| controller verifications |
	controller := VerificationController new.
	verifications := controller getVerifications.
	self assert: (verifications isKindOf: Collection).
	self assert: verifications isEmpty equals: false.
	self
		assert: (verifications anySatisfy: [ :verificationClass |
				 verificationClass = Verification ])
		equals: true.
	self
		assert: (verifications allSatisfy: [ :verificationClass |
				 verificationClass packageTag name = 'Verification-Classes' ])
		equals: true
]

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
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

{ #category : 'tests' }
VerificationControllerTest >> testVerifyUnconnectedRoleProducesSingleErrorAndMemberOfRoleIsValid [
	| kind collective unconnectedRole memberRole gen1 gen2 memberOf model controller results memberRoleErrors unconnectedRoleErrors |
	kind := OPUMLClass new name: 'Person'; applyStereotype: OntoUMLKind new.
	collective := OPUMLClass new name: 'MedicalStaff'; applyStereotype: OntoUMLCollective new.
	unconnectedRole := OPUMLClass new name: 'UnconnectedRole'; applyStereotype: OntoUMLRole new.
	memberRole := OPUMLClass new name: 'Nurse'; applyStereotype: OntoUMLRole new.
	gen1 := OPUMLGeneralization new general: kind; specific: unconnectedRole.
	gen2 := OPUMLGeneralization new general: kind; specific: memberRole.
	memberOf := OPUMLAssociation new.
	OPUMLProperty new
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: memberOf;
		type: collective.
	OPUMLProperty new
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: memberOf;
		type: memberRole.
	memberOf memberEnds addAll: memberOf ownedEnds.
	memberOf applyStereotype: OntoUMLMemberOf new.
	model := OPUMLPackage new.
	model packagedElements addAll: { kind . collective . unconnectedRole . memberRole . gen1 . gen2 . memberOf }.
	controller := VerificationController new.
	results := controller verify: model.
	memberRoleErrors := results results select: [ :each | each objectReference = memberRole ].
	unconnectedRoleErrors := results results select: [ :each | each objectReference = unconnectedRole ].
	self assertEmpty: memberRoleErrors.
	self assert: unconnectedRoleErrors size equals: 1
]
