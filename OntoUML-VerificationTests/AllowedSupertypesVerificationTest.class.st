Class {
	#name : #AllowedSupertypesVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
AllowedSupertypesVerificationTest >> getTestedClass [
	^ AllowedSupertypesVerification
]

{ #category : #constants }
AllowedSupertypesVerificationTest >> getVerifiedClass [
	^ OPUMLGeneralization
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> invalidObjectTest [
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
	tmp5
		addResults: (AllowedSubtypesVerification verify: tmp3 withModel: tmp4).
	self assert: tmp5 results size equals: 0
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> testValidSupertypes [
	| tmp1 tmp3 |
	tmp1 := self getTestedClass validSupertypes.
	tmp3 := self.
	tmp3
		assert: (tmp1 isKindOf: Dictionary);
		assert: tmp1 isNotEmpty
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
AllowedSupertypesVerificationTest >> validObjectTest [
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
	tmp5
		addResults: (AllowedSubtypesVerification verify: tmp3 withModel: tmp4).
	self
		assert: tmp5 results size equals: 1;
		assert:
			(tmp5 results
				anySatisfy: [ :arg1 | arg1 isKindOf: VerificationMessageError ])
]
