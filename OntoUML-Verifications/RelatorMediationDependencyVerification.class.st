Class {
	#name : #RelatorMediationDependencyVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
RelatorMediationDependencyVerification class >> verifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
RelatorMediationDependencyVerification class >> verifiedStereotypes [
	^ {OntoUMLRelator}
]

{ #category : #verification }
RelatorMediationDependencyVerification >> getMultiplicity: arg1 for: arg2 [
	| tmp1 |
	tmp1 := (arg1 memberEnds reject: [ :arg3 | arg3 type = arg2 ]) at: 1.
	^ tmp1 lower
]

{ #category : #verification }
RelatorMediationDependencyVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 tmp3 |
	tmp1 := ((arg2 select: [ :arg3 | arg3 isKindOf: OPUMLAssociation ])
		select: [ :arg4 | (self class getStereotype: arg4) class = OntoUMLMediation ])
		select: [ :arg5 | 
			arg5 memberEnds
				anySatisfy: [ :arg6 | arg6 type = arg1 or: arg6 owningClass = arg1 ] ].
	tmp1
		ifEmpty: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' has to be part of at least one mediation.')} ].
	tmp3 := 0.
	tmp1
		do: [ :arg7 | tmp3 := tmp3 + (self getMultiplicity: arg7 for: arg1) ].
	tmp3 < 2
		ifTrue: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' has to have total multiplicity on the other side of mediations equal or greater than 2.')} ].
	^ {}
]
