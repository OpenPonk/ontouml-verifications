Class {
	#name : #RoleMediationDependencyVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
RoleMediationDependencyVerification class >> verifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
RoleMediationDependencyVerification class >> verifiedStereotypes [
	^ {OntoUMLRole}
]

{ #category : #verification }
RoleMediationDependencyVerification >> fulfilsMediationDependency: arg1 [
	^ (arg1 memberEnds at: 1) lower >= 1
		and: (arg1 memberEnds at: 2) lower >= 1
]

{ #category : #verification }
RoleMediationDependencyVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 |
	tmp1 := (arg2 select: [ :arg3 | arg3 isKindOf: OPUMLAssociation ])
		select: [ :arg4 | 
			(self class getStereotype: arg4) class = OntoUMLMediation
				and: (arg4 memberEnds anySatisfy: [ :arg5 | arg5 type = arg1 ]) ].
	tmp1 := tmp1
		select: [ :arg6 | self fulfilsMediationDependency: arg6 ].
	tmp1 size < 1
		ifTrue: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' has to have at least one mediation with multiplicities on both ends >= 1.')} ].
	^ {}
]
