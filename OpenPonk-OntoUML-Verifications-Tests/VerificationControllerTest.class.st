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
VerificationControllerTest >> testDetectAntiPatternsInModelWithAntipattern [

	| kindA kindB formal model controller results |
	kindA := OPUMLClass new
		         name: 'Person';
		         applyStereotype: OntoUMLKind new.
	kindB := OPUMLClass new
		         name: 'Car';
		         applyStereotype: OntoUMLKind new.
	formal := OPUMLAssociation new.
	OPUMLProperty new
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: formal;
		type: kindA.
	OPUMLProperty new
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: formal;
		type: kindB.
	formal memberEnds addAll: formal ownedEnds.
	formal applyStereotype: OntoUMLDomainFormal new.
	model := OPUMLPackage new.
	model packagedElements addAll: {
			kindA.
			kindB.
			formal }.
	controller := VerificationController new.
	results := controller detectAntiPatternsIn: model.
	self
		assert: (results hasWarnings: formal)
		description: 'UndefFormal antipattern should be detected on DomainFormal between Kinds without attributes'
]

{ #category : 'tests' }
VerificationControllerTest >> testExampleBloodDonationPassesVerificationsAndAntipatterns [

	| model controller verifyResults antipatternResults classStereotypes associationStereotypes |
	model := OntoUMLExamples exampleBloodDonation.
	controller := VerificationController new.
	verifyResults := controller verify: model.
	antipatternResults := controller detectAntiPatternsIn: model.
	self assertEmpty: verifyResults results.
	self assertEmpty: antipatternResults results.
	classStereotypes := (model packagedElements
		                     select: [ :each | each isKindOf: OPUMLClass ]
		                     thenCollect: [ :each | OntoUMLModelQuery getStereotypeClass: each ]) asSet.
	self assertCollection: classStereotypes includesAll: {
			OntoUMLCategory.
			OntoUMLMixin.
			OntoUMLRoleMixin.
			OntoUMLPhaseMixin.
			OntoUMLKind.
			OntoUMLSubKind.
			OntoUMLPhase.
			OntoUMLRole.
			OntoUMLCollective.
			OntoUMLQuantity.
			OntoUMLRelator.
			OntoUMLMode.
			OntoUMLQuality }.
	associationStereotypes := (model packagedElements
		                           select: [ :each | each isKindOf: OPUMLAssociation ]
		                           thenCollect: [ :each | OntoUMLModelQuery getStereotypeClass: each ]) asSet.
	self assertCollection: associationStereotypes includesAll: {
			OntoUMLMediation.
			OntoUMLMaterial.
			OntoUMLCharacterization.
			OntoUMLMemberOf.
			OntoUMLSubCollectionOf.
			OntoUMLSubQuantityOf.
			OntoUMLContainment.
			OntoUMLComponentOf.
			OntoUMLDomainFormal }
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
	self assertCollection: antiPatternVerifications hasSameElements: {
			ImpAbsAntipatternVerification.
			DepPhaseAntipatternVerification.
			PartOverAntipatternVerification.
			GSRigAntipatternVerification.
			UndefPhaseAntipatternVerification.
			DecIntAntipatternVerification.
			BinOverAntipatternVerification.
			WholeOverAntipatternVerification.
			MultDepAntipatternVerification.
			UndefFormalAntipatternVerification.
			MixRigAntipatternVerification.
			MixIdenAntipatternVerification.
			RepRelAntipatternVerification.
			HomoFuncAntipatternVerification.
			RelSpecAntipatternVerification.
			HetCollAntipatternVerification.
			RelRigAntipatternVerification.
			RelCompAntipatternVerification.
			FreeRoleAntipatternVerification.
			RelOverAntipatternVerification }.
	self
		assert: (antiPatternVerifications allSatisfy: [ :verificationClass | verificationClass packageTagName = 'Antipattern-Classes' ])
		description: 'All antipattern verifications must belong to tag Antipattern-Classes'
]

{ #category : 'tests' }
VerificationControllerTest >> testGetVerifications [

	| controller verifications |
	controller := VerificationController new.
	verifications := controller getVerifications.
	self assertCollection: verifications hasSameElements: {
			Verification.
			StereotypeVerification.
			RelationEndVerification.
			RelationDependencyVerification.
			AllowedSubtypesVerification.
			AllowedSupertypesVerification.
			CharacterizedVerification.
			IdentityRequiredVerification.
			PartOfGeneralizationSetVerification.
			RelationSourceVerification.
			RelationTargetVerification.
			RelatorMediationDependencyVerification }.
	self
		assert: (verifications allSatisfy: [ :verificationClass | verificationClass packageTagName = 'Verification-Classes' ])
		description: 'All verification classes must belong to tag Verification-Classes'
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
VerificationControllerTest >> testGetVerifiedObjectsIncludesAssociationAndGeneralizationSet [

	| model kind subkind association generalization generalizationSet note controller verifiedObjects |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	generalization := OPUMLGeneralization new
		                  general: kind;
		                  specific: subkind;
		                  yourself.
	generalizationSet := OPUMLGeneralizationSet new
		                     generalizations: { generalization };
		                     yourself.
	association := OPUMLAssociation new.
	note := OPUMLNode new.
	model := OPUMLPackage new.
	model packagedElements addAll: {
			kind.
			subkind.
			association.
			generalizationSet.
			note }.
	controller := VerificationController new.
	verifiedObjects := controller getVerifiedObjects: model.
	self assertCollection: verifiedObjects hasSameElements: {
			kind.
			subkind.
			association.
			generalization.
			generalizationSet }
]

{ #category : 'tests' }
VerificationControllerTest >> testIsVerifiableIncludeGeneralizations [

	| umlClass association generalization node |
	umlClass := OPUMLClass new.
	association := OPUMLAssociation new.
	generalization := OPUMLGeneralization new.
	node := OPUMLNode new.
	self
		assert: (VerificationController isVerifiable: umlClass includeGeneralizations: false)
		description: 'OPUMLClass must be verifiable even when generalizations are excluded'.
	self
		assert: (VerificationController isVerifiable: association includeGeneralizations: false)
		description: 'OPUMLAssociation must be verifiable even when generalizations are excluded'.
	self
		deny: (VerificationController isVerifiable: generalization includeGeneralizations: false)
		description: 'OPUMLGeneralization must not be verifiable when generalizations are excluded'.
	self
		assert: (VerificationController isVerifiable: generalization includeGeneralizations: true)
		description: 'OPUMLGeneralization must be verifiable when generalizations are included'.
	self
		deny: (VerificationController isVerifiable: node includeGeneralizations: true)
		description: 'OPUMLNode must not be verifiable even when generalizations are included'
]

{ #category : 'tests' }
VerificationControllerTest >> testVerify [

	| kind subkind controller array results model |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	array := {
		         kind.
		         subkind }.
	model := OPUMLPackage new.
	model packagedElements: array.
	controller := VerificationController new.
	results := controller verify: model.
	self assert: results class identicalTo: VerificationResults.
	self deny: (results hasErrors: kind) description: 'Kind should have no verification errors'.
	self assert: (results hasErrors: subkind) description: 'SubKind without supertype should produce verification errors'
]

{ #category : 'tests' }
VerificationControllerTest >> testVerifySingleObjectWithVerificationsWithModelWithResults [

	| kind subkind controller array results |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	subkind := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	array := {
		         kind.
		         subkind }.
	controller := VerificationController new.
	results := VerificationResults new.
	controller
		verifySingleObject: kind
		withVerifications: controller getVerifications
		withModel: array
		withResults: results.
	self assertEmpty: results results.
	controller
		verifySingleObject: subkind
		withVerifications: controller getVerifications
		withModel: array
		withResults: results.
	self assert: (results hasErrors: subkind) description: 'SubKind without supertype should produce verification errors'
]

{ #category : 'tests' }
VerificationControllerTest >> testVerifyUnconnectedRoleProducesSingleErrorAndMemberOfRoleIsValid [

	| kind collective unconnectedRole memberRole gen1 gen2 memberOf model controller results memberRoleErrors unconnectedRoleErrors error |
	kind := OPUMLClass new
		        name: 'Person';
		        applyStereotype: OntoUMLKind new.
	collective := OPUMLClass new
		              name: 'MedicalStaff';
		              applyStereotype: OntoUMLCollective new.
	unconnectedRole := OPUMLClass new
		                   name: 'UnconnectedRole';
		                   applyStereotype: OntoUMLRole new.
	memberRole := OPUMLClass new
		              name: 'Nurse';
		              applyStereotype: OntoUMLRole new.
	gen1 := OPUMLGeneralization new
		        general: kind;
		        specific: unconnectedRole.
	gen2 := OPUMLGeneralization new
		        general: kind;
		        specific: memberRole.
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
	model packagedElements addAll: {
			kind.
			collective.
			unconnectedRole.
			memberRole.
			gen1.
			gen2.
			memberOf }.
	controller := VerificationController new.
	results := controller verify: model.
	memberRoleErrors := results results select: [ :each | each objectReference = memberRole ].
	unconnectedRoleErrors := results results select: [ :each | each objectReference = unconnectedRole ].
	self assertEmpty: memberRoleErrors.
	self assert: unconnectedRoleErrors size equals: 1.
	error := unconnectedRoleErrors anyOne.
	self assert: error class identicalTo: VerificationMessageError.
	self assert: error verification class identicalTo: RelationDependencyVerification.
	self assert: error objectReference identicalTo: unconnectedRole.
	self
		assert: error messageText
		equals:
		'OntoUMLRole has to have at least one association stereotyped as mediation, material, componentOf, memberOf or subCollectionOf, with multiplicities on both ends >= 1.'.
	self assert: error documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/classes/sortals/role/index.html'
]
