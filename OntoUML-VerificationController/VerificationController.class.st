Class {
	#name : #VerificationController,
	#superclass : #Object,
	#category : #'OntoUML-VerificationController'
}

{ #category : #verification }
VerificationController >> getVerifications [
	^ (RPackageOrganizer default packageNamed: 'OntoUML-Verifications')
		definedClasses
]

{ #category : #verification }
VerificationController >> getVerifiedObjects: arg1 [
	| tmp1 tmp2 |
	tmp1 := arg1 packagedElements
		select: [ :arg2 | arg2 isKindOf: OPUMLElement ].
	tmp2 := tmp1 flatCollect: [ :arg3 | arg3 generalizations ].
	tmp1
		addAll: tmp2;
		addAll: (tmp2 flatCollect: [ :arg4 | arg4 generalizationSets ]).
	^ tmp1
]

{ #category : #verification }
VerificationController >> verify: arg1 [
	| tmp1 tmp2 tmp3 |
	tmp1 := self getVerifiedObjects: arg1.
	tmp2 := self getVerifications.
	tmp3 := VerificationResults new.
	tmp1
		do: [ :arg2 | 
			self
				verifySingleObject: arg2
				withVerifications: tmp2
				withModel: tmp1
				withResults: tmp3 ].
	^ tmp3
]

{ #category : #verification }
VerificationController >> verifySingleObject: arg1 withVerifications: arg2 withModel: arg3 withResults: arg4 [
	^ arg2
		do: [ :arg5 | arg4 addResults: (arg5 verify: arg1 withModel: arg3) ]
]
