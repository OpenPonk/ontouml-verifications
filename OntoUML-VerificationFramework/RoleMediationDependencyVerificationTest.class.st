"
I represent tests for RoleMediationDependencyVerification.
"
Class {
	#name : #RoleMediationDependencyVerificationTest,
	#superclass : #StereotypeVerificationTest,
	#category : #'OntoUML-VerificationFramework-Verification-Tests'
}

{ #category : #constants }
RoleMediationDependencyVerificationTest >> getTestedClass [
	^ RelationDependencyVerification.
]

{ #category : #constants }
RoleMediationDependencyVerificationTest >> getVerifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RoleMediationDependencyVerificationTest >> getVerifiedStereotypes [
	^{ OntoUMLRole.}.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testFulfillsMediationDependency [
	| kind role mediation |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	role := OPUMLClass new applyStereotype: OntoUMLRole new.
	mediation := self createAssociationFrom: kind to: role.
	self assert: (self getTestedClass basicNew fulfillsRelationalDependency: mediation) equals: true.
	(mediation memberEnds at:1) lowerValue value: 0.
	self assert: (self getTestedClass basicNew fulfillsRelationalDependency: mediation) equals: false.
	
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testInvalidModel [
	| role model result |
	role := OPUMLClass new.
	role applyStereotype: OntoUMLRole new.	
	model := { role. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assert: (result results select: [ :message | message class = VerificationMessageError.]) size equals: 1.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testNew [
	self newTest.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testValidModel [
	| relator association role model result |
	role := OPUMLClass new.
	role applyStereotype: OntoUMLRole new.
	relator := OPUMLClass new.
	relator applyStereotype: OntoUMLRelator new.
	association := self createAssociationFrom: relator to: role.
	association applyStereotype: OntoUMLMediation new.
	model := { role. relator. association. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assert: result results size equals: 0.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifiedClass [
	self verifiedClassTest.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifiedStereotypes [
	super testVerifiedStereotypes.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifyObjectWithModel [
	self testInvalidModel.
	self testValidModel.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifyWithModel [
	self testInvalidModel.
	self testValidModel.
]
