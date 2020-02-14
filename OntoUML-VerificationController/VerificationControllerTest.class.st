Class {
	#name : #VerificationControllerTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationController'
}

{ #category : #tests }
VerificationControllerTest >> testGetVerifications [
	| tmp1 tmp2 |
	tmp1 := VerificationController new.
	tmp2 := tmp1 getVerifications.
	self
		assert: (tmp2 isKindOf: Collection);
		assert: tmp2 isEmpty equals: false;
		assert: (tmp2 anySatisfy: [ :arg1 | arg1 = Verification ])
			equals: true
]

{ #category : #tests }
VerificationControllerTest >> testGetVerifiedObjects [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp2 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp3 := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	tmp1 := OPUMLModel new.
	tmp5 := {tmp2.
	tmp3}.
	tmp1 packagedElements: tmp5.
	tmp4 := VerificationController new.
	self assert: (tmp4 getVerifiedObjects: tmp1) equals: tmp5
]

{ #category : #tests }
VerificationControllerTest >> testVerify [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 |
	tmp1 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	tmp4 := {tmp1.
	tmp2}.
	tmp6 := OPUMLModel new.
	tmp6 packagedElements: tmp4.
	tmp3 := VerificationController new.
	tmp5 := tmp3 verify: tmp6.
	self
		assert: (tmp5 isKindOf: VerificationResults) equals: true;
		assert: (tmp5 hasErrors: tmp1) equals: false;
		assert: (tmp5 hasErrors: tmp2) equals: true
]

{ #category : #tests }
VerificationControllerTest >> testVerifySingleObjectWithVerificationsWithModelWithResults [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new applyStereotype: OntoUMLSubKind new.
	tmp4 := {tmp1.
	tmp2}.
	tmp3 := VerificationController new.
	tmp5 := VerificationResults new.
	tmp3
		verifySingleObject: tmp1
		withVerifications: tmp3 getVerifications
		withModel: tmp4
		withResults: tmp5.
	self assert: tmp5 results isEmpty equals: true.
	tmp3
		verifySingleObject: tmp2
		withVerifications: tmp3 getVerifications
		withModel: tmp4
		withResults: tmp5.
	self assert: (tmp5 hasErrors: tmp2) equals: true
]
