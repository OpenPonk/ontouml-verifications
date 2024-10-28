Class {
	#name : 'RelationEndVerification',
	#superclass : 'Verification',
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : 'OntoUML-VerificationFramework-Verification-Classes',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Verification-Classes'
}

{ #category : 'instance creation' }
RelationEndVerification class >> abbreviation [
	^ 'RelationEndVerification'.
]

{ #category : 'testing' }
RelationEndVerification class >> isAbstract [

	^ self = RelationEndVerification
]

{ #category : 'verification' }
RelationEndVerification >> getDirectParentsOf: aChild fromModel: aModel [
	^ ((aModel select: [ :element | element class = OPUMLGeneralization ])
		select: [ :generalizaion | generalizaion  specific = aChild ])
			collect: [ :generalization | generalization general ].
]

{ #category : 'verification' }
RelationEndVerification >> getErrorMessageFor: aEnd withAssociation: aAssociation [
	^ self subclassResponsibility.
]

{ #category : 'verification' }
RelationEndVerification >> getParentsOf: aChild fromModel: aModel [
	| parentAccumulator |
	parentAccumulator := Set new.
	self getParentsOf: aChild fromModel: aModel withAccumulator: parentAccumulator.
	^ parentAccumulator.
]

{ #category : 'verification' }
RelationEndVerification >> getParentsOf: aChild fromModel: aModel withAccumulator: aParentAccumulator [ 
	| directParents |
	directParents := (self getDirectParentsOf: aChild fromModel: aModel)
		reject: [ :parent | aParentAccumulator includes: parent. ].
	aParentAccumulator addAll: directParents.
	directParents do: [ :parent | 
		self getParentsOf: parent fromModel: aModel withAccumulator: aParentAccumulator ].
	
]

{ #category : 'verification' }
RelationEndVerification >> getVerifiedEnd: aVerifiedAssociation [
	^ self subclassResponsibility.
]

{ #category : 'verification' }
RelationEndVerification >> isEndValid: aEnd withModel: aModel withAssociationStereotype: aAssociationStereotype [
	| endStereotype |
	endStereotype := self class getStereotype: aEnd.
	endStereotype ifNil: [ ^ {} ]. 
	((self validStereotypesForEnd at: aAssociationStereotype class) anySatisfy: [ :validsource | endStereotype class = validsource ])
		ifTrue: [ ^ true. ].
	"ifFalse"
	(endStereotype class = OntoUMLSubKind) 
		ifFalse: [ ^false. ]
		ifTrue: [ ^ self isParentOfEndValid: aEnd withModel: aModel withAssociationStereotype: aAssociationStereotype ].
]

{ #category : 'verification' }
RelationEndVerification >> isParentOfEndValid: aEnd withModel: aModel withAssociationStereotype: aAssociationStereotype [
	| endParents endParentStereotypes |
	endParents := self getParentsOf: aEnd fromModel: aModel.
	endParents ifEmpty: [ ^ false. ].
	endParentStereotypes := endParents collect: [ :endParent | self class getStereotypeClass: endParent].
	^ (self validStereotypesForEnd at: aAssociationStereotype class)
			anySatisfy: [ :validsource | endParentStereotypes includes: validsource.].
]

{ #category : 'verification' }
RelationEndVerification >> validStereotypesForEnd [
	^ self subclassResponsibility.
]

{ #category : 'verification' }
RelationEndVerification >> verifyObject: aVerifiedAssociation withModel: aVerifiedModel [
	| end associationStereotype |
	associationStereotype := self class getStereotype: aVerifiedAssociation.
	associationStereotype ifNil: [ ^ {} ]. 
	end := self getVerifiedEnd: aVerifiedAssociation .
	(self isEndValid: end withModel: aVerifiedModel withAssociationStereotype: associationStereotype)
		ifFalse: [ ^ {self getErrorMessageFor: end withAssociation: aVerifiedAssociation.}. ].
	^ {}.
]
