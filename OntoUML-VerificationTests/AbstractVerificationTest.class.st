Class {
	#name : #AbstractVerificationTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #tests }
AbstractVerificationTest >> canVerifyTest [
	self
		assert: (self getTestedClass canVerify: self getNotVerifiedClassInstance)
			equals: false;
		assert: (self getTestedClass canVerify: self getVerifiedClassInstance)
			equals: true
]

{ #category : #'tests - utility' }
AbstractVerificationTest >> createAssociationFrom: arg1 to: arg2 [
	| tmp1 tmp2 tmp3 tmp5 tmp7 |
	tmp1 := OPUMLAssociation new.
	tmp5 := tmp2 := OPUMLProperty new.
	tmp5
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: tmp1;
		type: arg1.
	tmp7 := tmp3 := OPUMLProperty new.
	tmp7
		name: '';
		lowerValue: (OPUMLLiteralInteger new value: 1);
		upperValue: (OPUMLLiteralUnlimitedNatural new value: 1);
		owningAssociation: tmp1;
		type: arg2.
	tmp1 memberEnds addAll: tmp1 ownedEnds asArray.
	^ tmp1
]

{ #category : #constants }
AbstractVerificationTest >> getNotVerifiedClass [
	^ Object
]

{ #category : #constants }
AbstractVerificationTest >> getNotVerifiedClassInstance [
	^ self getNotVerifiedClass new
]

{ #category : #constants }
AbstractVerificationTest >> getTestedClass [
	self subclassResponsibility
]

{ #category : #constants }
AbstractVerificationTest >> getVerifiedClass [
	self subclassResponsibility
]

{ #category : #constants }
AbstractVerificationTest >> getVerifiedClassInstance [
	^ self getVerifiedClass new
]

{ #category : #tests }
AbstractVerificationTest >> newTest [
	self should: [ self getTestedClass new ] raise: ShouldNotImplement
]

{ #category : #tests }
AbstractVerificationTest >> verifiedClassTest [
	self
		assert: self getTestedClass verifiedClass
		equals: self getVerifiedClass
]
