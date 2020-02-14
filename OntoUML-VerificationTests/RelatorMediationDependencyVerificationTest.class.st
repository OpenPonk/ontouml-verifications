Class {
	#name : #RelatorMediationDependencyVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
RelatorMediationDependencyVerificationTest >> getTestedClass [
	^ RelatorMediationDependencyVerification
]

{ #category : #constants }
RelatorMediationDependencyVerificationTest >> getVerifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
RelatorMediationDependencyVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLRelator}
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> invalidObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 tmp7 |
	tmp3 := OPUMLClass new.
	tmp3 applyStereotype: OntoUMLKind new.
	tmp5 := OPUMLClass new.
	tmp5 applyStereotype: OntoUMLKind new.
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLRelator new.
	tmp2 := self createAssociationFrom: tmp1 to: tmp3.
	tmp2 applyStereotype: OntoUMLMediation new.
	tmp4 := self createAssociationFrom: tmp1 to: tmp5.
	tmp4 applyStereotype: OntoUMLMediation new.
	tmp6 := {tmp3.
	tmp5.
	tmp1.
	tmp2.
	tmp4}.
	tmp7 := VerificationResults new.
	tmp7 addResults: (self getTestedClass verify: tmp1 withModel: tmp6).
	self assert: tmp7 results size equals: 0
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testGetMultiplicityFor [
	| tmp1 tmp2 tmp3 |
	tmp1 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new applyStereotype: OntoUMLRelator new.
	tmp3 := self createAssociationFrom: tmp1 to: tmp2.
	self
		assert: (self getTestedClass basicNew getMultiplicity: tmp3 for: tmp2)
		equals: 1.
	(tmp3 memberEnds at: 1) lowerValue value: 0.
	self
		assert: (self getTestedClass basicNew getMultiplicity: tmp3 for: tmp2)
		equals: 0
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> validObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp3 := OPUMLClass new.
	tmp3 applyStereotype: OntoUMLKind new.
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLRelator new.
	tmp2 := self createAssociationFrom: tmp1 to: tmp3.
	tmp2 applyStereotype: OntoUMLMediation new.
	tmp4 := {tmp3.
	tmp1.
	tmp2}.
	tmp5 := VerificationResults new.
	tmp5 addResults: (self getTestedClass verify: tmp1 withModel: tmp4).
	self assert: tmp5 results size equals: 1
]
