Class {
	#name : #RelationTargetVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
RelationTargetVerificationTest >> getTestedClass [
	^ RelationTargetVerification
]

{ #category : #constants }
RelationTargetVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation
]

{ #category : #tests }
RelationTargetVerificationTest >> invalidObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLMode new.
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLQuantity new.
	tmp3 := self createAssociationFrom: tmp1 to: tmp2.
	tmp3 applyStereotype: OntoUMLContainment new.
	tmp4 := {tmp1.
	tmp2.
	tmp3}.
	tmp5 := VerificationResults new.
	tmp5
		addResults: (RelationTargetVerification verify: tmp3 withModel: tmp4).
	self assert: tmp5 results size equals: 0
]

{ #category : #tests }
RelationTargetVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
RelationTargetVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
RelationTargetVerificationTest >> testValidTargets [
	| tmp1 |
	tmp1 := self getTestedClass validTargets.
	self
		assert: (tmp1 isKindOf: Dictionary) equals: true;
		assert: ((tmp1 at: OntoUMLFormal) isKindOf: Collection)
			equals: true
]

{ #category : #tests }
RelationTargetVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
RelationTargetVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RelationTargetVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RelationTargetVerificationTest >> validObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLMode new.
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLQuality new.
	tmp3 := self createAssociationFrom: tmp2 to: tmp1.
	tmp3 applyStereotype: OntoUMLContainment new.
	tmp4 := {tmp1.
	tmp2.
	tmp3}.
	tmp5 := VerificationResults new.
	tmp5
		addResults: (RelationTargetVerification verify: tmp3 withModel: tmp4).
	self
		assert: tmp5 results size equals: 1;
		assert:
			(tmp5 results
				anySatisfy: [ :arg1 | arg1 isKindOf: VerificationMessageError ])
]
