Class {
	#name : #IdentityRequiredVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
IdentityRequiredVerification class >> identityProviders [
	^ {OntoUMLKind.
	OntoUMLCollective.
	OntoUMLQuantity.
	OntoUMLRelator.
	OntoUMLMode}
]

{ #category : #constants }
IdentityRequiredVerification class >> verifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
IdentityRequiredVerification class >> verifiedStereotypes [
	^ {OntoUMLSubKind.
	OntoUMLPhase.
	OntoUMLRole}
]

{ #category : #verification }
IdentityRequiredVerification >> countIdentitySources: arg1 fromModel: arg2 withAccumulator: arg3 [
	| tmp1 tmp2 tmp4 |
	(arg3 anySatisfy: [ :arg4 | arg4 = arg1 ])
		ifTrue: [ ^ Float negativeInfinity ].
	arg3 add: arg1.
	tmp1 := self class getStereotype: arg1.
	(self hasIdentity: tmp1)
		ifTrue: [ ^ 1 ].
	tmp4 := 0.
	tmp2 := self getSuperClasses: arg1 fromModel: arg2.
	tmp2
		do: [ :arg5 | 
			tmp4 := tmp4
				+ (self countIdentitySources: arg5 fromModel: arg2 withAccumulator: arg3) ].
	^ tmp4
]

{ #category : #verification }
IdentityRequiredVerification >> getSuperClasses: arg1 fromModel: arg2 [
	^ ((arg2 select: [ :arg3 | arg3 class = OPUMLGeneralization ])
		select: [ :arg4 | arg4 specific = arg1 ])
		collect: [ :arg5 | arg5 general ]
]

{ #category : #verification }
IdentityRequiredVerification >> hasIdentity: arg1 [
	^ self class identityProviders
		anySatisfy: [ :arg2 | arg2 = arg1 class ]
]

{ #category : #verification }
IdentityRequiredVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 tmp2 |
	tmp2 := Set new.
	tmp1 := self
		countIdentitySources: arg1
		fromModel: arg2
		withAccumulator: tmp2.
	tmp1 < 0
		ifTrue: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' has loop in generalisation structure.')} ].
	tmp1 = 0
		ifTrue: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText: (self class getStereotype: arg1) class name , ' has no identity.')} ].
	tmp1 > 1
		ifTrue: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' has multiple identity sources.')} ].
	^ {}
]
