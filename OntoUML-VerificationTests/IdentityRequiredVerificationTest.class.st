Class {
	#name : #IdentityRequiredVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
IdentityRequiredVerificationTest >> getTestedClass [
	^ IdentityRequiredVerification
]

{ #category : #constants }
IdentityRequiredVerificationTest >> getVerifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
IdentityRequiredVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLSubKind.
	OntoUMLPhase.
	OntoUMLRole}
]

{ #category : #tests }
IdentityRequiredVerificationTest >> invalidObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLSubKind new.
	tmp3 := OPUMLGeneralization new.
	tmp3
		general: tmp1;
		specific: tmp2.
	tmp4 := {tmp1.
	tmp2.
	tmp3}.
	tmp5 := VerificationResults new.
	tmp5 addResults: (self getTestedClass verify: tmp2 withModel: tmp4).
	self assert: tmp5 results size equals: 0
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testCountIdentitySourcesFromModelWithAccumulator [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 |
	tmp1 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp3 := OPUMLClass new applyStereotype: OntoUMLRole new.
	tmp5 := OPUMLGeneralization new.
	tmp6 := OPUMLGeneralization new.
	tmp5
		general: tmp1;
		specific: tmp3.
	tmp6
		general: tmp2;
		specific: tmp3.
	tmp4 := {tmp1.
	tmp2.
	tmp3.
	tmp5.
	tmp6}.
	self
		assert:
			(self getTestedClass basicNew
				countIdentitySources: tmp3
				fromModel: tmp4
				withAccumulator: Set new)
		equals: 2
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testGetSuperClassesFromModel [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 |
	tmp1 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	tmp3 := OPUMLClass new applyStereotype: OntoUMLRole new.
	tmp5 := OPUMLGeneralization new.
	tmp6 := OPUMLGeneralization new.
	tmp5
		general: tmp1;
		specific: tmp2.
	tmp6
		general: tmp2;
		specific: tmp3.
	tmp4 := {tmp1.
	tmp2.
	tmp3.
	tmp5.
	tmp6}.
	self
		assert:
			((self getTestedClass basicNew getSuperClasses: tmp3 fromModel: tmp4)
				at: 1)
		equals: tmp2
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testHasIdentity [
	| tmp1 tmp2 |
	tmp1 := OntoUMLKind new.
	tmp2 := OntoUMLSubKind new.
	self
		assert: (self getTestedClass basicNew hasIdentity: tmp1)
			equals: true;
		assert: (self getTestedClass basicNew hasIdentity: tmp2)
			equals: false
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testIdentityProviders [
	self
		assert: (self getTestedClass identityProviders isKindOf: Collection)
		equals: true
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
IdentityRequiredVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
IdentityRequiredVerificationTest >> validObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLSubKind new.
	tmp3 := OPUMLGeneralization new.
	tmp3
		general: tmp2;
		specific: tmp1.
	tmp4 := {tmp1.
	tmp2.
	tmp3}.
	tmp5 := VerificationResults new.
	tmp5 addResults: (self getTestedClass verify: tmp2 withModel: tmp4).
	self assert: tmp5 results size equals: 1
]
