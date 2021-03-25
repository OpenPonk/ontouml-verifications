Class {
	#name : #PartOverAntipatternVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Antipattern-Tests'
}

{ #category : #tests }
PartOverAntipatternVerificationTest >> getInvalidModel [
	| wholeA wholeB part parent generalizationA generalizationB componentOfA componentOfB |
	wholeA := self createClass: 'wholeA' withStereotype: OntoUMLSubKind.
	wholeB := self createClass: 'wholeB' withStereotype: OntoUMLSubKind.	
	part := self createClass: 'part' withStereotype: OntoUMLKind.	
	parent := self createClass: 'parent' withStereotype: OntoUMLKind.	
	componentOfA := self createAssociationFrom: wholeA to: part.
	componentOfA applyStereotype: OntoUMLComponentOf new.
	componentOfB := self createAssociationFrom: wholeB to: part.
	componentOfB applyStereotype: OntoUMLComponentOf new.
	generalizationA := self createGeneralizationFor: parent withSpecific: wholeA.
	generalizationB := self createGeneralizationFor: parent withSpecific: wholeB.
	^ { part. wholeA. wholeB. parent. generalizationA. generalizationB. componentOfA. componentOfB. }.
]

{ #category : #constants }
PartOverAntipatternVerificationTest >> getTestedClass [
	^ PartOverAntipatternVerification.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> getValidModel [
	| wholeA wholeB part parentA parentB generalizationA generalizationB componentOfA componentOfB |
	wholeA := self createClass: 'wholeA' withStereotype: OntoUMLSubKind.
	wholeB := self createClass: 'wholeB' withStereotype: OntoUMLSubKind.	
	part := self createClass: 'part' withStereotype: OntoUMLKind.	
	parentA := self createClass: 'parentA' withStereotype: OntoUMLKind.	
	parentB := self createClass: 'parentB' withStereotype: OntoUMLKind.	
	componentOfA := self createAssociationFrom: wholeA to: part.
	componentOfA applyStereotype: OntoUMLComponentOf new.
	componentOfB := self createAssociationFrom: wholeB to: part.
	componentOfB applyStereotype: OntoUMLComponentOf new.
	generalizationA := self createGeneralizationFor: parentA withSpecific: wholeA.
	generalizationB := self createGeneralizationFor: parentB withSpecific: wholeB.
	^ { part. wholeA. wholeB. parentA. parentB. generalizationA. generalizationB. componentOfA. componentOfB. }.
]

{ #category : #constants }
PartOverAntipatternVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
PartOverAntipatternVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLSubKind. OntoUMLPhase. OntoUMLRole. OntoUMLRoleMixin. OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testCheckForOverlap [
	| model part mediatedEnds testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	model := self getValidModel.
	part := model first.
	mediatedEnds := testedClassInstance getPartWholeAssociationsFor: part from: model.
	self assert: (testedClassInstance checkForOverlap: mediatedEnds) equals: false.
	
	model := self getInvalidModel.
	part := model first.
	mediatedEnds := testedClassInstance getPartWholeAssociationsFor: part from: model.
	self assert: (testedClassInstance checkForOverlap: mediatedEnds) equals: true.
	
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testCheckUpperCardinalitiesFor [
	| model part mediatedEnds testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	model := self getValidModel.
	part := model first.
	mediatedEnds := (testedClassInstance getPartWholeAssociationsFor: part from: model) select: [ :end | end memberEnds second upper = 1].
	mediatedEnds := { mediatedEnds first. }.
	self assert: (testedClassInstance checkUpperCardinalitiesFor: mediatedEnds) equals: false.
	
	model := self getInvalidModel.
	part := model first.
	mediatedEnds := testedClassInstance getPartWholeAssociationsFor: part from: model.
	self assert: (testedClassInstance checkUpperCardinalitiesFor: mediatedEnds) equals: true.
	
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testGetPartWholeAssociationsForFrom [
	| wholeA wholeB partA partB association partWholeAssociationA partWholeAssociationB model testedClassInstance |
	testedClassInstance := self getTestedClass basicNew.
	wholeA := self createClass: 'wholeA' withStereotype: OntoUMLKind.
	wholeB := self createClass: 'wholeB' withStereotype: OntoUMLKind.
	partA := self createClass: 'partA' withStereotype: OntoUMLKind.
	partB := self createClass: 'partB' withStereotype: OntoUMLKind.
	association := self createAssociationFrom: wholeA to: partA.
	partWholeAssociationA := self createAssociationFrom: wholeA to: partA with: OntoUMLComponentOf new.
	partWholeAssociationB := self createAssociationFrom: wholeB to: partA with: OntoUMLComponentOf new.
	model := { wholeA. wholeB. partA. partB. association. partWholeAssociationA. partWholeAssociationB. }.
	self assert: (testedClassInstance getPartWholeAssociationsFor: partA from: model) asOrderedCollection 
			equals: { partWholeAssociationA. partWholeAssociationB. } asOrderedCollection.
	self assert: (testedClassInstance getPartWholeAssociationsFor: partB from: model) size equals: 0.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testInvalidModel [
	| part model result |
	model := self getInvalidModel.
	part := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: part withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 1.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testValidModel [
	| part model result |
	model := self getValidModel.
	part := model first.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: part withModel: model).
	self assert: (result results select: [ :message | message isKindOf: VerificationMessageWarning. ]) size equals: 0.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
PartOverAntipatternVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]
