"
I represent tests for RelatorMediationDependencyVerification.
"
Class {
	#name : 'RelatorMediationDependencyVerificationTest',
	#superclass : 'StereotypeVerificationTest',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
RelatorMediationDependencyVerificationTest >> getTestedClass [
	^ RelatorMediationDependencyVerification.
]

{ #category : 'constants' }
RelatorMediationDependencyVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
RelatorMediationDependencyVerificationTest >> getVerifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testGetMultiplicityFor [

	| kind relator mediation |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	relator := OPUMLClass new applyStereotype: OntoUMLRelator new.
	mediation := self createAssociationFrom: kind to: relator.
	self assert: (self getTestedClass basicNew getUpperBoundMultiplicityOf: mediation for: relator) equals: 1.
	mediation memberEnds first lowerValue value: 0.
	self assert: (self getTestedClass basicNew getUpperBoundMultiplicityOf: mediation for: relator) equals: 0
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testInvalidModel [

	| relator association kind model result message |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	relator := OPUMLClass new.
	relator applyStereotype: OntoUMLRelator new.
	association := self createAssociationFrom: relator to: kind.
	association applyStereotype: OntoUMLMediation new.
	model := {
		         kind.
		         relator.
		         association }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assert: result results size equals: 1.
	message := result results anyOne.
	self assert: message class identicalTo: VerificationMessageError.
	self assert: message objectReference identicalTo: relator.
	self assert: message verification class identicalTo: RelatorMediationDependencyVerification.
	self
		assert: message messageText
		equals: 'OntoUMLRelator has to have total multiplicity on the other side of mediations equal or greater than 2.'.
	self assert: message documentationReference equals: 'https://ontouml.readthedocs.io/en/latest/classes/sortals/relator/index.html'
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testNew [
	self newTest.
]

{ #category : 'tests' }
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
	model := {
		         kind.
		         secondKind.
		         relator.
		         association.
		         secondAssociation }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: relator withModel: model).
	self assertEmpty: result results
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : 'tests' }
RelatorMediationDependencyVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
