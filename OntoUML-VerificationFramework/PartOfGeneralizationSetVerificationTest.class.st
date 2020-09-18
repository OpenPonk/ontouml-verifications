"
I represent tests for PartOfGeneralizationSetVerification.
"
Class {
	#name : #PartOfGeneralizationSetVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Verification-Tests'
}

{ #category : #constants }
PartOfGeneralizationSetVerificationTest >> getTestedClass [
	^ PartOfGeneralizationSetVerification.
]

{ #category : #constants }
PartOfGeneralizationSetVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
PartOfGeneralizationSetVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLPhase.}.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> invalidObjectTest [
	| kind phase generalization generalizationSet model result |
	phase := OPUMLClass new.
	phase applyStereotype: OntoUMLPhase new.
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	generalization := OPUMLGeneralization new.
	generalization general: kind.
	generalization specific: phase.
	generalizationSet := OPUMLGeneralizationSet new.
	generalizationSet generalizations: {generalization}.
	generalizationSet isDisjoint: true.
	generalizationSet isCovering: true.
	generalization generalizationSets: {generalizationSet}.
	model := { kind. phase. generalization. generalizationSet. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: phase withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifyObjectWithModel [
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifyWithModel [
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> validObjectTest [
	| phase model result |
	phase := OPUMLClass new.
	phase applyStereotype: OntoUMLPhase new.
	model := { phase. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: phase withModel: model).
	self assert: result results size equals: 1.
	self assert: (result results anySatisfy: [ :message | message isKindOf: VerificationMessageError. ]).
]
