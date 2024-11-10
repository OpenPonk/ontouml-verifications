"
I represent tests for AllowedSubtypesVerification.
"
Class {
	#name : 'AllowedSubtypesVerificationTest',
	#superclass : 'AbstractVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Verification-Tests',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Verification-Tests'
}

{ #category : 'constants' }
AllowedSubtypesVerificationTest >> getExpectedGetValidSubtypesForCodeFromCollection [

	^ 'validSubtypesForKind
	"I return association between OntoUML element stereotype Kind and its allowed subtypes.
	I am generated by getValidSubtypesFor:FromCollection: and tested by testValidSubtypesFor"

	^ OntoUMLKind -> { OntoUMLSubKind. OntoUMLTest. OntoUMLMock. }.'
]

{ #category : 'constants' }
AllowedSubtypesVerificationTest >> getExpectedUpdatedMessageCode [
	^ 'validSubtypes
	"I return dictionary containing collections of allowed subtypes for each OntoUML element stereotype.
	Code generated by getUpdatedMessageCode."

	| result |
	result := Dictionary new.
	result add: self validSubtypesForKind.
	result add: self validSubtypesForMode.
	result add: self validSubtypesForTest.
	^ result.'.
]

{ #category : 'constants' }
AllowedSubtypesVerificationTest >> getMockVerificationUpdater [
	| mockUpdater |
	mockUpdater := OntoUMLVerificationUpdater new.
	mockUpdater classSpecifications: { MockOntoUMLClassStereotypeYaml new name: 'Kind'. MockOntoUMLClassStereotypeYaml new name: 'Mode'. MockOntoUMLClassStereotypeYaml new name: 'Test'. }.
 	^ mockUpdater.
]

{ #category : 'constants' }
AllowedSubtypesVerificationTest >> getTestedClass [
 ^ AllowedSubtypesVerification.
]

{ #category : 'constants' }
AllowedSubtypesVerificationTest >> getVerifiedClass [
 ^ OPUMLGeneralization.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testCanVerify [
	self canVerifyTest. 
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testGetUpdatedMessageCode [
	| mockVerificationUpdater updatedCode |
	mockVerificationUpdater := self getMockVerificationUpdater.
	updatedCode := self getTestedClass getUpdatedMessageCode: mockVerificationUpdater.
	self assert: updatedCode equals: self getExpectedUpdatedMessageCode.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testGetValidSubtypesForCodeFromCollection [
	| updatedCode |
	updatedCode := self getTestedClass getValidSubtypesForCode: 'Kind' fromCollection: { 'SubKind'. 'Test'. 'Mock'.}.
	self assert: updatedCode equals: self getExpectedGetValidSubtypesForCodeFromCollection.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testInvalidModel [
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
	result addResults: (AllowedSubtypesVerification verify: generalization withModel: model).
	self assert: result results size equals: 1.
	self assert: (result results anySatisfy: [ :message | message isKindOf: VerificationMessageError. ]).
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testValidModel [
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
	result addResults: (AllowedSubtypesVerification verify: generalization withModel: model).
	self assert: result results size equals: 0.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testValidSubtypes [
	| result |
	result := AllowedSubtypesVerification validSubtypes.
	self assert: (result isKindOf: Dictionary);
	assert: result isNotEmpty.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testValidSubtypesFor [
	| methodList |
	methodList := (AllowedSubtypesVerification class localMethods 
		collect: [ :method | method selector ]) 
			select: [ :methodName | 	methodName matchesRegex: 'validSubtypesFor.*' ].
	self assert: methodList isNotEmpty.
	methodList do: [ :methodName | 
		self assert: (((AllowedSubtypesVerification class >> (methodName asSymbol)) valueWithReceiver: nil arguments: #()) isKindOf: Association) equals: true ].
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : 'tests' }
AllowedSubtypesVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]