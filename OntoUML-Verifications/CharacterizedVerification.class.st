Class {
	#name : #CharacterizedVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
CharacterizedVerification class >> verifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
CharacterizedVerification class >> verifiedStereotypes [
	^ {OntoUMLMode.
	OntoUMLQuality}
]

{ #category : #verification }
CharacterizedVerification >> verifyMultiplicity: arg1 forCharacterization: arg2 [
	| tmp1 |
	tmp1 := (arg2 memberEnds reject: [ :arg3 | arg3 type = arg1 ]) at: 1.
	(tmp1 lower = 1 and: tmp1 upper = 1)
		ifFalse: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' characterization is invalid because other end of characteristion does not have multiplicity set to 1.')} ].
	^ {}
]

{ #category : #verification }
CharacterizedVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 |
	tmp1 := (arg2 select: [ :arg3 | arg3 isKindOf: OPUMLAssociation ])
		select: [ :arg4 | 
			(self class getStereotype: arg4) class = OntoUMLCharacterization
				and: (arg4 memberEnds anySatisfy: [ :arg5 | arg5 type = arg1 ]) ].
	tmp1 size < 1
		ifTrue: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' has to have at least one characterization.')} ].
	^ tmp1
		flatCollect: [ :arg6 | self verifyMultiplicity: arg1 forCharacterization: arg6 ]
]
