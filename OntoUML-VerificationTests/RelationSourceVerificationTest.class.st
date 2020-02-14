Class {
	#name : #RelationSourceVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
RelationSourceVerificationTest >> getTestedClass [
	^ RelationSourceVerification
]

{ #category : #constants }
RelationSourceVerificationTest >> getVerifiedClass [
	^ OPUMLAssociation
]

{ #category : #tests }
RelationSourceVerificationTest >> invalidObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLCollective new.
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLQuality new.
	tmp3 := self createAssociationFrom: tmp1 to: tmp2.
	tmp3 applyStereotype: OntoUMLMemberOf new.
	tmp4 := {tmp1.
	tmp2.
	tmp3}.
	tmp5 := VerificationResults new.
	tmp5
		addResults: (RelationSourceVerification verify: tmp3 withModel: tmp4).
	self assert: tmp5 results size equals: 0
]

{ #category : #tests }
RelationSourceVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
RelationSourceVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
RelationSourceVerificationTest >> testValidSources [
	| tmp1 |
	tmp1 := self getTestedClass validSources.
	self
		assert: (tmp1 isKindOf: Dictionary) equals: true;
		assert: ((tmp1 at: OntoUMLFormal) isKindOf: Collection)
			equals: true
]

{ #category : #tests }
RelationSourceVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
RelationSourceVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RelationSourceVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RelationSourceVerificationTest >> validObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLCollective new.
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLQuality new.
	tmp3 := self createAssociationFrom: tmp2 to: tmp1.
	tmp3 applyStereotype: OntoUMLMemberOf new.
	tmp4 := {tmp1.
	tmp2.
	tmp3}.
	tmp5 := VerificationResults new.
	tmp5
		addResults: (RelationSourceVerification verify: tmp3 withModel: tmp4).
	self
		assert: tmp5 results size equals: 1;
		assert:
			(tmp5 results
				anySatisfy: [ :arg1 | arg1 isKindOf: VerificationMessageError ])
]
