Class {
	#name : #PartOfGeneralizationSetVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
PartOfGeneralizationSetVerificationTest >> getTestedClass [
	^ PartOfGeneralizationSetVerification
]

{ #category : #constants }
PartOfGeneralizationSetVerificationTest >> getVerifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
PartOfGeneralizationSetVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLPhase}
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> invalidObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 |
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLPhase new.
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLKind new.
	tmp3 := OPUMLGeneralization new.
	tmp3
		general: tmp1;
		specific: tmp2.
	tmp4 := OPUMLGeneralizationSet new.
	tmp4
		generalizations: {tmp3};
		isDisjoint: true;
		isCovering: true.
	tmp3 generalizationSets: {tmp4}.
	tmp5 := {tmp1.
	tmp2.
	tmp3.
	tmp4}.
	tmp6 := VerificationResults new.
	tmp6 addResults: (self getTestedClass verify: tmp2 withModel: tmp5).
	self assert: tmp6 results size equals: 0
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
PartOfGeneralizationSetVerificationTest >> validObjectTest [
	| tmp1 tmp2 tmp3 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLPhase new.
	tmp2 := {tmp1}.
	tmp3 := VerificationResults new.
	tmp3 addResults: (self getTestedClass verify: tmp1 withModel: tmp2).
	self
		assert: tmp3 results size equals: 1;
		assert:
			(tmp3 results
				anySatisfy: [ :arg1 | arg1 isKindOf: VerificationMessageError ])
]
