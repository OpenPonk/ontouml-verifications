Class {
	#name : #AllowedSubtypesVerification,
	#superclass : #Verification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
AllowedSubtypesVerification class >> validSubtypes [
	| tmp1 |
	tmp1 := Dictionary new.
	tmp1
		add:
			OntoUMLKind
				->
					{OntoUMLSubKind.
					OntoUMLPhase.
					OntoUMLRole};
		add:
			OntoUMLSubKind
				->
					{OntoUMLSubKind.
					OntoUMLPhase.
					OntoUMLRole};
		add:
			OntoUMLCollective
				->
					{OntoUMLSubKind.
					OntoUMLPhase.
					OntoUMLRole};
		add:
			OntoUMLQuantity
				->
					{OntoUMLSubKind.
					OntoUMLPhase.
					OntoUMLRole};
		add:
			OntoUMLRelator
				->
					{OntoUMLSubKind.
					OntoUMLPhase.
					OntoUMLRole};
		add:
			OntoUMLPhase
				->
					{OntoUMLPhase.
					OntoUMLRole};
		add: OntoUMLRole -> {OntoUMLRole};
		add:
			OntoUMLCategory
				->
					{OntoUMLKind.
					OntoUMLSubKind.
					OntoUMLCollective.
					OntoUMLQuantity.
					OntoUMLRelator.
					OntoUMLCategory};
		add:
			OntoUMLRoleMixin
				->
					{OntoUMLRole.
					OntoUMLRoleMixin};
		add:
			OntoUMLMixin
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
					OntoUMLMixin};
		add: OntoUMLMode -> {};
		add: OntoUMLQuality -> {}.
	^ tmp1
]

{ #category : #constants }
AllowedSubtypesVerification class >> verifiedClass [
	^ OPUMLGeneralization
]

{ #category : #verification }
AllowedSubtypesVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 tmp2 tmp3 |
	tmp2 := self class getStereotype: arg1 general.
	tmp3 := self class getStereotype: arg1 specific.
	(tmp2 isNil or: tmp3 isNil)
		ifTrue: [ ^ {} ].
	((self class validSubtypes at: tmp2 class)
		anySatisfy: [ :arg3 | tmp3 class = arg3 ])
		ifFalse: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText: tmp3 class name , ' cannot be subtype of ' , tmp2 class name , '.')} ].
	^ {}
]
