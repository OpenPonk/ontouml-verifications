"
I represent tests for Verification.
"
Class {
	#name : 'VerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
VerificationTest >> getTestedClass [
	^ Verification.
]

{ #category : 'constants' }
VerificationTest >> getVerifiedClass [
	^ nil.
]

{ #category : 'constants' }
VerificationTest >> getVerifiedClassInstance [
	^ nil.
]

{ #category : 'tests' }
VerificationTest >> testAbbreviations [

	self assert: Verification abbreviation equals: 'Verification'.
	self assert: StereotypeVerification abbreviation equals: 'StereotypeVerification'.
	self assert: RelationEndVerification abbreviation equals: 'RelationEndVerification'.
	self assert: AllowedSubtypesVerification abbreviation equals: 'AllowedSubtypes'.
	self assert: AllowedSupertypesVerification abbreviation equals: 'AllowedSupertypes'.
	self assert: CharacterizedVerification abbreviation equals: 'Characterized'.
	self assert: IdentityRequiredVerification abbreviation equals: 'IdentityRequired'.
	self assert: PartOfGeneralizationSetVerification abbreviation equals: 'PartOfGenSet'.
	self assert: RelationDependencyVerification abbreviation equals: 'RoleMediationDependency'.
	self assert: RelationSourceVerification abbreviation equals: 'RelationSource'.
	self assert: RelationTargetVerification abbreviation equals: 'RelationTarget'.
	self assert: RelatorMediationDependencyVerification abbreviation equals: 'RelatorMediationDependency'
]

{ #category : 'tests' }
VerificationTest >> testCanVerify [

	self
		deny: (self getTestedClass canVerify: self getNotVerifiedClassInstance)
		description: 'Abstract Verification base class must not verify arbitrary objects'
]

{ #category : 'tests' }
VerificationTest >> testExpandAllowedClassStereotypesInFrom [

	| updater |
	updater := OntoUMLVerificationUpdater new.
	updater classSpecifications: {
			(MockOntoUMLClassStereotypeYaml new name: 'Kind').
			(MockOntoUMLClassStereotypeYaml new name: 'Mode') }.
	self assertCollection: (Verification expandAllowedClassStereotypesIn: 'Role' from: updater) hasSameElements: #( 'Role' ).
	self assertCollection: (Verification expandAllowedClassStereotypesIn: '*' from: updater) hasSameElements: #( 'Kind' 'Mode' ).
	self
		assertCollection: (Verification expandAllowedClassStereotypesIn: #( 'Kind' '*' 'Role' ) from: updater)
		hasSameElements: #( 'Kind' 'Mode' 'Role' )
]

{ #category : 'tests' }
VerificationTest >> testExpandClassStereotypeFrom [

	| updater |
	updater := OntoUMLVerificationUpdater new.
	updater classSpecifications: {
			(MockOntoUMLClassStereotypeYaml new name: 'Kind').
			(MockOntoUMLClassStereotypeYaml new name: 'SubKind') }.
	self assertCollection: (Verification expandClassStereotype: '*' from: updater) hasSameElements: #( 'Kind' 'SubKind' ).
	self
		assertCollection: (Verification expandClassStereotype: 'Functional complex' from: updater)
		hasSameElements: #( 'Kind' 'SubKind' ).
	self assertCollection: (Verification expandClassStereotype: 'Role' from: updater) hasSameElements: #( 'Role' )
]

{ #category : 'tests' }
VerificationTest >> testIsAbstract [

	self assert: Verification isAbstract description: 'Verification base class must be abstract'.
	self assert: StereotypeVerification isAbstract description: 'StereotypeVerification base class must be abstract'.
	self assert: RelationEndVerification isAbstract description: 'RelationEndVerification base class must be abstract'.
	self deny: AllowedSubtypesVerification isAbstract description: 'AllowedSubtypesVerification must be concrete'.
	self deny: IdentityRequiredVerification isAbstract description: 'IdentityRequiredVerification must be concrete'.
	self deny: RelationSourceVerification isAbstract description: 'RelationSourceVerification must be concrete'
]

{ #category : 'tests' }
VerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
VerificationTest >> testStereotypeVerificationDefaults [

	self assertEmpty: StereotypeVerification verifiedStereotypes.
	self
		deny: (StereotypeVerification canVerifyStereotype: OPUMLClass new)
		description: 'StereotypeVerification without concrete stereotypes must reject unstereotyped class'.
	self
		deny: (StereotypeVerification canVerify: OPUMLClass new)
		description: 'Abstract StereotypeVerification must not verify unstereotyped class'
]

{ #category : 'tests' }
VerificationTest >> testVerifiedClass [

	self assert: self getTestedClass verifiedClass identicalTo: self getVerifiedClass
]

{ #category : 'tests' }
VerificationTest >> testVerifyObjectWithModel [

	self assertEmpty: (self getTestedClass verify: self getVerifiedClassInstance withModel: 'dummyModel').
	self should: [ Verification basicNew verifyObject: nil withModel: #(  ) ] raise: SubclassResponsibility
]
