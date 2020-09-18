"
I represent tests for RelationSourceVerification.
"
Class {
	#name : #RelationSourceVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationFramework-Verification-Tests'
}

{ #category : #constants }
RelationSourceVerificationTest >> getExpectedGetValidSourcesForFromCollection [
	^'"I return association between OntoUML relationship stereotype Characterization and its allowed sources."
validSourcesForCharacterization
	^ OntoUMLCharacterization -> { OntoUMLSubKind. OntoUMLTest. OntoUMLMock. }.'.
]

{ #category : #constants }
RelationSourceVerificationTest >> getExpectedUpdatedMessageCode [
	^ '"I return dictionary containing collections of allowed sources for each OntoUML relationship stereotype."
validSources
	| result |
	result := Dictionary new.
	result add: self validSourcesForCharacterization.
	result add: self validSourcesForMediation.
	result add: self validSourcesForTest.
	^ result.'.
]

{ #category : #constants }
RelationSourceVerificationTest >> getMockVerificationUpdater [
	| mockUpdater |
	mockUpdater := OntoUMLVerificationUpdater new.
	mockUpdater relationshipSpecifications: { MockOntoUMLRelationshipStereotypeYaml new name: 'Characterization'. MockOntoUMLRelationshipStereotypeYaml new name: 'Mediation'. MockOntoUMLRelationshipStereotypeYaml new name: 'Test'. }.
 	^ mockUpdater.
]

{ #category : #constants }
RelationSourceVerificationTest >> getTestedClass [
	^ RelationSourceVerification.
]

{ #category : #constants }
RelationSourceVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation.
]

{ #category : #tests }
RelationSourceVerificationTest >> invalidObjectTest [
	| collective quality association model result |
	collective := OPUMLClass new.
	collective applyStereotype: OntoUMLCollective new.
	quality := OPUMLClass new.
	quality applyStereotype: OntoUMLQuality new.
	association := self createAssociationFrom: collective to: quality.
	association applyStereotype: OntoUMLMemberOf new.
	model := { collective. quality. association. }.
	result := VerificationResults new.
	result addResults: (RelationSourceVerification verify: association withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
RelationSourceVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RelationSourceVerificationTest >> testGetUpdatedMessageCode [
	| mockVerificationUpdater updatedCode |
	mockVerificationUpdater := self getMockVerificationUpdater.
	updatedCode := self getTestedClass getUpdatedMessageCode: mockVerificationUpdater.
	self assert: updatedCode equals: self getExpectedUpdatedMessageCode.
]

{ #category : #tests }
RelationSourceVerificationTest >> testGetValidSourcesForFromCollection [
	| updatedCode |
	updatedCode := self getTestedClass getValidSourcesFor: 'Characterization' fromCollection: { 'SubKind'. 'Test'. 'Mock'.}.
	self assert: updatedCode equals: self getExpectedGetValidSourcesForFromCollection.
]

{ #category : #tests }
RelationSourceVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
RelationSourceVerificationTest >> testValidSources [
	| dictionary |
	dictionary  := self getTestedClass validSources.
	self assert: (dictionary isKindOf: Dictionary) equals: true.
	self assert: ((dictionary at: OntoUMLFormal) isKindOf: Collection) equals: true.
]

{ #category : #tests }
RelationSourceVerificationTest >> testValidSourcesFor [
	| methodList |
	methodList := (RelationSourceVerification class localMethods collect: [ :method | method selector ]) select: [ :methodName | 		methodName matchesRegex: 'validSourcesFor.*' ].
	self assert: methodList isNotEmpty.
	methodList do: [ :methodName | 
		self assert: (RelationSourceVerification class >>> (methodName asSymbol) isKindOf: Association). ].
]

{ #category : #tests }
RelationSourceVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
RelationSourceVerificationTest >> testVerifyObjectWithModel [
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
RelationSourceVerificationTest >> testVerifyWithModel [
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
RelationSourceVerificationTest >> validObjectTest [
	| collective quality association model result |
	collective := OPUMLClass new.
	collective applyStereotype: OntoUMLCollective new.
	quality := OPUMLClass new.
	quality applyStereotype: OntoUMLQuality new.
	association := self createAssociationFrom: quality to: collective.
	association applyStereotype: OntoUMLMemberOf new.
	model := { collective. quality. association. }.
	result := VerificationResults new.
	result addResults: (RelationSourceVerification verify: association withModel: model).
	self assert: result results size equals: 1.
	self assert: (result results anySatisfy: [ :message | message isKindOf: VerificationMessageError. ]).
]
