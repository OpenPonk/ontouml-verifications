"
I represent tests for RelatorMediationDependencyVerification.
"
Class {
	#name : #RelatorMediationDependencyVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Verification-Tests'
}

{ #category : #constants }
RelatorMediationDependencyVerificationTest >> getTestedClass [
	^ RelatorMediationDependencyVerification.
]

{ #category : #constants }
RelatorMediationDependencyVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RelatorMediationDependencyVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testGetMultiplicityFor [
	| kind relator mediation |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	relator := OPUMLClass new applyStereotype: OntoUMLRelator new.
	mediation := self createAssociationFrom: kind to: relator.
	self assert: (self getTestedClass basicNew getUpperBoundMultiplicityOf: mediation for: relator) equals: 1.
	(mediation memberEnds at:1) lowerValue value: 0.
	self assert: (self getTestedClass basicNew getUpperBoundMultiplicityOf: mediation for: relator) equals: 0.
	
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testInvalidModel [
	| relator association kind model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	relator := OPUMLClass new.
	relator applyStereotype: OntoUMLRelator new.
	association := self createAssociationFrom: relator to: kind.
	association applyStereotype: OntoUMLMediation new.
	model := { kind. relator. association. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: result results size equals: 1.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testValidModel [
	| relator association kind secondAssociation secondKind model result |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	secondKind := OPUMLClass new.
	secondKind applyStereotype: OntoUMLKind new.
	relator := OPUMLClass new.
	relator applyStereotype: OntoUMLRelator new.
	association := self createAssociationFrom: relator to: kind.
	association applyStereotype: OntoUMLMediation new.
	secondAssociation := self createAssociationFrom: relator to: secondKind.
	secondAssociation applyStereotype: OntoUMLMediation new.
	model := { kind. secondKind. relator. association. secondAssociation.}.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : #tests }
RelatorMediationDependencyVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
