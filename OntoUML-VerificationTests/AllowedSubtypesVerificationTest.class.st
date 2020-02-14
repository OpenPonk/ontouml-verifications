Class {
	#name : #AllowedSubtypesVerificationTest,
	#superclass : #AbstractVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
AllowedSubtypesVerificationTest >> getTestedClass [
	^ AllowedSubtypesVerification
]

{ #category : #constants }
AllowedSubtypesVerificationTest >> getVerifiedClass [
	^ OPUMLGeneralization
]

{ #category : #tests }
AllowedSubtypesVerificationTest >> invalidObjectTest [
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
AllowedSubtypesVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
AllowedSubtypesVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
AllowedSubtypesVerificationTest >> testValidSubtypes [
	| tmp1 tmp3 |
	tmp1 := AllowedSubtypesVerification validSubtypes.
	tmp3 := self.
	tmp3
		assert: (tmp1 isKindOf: Dictionary);
		assert: tmp1 isNotEmpty
]

{ #category : #tests }
AllowedSubtypesVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
AllowedSubtypesVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
AllowedSubtypesVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
AllowedSubtypesVerificationTest >> validObjectTest [
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
