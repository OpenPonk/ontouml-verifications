Class {
	#name : #CharacterizedVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationTests'
}

{ #category : #constants }
CharacterizedVerificationTest >> getTestedClass [
	^ CharacterizedVerification
]

{ #category : #constants }
CharacterizedVerificationTest >> getVerifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
CharacterizedVerificationTest >> getVerifiedStereotypes [
	^ {OntoUMLMode.
	OntoUMLQuality}
]

{ #category : #tests }
CharacterizedVerificationTest >> invalidObjectTest [
	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp3 := OPUMLClass new.
	tmp3 applyStereotype: OntoUMLKind new.
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLQuality new.
	tmp2 := self createAssociationFrom: tmp3 to: tmp1.
	tmp2 applyStereotype: OntoUMLCharacterization new.
	tmp4 := {tmp3.
	tmp1.
	tmp2}.
	tmp5 := VerificationResults new.
	tmp5 addResults: (self getTestedClass verify: tmp1 withModel: tmp4).
	self assert: tmp5 results size equals: 0
]

{ #category : #tests }
CharacterizedVerificationTest >> testCanVerify [
	self canVerifyTest
]

{ #category : #tests }
CharacterizedVerificationTest >> testNew [
	self newTest
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifiedClass [
	self verifiedClassTest
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifyMultiplicityForCharacterization [
	| tmp1 tmp2 tmp3 |
	tmp1 := OPUMLClass new applyStereotype: OntoUMLKind new.
	tmp2 := OPUMLClass new applyStereotype: OntoUMLMode new.
	tmp3 := self createAssociationFrom: tmp1 to: tmp2.
	self
		assert:
			(self getTestedClass basicNew
				verifyMultiplicity: tmp2
				forCharacterization: tmp3) isEmpty
		equals: true.
	(tmp3 memberEnds at: 1) lowerValue value: 0.
	self
		assert:
			(self getTestedClass basicNew
				verifyMultiplicity: tmp2
				forCharacterization: tmp3) isEmpty
		equals: false
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifyObjectWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
CharacterizedVerificationTest >> testVerifyWithModel [
	self
		validObjectTest;
		invalidObjectTest
]

{ #category : #tests }
CharacterizedVerificationTest >> validObjectTest [
	| tmp1 tmp2 tmp3 tmp4 |
	tmp2 := OPUMLClass new.
	tmp2 applyStereotype: OntoUMLKind new.
	tmp1 := OPUMLClass new.
	tmp1 applyStereotype: OntoUMLQuality new.
	tmp3 := {tmp2.
	tmp1}.
	tmp4 := VerificationResults new.
	tmp4 addResults: (self getTestedClass verify: tmp1 withModel: tmp3).
	self assert: tmp4 results size equals: 1
]
