Class {
	#name : #RelationSourceVerification,
	#superclass : #Verification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
RelationSourceVerification class >> validSources [
	| tmp1 |
	tmp1 := Dictionary new.
	tmp1
		add:
			OntoUMLFormal
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLPhase.
					OntoUMLRole.
					OntoUMLCategory.
					OntoUMLRoleMixin.
					OntoUMLMixin.
					OntoUMLMode.
					OntoUMLQuality};
		add:
			OntoUMLMaterial
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLPhase.
					OntoUMLRole.
					OntoUMLCategory.
					OntoUMLRoleMixin.
					OntoUMLMixin.
					OntoUMLMode.
					OntoUMLQuality};
		add: OntoUMLMediation -> {OntoUMLRelator};
		add:
			OntoUMLCharacterization
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLPhase.
					OntoUMLRole.
					OntoUMLCategory.
					OntoUMLRoleMixin.
					OntoUMLMixin.
					OntoUMLMode.
					OntoUMLQuality};
		add:
			OntoUMLDerivation
				->
					{OntoUMLSubKind.
					OntoUMLRelator.
					OntoUMLPhase.
					OntoUMLRole.
					OntoUMLCategory.
					OntoUMLRoleMixin.
					OntoUMLMixin.
					OntoUMLMode.
					OntoUMLQuality};
		add:
			OntoUMLComponentOf
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLPhase.
					OntoUMLRole.
					OntoUMLCategory.
					OntoUMLRoleMixin.
					OntoUMLMixin.
					OntoUMLMode.
					OntoUMLQuality};
		add:
			OntoUMLContainment
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLPhase.
					OntoUMLRole.
					OntoUMLCategory.
					OntoUMLRoleMixin.
					OntoUMLMixin.
					OntoUMLMode.
					OntoUMLQuality};
		add: OntoUMLMemberOf -> {OntoUMLCollective};
		add:
			OntoUMLSubCollectionOf
				->
					{OntoUMLSubKind.
					OntoUMLCollective};
		add: OntoUMLSubQuantityOf -> {OntoUMLQuality}.
	^ tmp1
]

{ #category : #constants }
RelationSourceVerification class >> verifiedClass [
	^ OPUMLAssociation
]

{ #category : #verification }
RelationSourceVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 tmp2 tmp3 |
	tmp3 := self class getStereotype: arg1.
	tmp3 ifNil: [ ^ {} ].
	tmp1 := arg1 memberEnds at: 1.
	tmp2 := self class getStereotype: tmp1 type.
	tmp2 ifNil: [ ^ {} ].
	((self class validSources at: tmp3 class)
		anySatisfy: [ :arg3 | tmp2 class = arg3 ])
		ifFalse: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					tmp2 class name , ' cannot be source of ' , tmp3 class name
						, ' association')} ].
	^ {}
]
