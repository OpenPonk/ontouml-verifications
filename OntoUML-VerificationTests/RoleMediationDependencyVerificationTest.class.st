Class {
	#name : #RoleMediationDependencyVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
RoleMediationDependencyVerificationTest >> getTestedClass [
	^ RoleMediationDependencyVerification
]

{ #category : #constants }
RoleMediationDependencyVerificationTest >> getVerifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
RoleMediationDependencyVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLRole}
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> invalidObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp3 := OPUMLClass new.
	tmp3 applyStereotype: OntoUMLRole new.
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLRelator new.
	tmp2 := self createAssociationFrom: tmp1 to: tmp3.
	tmp2 applyStereotype: OntoUMLMediation new.
	tmp4 := {tmp3.
	tmp1.
	tmp2}.
	tmp5 := VerificationResults new.
	tmp5 addResults: (self getTestedClass verify: tmp3 withModel: tmp4).
	self assert: tmp5 results size equals: 0
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testFulfilsMediationDependency [
	| tmp1 tmp2 tmp3 |
	tmp1 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new applyStereotype: OntoUMLRole new.
	tmp3 := self createAssociationFrom: tmp1 to: tmp2.
	self
		assert: (self getTestedClass basicNew fulfilsMediationDependency: tmp3)
		equals: true.
	(tmp3 memberEnds at: 1) lowerValue value: 0.
	self
		assert: (self getTestedClass basicNew fulfilsMediationDependency: tmp3)
		equals: false
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> validObjectTest [
	| tmp1 tmp2 tmp3 |
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLRole new.
	tmp2 := {tmp1}.
	tmp3 := VerificationResults new.
	tmp3 addResults: (self getTestedClass verify: tmp1 withModel: tmp2).
	self assert: tmp3 results size equals: 1
]
