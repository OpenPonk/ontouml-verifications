Class {
	#name : #AllowedSupertypesVerification,
	#superclass : #Verification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
AllowedSupertypesVerification class >> validSupertypes [
	| tmp1 |
	tmp1 := Dictionary new.
	tmp1
		add:
			OntoUMLKind
				->
					{OntoUMLCategory.
					OntoUMLMixin};
		add:
			OntoUMLSubKind
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLCategory.
					OntoUMLMixin};
		add:
			OntoUMLCollective
				->
					{OntoUMLCategory.
					OntoUMLMixin};
		add:
			OntoUMLQuantity
				->
					{OntoUMLCategory.
					OntoUMLMixin};
		add:
			OntoUMLRelator
				->
					{OntoUMLCategory.
					OntoUMLMixin};
		add:
			OntoUMLPhase
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLPhase.
					OntoUMLMixin};
		add:
			OntoUMLRole
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLPhase.
					OntoUMLRole.
					OntoUMLRoleMixin.
					OntoUMLMixin};
		add:
			OntoUMLCategory
				->
					{OntoUMLCategory.
					OntoUMLMixin};
		add:
			OntoUMLRoleMixin
				->
					{OntoUMLRoleMixin.
					OntoUMLMixin};
		add: OntoUMLMixin -> {OntoUMLMixin};
		add: OntoUMLMode -> {};
		add: OntoUMLQuality -> {}.
	^ tmp1
]

{ #category : #constants }
AllowedSupertypesVerification class >> verifiedClass [
	^ OPUMLGeneralization
]

{ #category : #verification }
AllowedSupertypesVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 tmp2 |
	tmp1 := self class getStereotype: arg1 general.
	tmp2 := self class getStereotype: arg1 specific.
	(tmp1 isNil or: tmp2 isNil)
		ifTrue: [ ^ {} ].
	((self class validSupertypes at: tmp2 class)
		anySatisfy: [ :arg3 | tmp1 class = arg3 ])
		ifFalse: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText: tmp1 class name , ' cannot be supertype of ' , tmp2 class name , '.')} ].
	^ {}
]
