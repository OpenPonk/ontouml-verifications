"
I represent tests for RelationTargetVerification.
"
Class {
	#name : 'RelationTargetVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OntoUML-VerificationFramework-Verification-Tests',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Verification-Tests'
}

{ #category : 'constants' }
RelationTargetVerificationTest >> getExpectedGetValidTargetsForFromCollection [
	^'"I return association between OntoUML relationship stereotype Characterization and its allowed targets.
I am generated by getValidTargetsFor:FromCollection: and tested by testGetValidTargetsForFromCollection."
validTargetsForCharacterization
	^ OntoUMLCharacterization -> { OntoUMLSubKind. OntoUMLTest. OntoUMLMock. }.'.
]

{ #category : 'constants' }
RelationTargetVerificationTest >> getExpectedUpdatedMessageCode [
	^'"I return dictionary containing collections of allowed targets for each OntoUML relationship stereotype.
Code generated by getUpdatedMessageCode."
validTargets
	| result |
	result := Dictionary new.
	result add: self validTargetsForCharacterization.
	result add: self validTargetsForMediation.
	result add: self validTargetsForTest.
	^ result.'.
]

{ #category : 'constants' }
RelationTargetVerificationTest >> getMockVerificationUpdater [
	| mockUpdater |
	mockUpdater := OntoUMLVerificationUpdater new.
	mockUpdater relationshipSpecifications: { MockOntoUMLRelationshipStereotypeYaml new name: 'Characterization'. MockOntoUMLRelationshipStereotypeYaml new name: 'Mediation'. MockOntoUMLRelationshipStereotypeYaml new name: 'Test'. }.
 	^ mockUpdater.
]

{ #category : 'constants' }
RelationTargetVerificationTest >> getTestedClass [
	^ RelationTargetVerification.
]

{ #category : 'constants' }
RelationTargetVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testGetUpdatedMessageCode [
	| mockVerificationUpdater updatedCode |
	mockVerificationUpdater := self getMockVerificationUpdater.
	updatedCode := self getTestedClass getUpdatedMessageCode: mockVerificationUpdater.
	self assert: updatedCode equals: self getExpectedUpdatedMessageCode.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testGetValidTargetsForFromCollection [
	| updatedCode |
	updatedCode := self getTestedClass getValidTargetsFor: 'Characterization' fromCollection: { 'SubKind'. 'Test'. 'Mock'.}.
	self assert: updatedCode equals: self getExpectedGetValidTargetsForFromCollection.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testInvalidModel [
	| mode quality association model result |
	mode := OPUMLClass new.
	mode applyStereotype: OntoUMLMode new.
	quality := OPUMLClass new.
	quality applyStereotype: OntoUMLQuality new.
	association := self createAssociationFrom: quality to: mode .
	association applyStereotype: OntoUMLContainment new.
	model := { mode. quality. association. }.
	result := VerificationResults new.
	result addResults: (RelationTargetVerification verify: association withModel: model).
	self assert: result results size equals: 1.
	self assert: (result results anySatisfy: [ :message | message isKindOf: VerificationMessageError. ]).
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testValidModel [
	| mode quantity association model result |
	mode := OPUMLClass new.
	mode applyStereotype: OntoUMLMode new.
	quantity := OPUMLClass new.
	quantity applyStereotype: OntoUMLQuantity new.
	association := self createAssociationFrom: mode to: quantity .
	association applyStereotype: OntoUMLContainment new.
	model := { mode. quantity. association. }.
	result := VerificationResults new.
	result addResults: (RelationTargetVerification verify: association withModel: model).
	self assert: result results size equals: 0.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testValidTargets [
	| dictionary |
	dictionary  := self getTestedClass validTargets.
	self assert: (dictionary isKindOf: Dictionary) equals: true.
	self assert: ((dictionary at: OntoUMLDomainFormal) isKindOf: Collection) equals: true.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testValidTargetsFor [
	| methodList |
	methodList := (RelationTargetVerification class localMethods collect: [ :method | method selector ]) select: [ :methodName | 		methodName matchesRegex: 'validTargetsFor.*' ].
	self assert: methodList isNotEmpty.
	methodList do: [ :methodName | 
		self assert: (((RelationTargetVerification class >> (methodName asSymbol)) valueWithReceiver: nil arguments: #()) isKindOf: Association) equals: true ].
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : 'tests' }
RelationTargetVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
