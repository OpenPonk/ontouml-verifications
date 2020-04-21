"
I am verification for RelatorMediationDependency rule. 

Overriden methods: verifiedClass, verifyObject:withModel:, verifiedStereotypes.

New methods: getMultiplicity:for:.
"
Class {
	#name : #RelatorMediationDependencyVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
RelatorMediationDependencyVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RelatorMediationDependencyVerification class >> verifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #verification }
RelatorMediationDependencyVerification >> getMultiplicity: aMediation for: aVerifiedObject [
	| multiplicity |
	multiplicity := (aMediation memberEnds
		reject: [ :mediationProperty | mediationProperty type = aVerifiedObject ])
		at: 1.
	^ multiplicity lower
]

{ #category : #verification }
RelatorMediationDependencyVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
 	| mediations totalMultiplicity |
	mediations := ((aVerifiedModel select: [ :element | element isKindOf: OPUMLAssociation ])		
		select: [ :association | (self class getStereotype: association) class = OntoUMLMediation ])
		select: [ :mediation | mediation memberEnds anySatisfy: 
				[ :property | property type = aVerifiedObject or: property owningClass = aVerifiedObject ] ]. 
	mediations ifEmpty: [ ^ {(VerificationMessageError createFor: aVerifiedObject withVerification: self withText: (self class getStereotype: aVerifiedObject) class name , ' has to be part of at least one mediation.')} ].
	totalMultiplicity := 0.
	mediations do: [ :mediation | totalMultiplicity := totalMultiplicity + (self getMultiplicity: mediation for: aVerifiedObject ) ].
	totalMultiplicity < 2 ifTrue: [ ^ {VerificationMessageError createFor: aVerifiedObject withVerification: self withText: (self class getStereotype: aVerifiedObject) class name , ' has to have total multiplicity on the other side of mediations equal or greater than 2.'} ].
	^ {}.
	
]
