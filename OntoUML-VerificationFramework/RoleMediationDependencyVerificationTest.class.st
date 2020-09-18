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
	^ RoleMediationDependencyVerification.
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
RoleMediationDependencyVerificationTest >> invalidObjectTest [
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
RoleMediationDependencyVerificationTest >> testCanVerify [
	self canVerifyTest.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testFulfilsMediationDependency [
	| kind role mediation |
	kind := OPUMLClass new applyStereotype: OntoUMLKind new.
	role := OPUMLClass new applyStereotype: OntoUMLRole new.
	mediation := self createAssociationFrom: kind to: role.
	self assert: (self getTestedClass basicNew fulfilsMediationDependency: mediation) equals: true.
	(mediation memberEnds at:1) lowerValue value: 0.
	self assert: (self getTestedClass basicNew fulfilsMediationDependency: mediation) equals: false.
	
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testNew [
	self newTest.
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
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> testVerifyWithModel [
	self validObjectTest.
	self invalidObjectTest.
]

{ #category : #tests }
RoleMediationDependencyVerificationTest >> validObjectTest [
	| role model result |
	role := OPUMLClass new.
	role applyStereotype: OntoUMLRole new.	
	model := { role. }.
	result := VerificationResults new.
	result addResults: (self getTestedClass verify: role withModel: model).
	self assert: result results size equals: 1.
]
