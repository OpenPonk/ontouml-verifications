Class {
	#name : #PartOfGeneralizationSetVerification,
	#superclass : #StereotypeVerification,
	#category : #'OntoUML-Verifications'
}

{ #category : #constants }
PartOfGeneralizationSetVerification class >> verifiedClass [
	^ OPUMLClass
]

{ #category : #constants }
PartOfGeneralizationSetVerification class >> verifiedStereotypes [
	^ {OntoUMLPhase}
]

{ #category : #verification }
PartOfGeneralizationSetVerification >> verifyObject: arg1 withModel: arg2 [
	| tmp1 |
	tmp1 := arg1 generalizations
		flatCollect: [ :arg3 | arg3 generalizationSets ].
	tmp1
		ifEmpty: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' has to be part of one or more generalisation sets that are disjoint and complete.')} ].
	((tmp1 collect: [ :arg4 | arg4 isDisjoint and: arg4 isCovering ])
		anySatisfy: [ :arg5 | arg5 not ])
		ifTrue: [ ^ {(VerificationMessageError
				createFor: arg1
				withVerification: self
				withText:
					(self class getStereotype: arg1) class name
						, ' is part of one or more generalisation sets that are not disjoint or not complete.')} ].
	^ {}
]
