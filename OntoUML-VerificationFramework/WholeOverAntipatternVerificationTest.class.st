"
I represent tests for WholeOverAntipatternVerification.
"
Class {
	#name : #WholeOverAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #tests }
WholeOverAntipatternVerificationTest >> getTestModelForMethods [
	| commonAncestor testedObject1 testedObject2 child1 commonChild testedObject3 association1 association2 association3 |
	commonAncestor := self createClass: 'commonAncestor' withStereotype: OntoUMLKind.
	testedObject1 := self createClass: 'testedObject1' withStereotype: OntoUMLSubKind.
	testedObject2 := self createClass: 'testedObject2' withStereotype: OntoUMLSubKind.
	child1 := self createClass: 'child1' withStereotype: OntoUMLSubKind.
	commonChild := self createClass: 'commonChild' withStereotype: OntoUMLRole.
	testedObject3 := self createClass: 'testedObject3' withStereotype: OntoUMLRoleMixin.
	association1 := self createAssociationFrom: commonAncestor to: testedObject1 with: OntoUMLMemberOf new.
	association1 memberEnds second upperValue value: '*'.
	association2 := self createAssociationFrom: commonAncestor to: testedObject2 with: OntoUMLMemberOf new.
	association2 memberEnds second lowerValue value: 2.
	association3 := self createAssociationFrom: commonAncestor to: testedObject3 with: OntoUMLMemberOf new.
	^ { commonAncestor. testedObject1. testedObject2. child1. commonChild.
		testedObject3. association1. association2. association3.
		self createGeneralizationFor: commonAncestor withSpecific: testedObject1.
		self createGeneralizationFor: commonAncestor withSpecific: testedObject2.
		self createGeneralizationFor: testedObject1 withSpecific: child1.
		self createGeneralizationFor: testedObject2 withSpecific: commonChild.
		self createGeneralizationFor: testedObject3 withSpecific: commonChild.				
		 }.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> getTestedClass [
	^ WholeOverAntipatternVerification.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLSubKind. OntoUMLPhase. OntoUMLRole. OntoUMLRoleMixin. OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testCheckForOverlapInModel [
	| model testedAssociationEnds overlapingSet1 overlapingSet2 nonOverlapingSet |
	model := self getTestModelForMethods.
	testedAssociationEnds := (model select: [ :object | object isKindOf: OPUMLAssociation. ])
		collect: [ :association | association memberEnds second ].
	overlapingSet1 := testedAssociationEnds reject: [ :end | end type name = 'testedObject3' ].
	overlapingSet2 := testedAssociationEnds reject: [ :end | end type name = 'testedObject1' ].
	nonOverlapingSet := testedAssociationEnds reject: [ :end | end type name = 'testedObject2' ].
	self assert: ((self getTestedClass basicNew) checkForOverlap: overlapingSet1 inModel: model) equals: true.
	self assert: ((self getTestedClass basicNew) checkForOverlap: overlapingSet2 inModel: model) equals: true.
	self assert: ((self getTestedClass basicNew) checkForOverlap: nonOverlapingSet inModel: model) equals: false.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testCheckUpperMultiplicityFor [
	| model testedAssociationEnds highUpperEndSet1 highUpperEndSet2 okUpperEndSet |
	model := self getTestModelForMethods.
	testedAssociationEnds := (model select: [ :object | object isKindOf: OPUMLAssociation. ])
		collect: [ :association | association memberEnds second ].
	highUpperEndSet1 := testedAssociationEnds select: [ :end | end type name = 'testedObject1' ].
	highUpperEndSet2 := testedAssociationEnds reject: [ :end | end type name = 'testedObject1' ].
	okUpperEndSet := testedAssociationEnds select: [ :end | end type name = 'testedObject3' ].
	self assert: ((self getTestedClass basicNew) checkUpperMultiplicityFor: highUpperEndSet1) equals: true.
	self assert: ((self getTestedClass basicNew) checkUpperMultiplicityFor: highUpperEndSet2) equals: true.
	self assert: ((self getTestedClass basicNew) checkUpperMultiplicityFor: okUpperEndSet) equals: false.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testGetPartEndsForFrom [
	| model whole result |
	model := self getTestModelForMethods.
	whole := ((model select: [ :object | object isKindOf: OPUMLClass. ])
		select: [ :entity | entity name = 'commonAncestor' ]) first.
	result := ((model select: [ :object | object isKindOf: OPUMLAssociation. ])
		select: [ :association | { 'testedObject1'. 'testedObject2'. 'testedObject3'. } includes: association memberEnds second type name ])
		collect: [ :association | association memberEnds second ].
	self assert: ((self getTestedClass basicNew) getPartEndsFor: whole from: model) equals: result.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testInvalidModel [
	| whole partA partB child generalizationA generalizationB componentOfA componentOfB model result |
	whole := self createClass: 'whole' withStereotype: OntoUMLKind.
	child := self createClass: 'child' withStereotype: OntoUMLKind.	
	partA := self createClass: 'partA' withStereotype: OntoUMLCategory.	
	partB := self createClass: 'partB' withStereotype: OntoUMLCategory.	
	componentOfA := self createAssociationFrom: whole to: partA.
	componentOfA applyStereotype: OntoUMLComponentOf new.
	componentOfB := self createAssociationFrom: whole to: partB.
	componentOfB applyStereotype: OntoUMLComponentOf new.
	generalizationA := self createGeneralizationFor: partA withSpecific: child.
	generalizationB := self createGeneralizationFor: partB withSpecific: child.
	model := { whole. partA. partB. child. generalizationA. generalizationB. componentOfA. componentOfB. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: whole withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testValidModel [
	| whole partA partB componentOfA componentOfB model result |
	whole := self createClass: 'whole' withStereotype: OntoUMLKind.
	partA := self createClass: 'partA' withStereotype: OntoUMLCategory.	
	partB := self createClass: 'partB' withStereotype: OntoUMLCategory.	
	componentOfA := self createAssociationFrom: whole to: partA.
	componentOfA applyStereotype: OntoUMLComponentOf new.
	componentOfB := self createAssociationFrom: whole to: partB.
	componentOfB applyStereotype: OntoUMLComponentOf new.
	model := { whole. partA. partB. componentOfA. componentOfB. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: whole withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
WholeOverAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
