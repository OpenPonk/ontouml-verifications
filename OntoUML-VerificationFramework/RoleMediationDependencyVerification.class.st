"
I am verification for RoleMediationDependency rule. 

Overriden methods: verifiedClass, verifyObject:withModel:, verifiedStereotypes.

New methods: calculateMultiplicity:, calculateMultiplicity:forMediation:, fulfilsMediationDependecy:.
"
Class {
	#name : 'RoleMediationDependencyVerification',
	#superclass : 'StereotypeVerification',
	#category : 'OntoUML-VerificationFramework-Verification-Classes',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
RoleMediationDependencyVerification class >> abbreviation [
	^ 'RoleMediationDependency'.
]

{ #category : 'constants' }
RoleMediationDependencyVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : 'constants' }
RoleMediationDependencyVerification class >> verifiedStereotypes [
	^ { OntoUMLRole.}.
]

{ #category : 'verification' }
RoleMediationDependencyVerification >> fulfillsMediationDependency: aMediation [
	^ (aMediation memberEnds at: 1) lower >= 1 and: (aMediation memberEnds at: 2) lower >= 1
]

{ #category : 'verification' }
RoleMediationDependencyVerification >> putRoleAndItsPredecessors: aRole intoSet: aSet [
	aSet add: aRole.
	aRole generalizations ifEmpty: [ ^ self. ].
	aRole generalizations do: [ :generalization | 
		   ({ OntoUMLRole. OntoUMLRoleMixin. } includes: (self class getStereotype: generalization general) class) ifTrue: [ 
			(aSet includes: generalization general) ifFalse: [
				(self putRoleAndItsPredecessors: generalization general intoSet: aSet) ]. ]. ].	
]

{ #category : 'verification' }
RoleMediationDependencyVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| mediations roleTree |
	roleTree := Set new.
	self putRoleAndItsPredecessors: aVerifiedObject intoSet: roleTree.
	mediations := (aVerifiedModel select: [ :element | element isKindOf: OPUMLAssociation ])
		select: [ :association | (self class getStereotype: association) class = OntoUMLMediation
			and: (association memberEnds anySatisfy: [ :property | roleTree includes: (property type) ]) ].		
	mediations := mediations select: [ :mediation | self fulfillsMediationDependency: mediation ].
	mediations size < 1 ifTrue: [ ^ {VerificationMessageError createFor: aVerifiedObject withVerification: self withText:
			(self class getStereotype: aVerifiedObject) class name , ' has to have at least one mediation with multiplicities on both ends >= 1.'} ].
	^ {}.
]
