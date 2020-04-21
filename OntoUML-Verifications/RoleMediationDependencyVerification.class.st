"
I am verification for RoleMediationDependency rule. 

Overriden methods: verifiedClass, verifyObject:withModel:, verifiedStereotypes.

New methods: calculateMultiplicity:, calculateMultiplicity:forMediation:, fulfilsMediationDependecy:.
"
Class {
	#name : #RoleMediationDependencyVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
RoleMediationDependencyVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RoleMediationDependencyVerification class >> verifiedStereotypes [
	^ { OntoUMLRole.}.
]

{ #category : #verification }
RoleMediationDependencyVerification >> fulfilsMediationDependency: aMediation [
	^ (aMediation memberEnds at: 1) lower >= 1 and: (aMediation memberEnds at: 2) lower >= 1
]

{ #category : #verification }
RoleMediationDependencyVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
	| mediations |
	mediations := (aVerifiedModel select: [ :element | element isKindOf: OPUMLAssociation ])
		select: [ :association | (self class getStereotype: association) class = OntoUMLMediation
			and: (association memberEnds anySatisfy: [ :property | property type = aVerifiedObject ]) ].		
	mediations := mediations select: [ :mediation | self fulfilsMediationDependency: mediation ].
	mediations size < 1 ifTrue: [ ^ {VerificationMessageError createFor: aVerifiedObject withVerification: self withText:
			(self class getStereotype: aVerifiedObject) class name , ' has to have at least one mediation with multiplicities on both ends >= 1.'} ].
	^ {}.
]
