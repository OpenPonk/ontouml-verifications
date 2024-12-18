"
I am verification for AllowedSupertypes rule. 

Overriden methods: verifiedClass, verifyObject:withModel:

New methods: validSupertypes.
"
Class {
	#name : 'AllowedSupertypesVerification',
	#superclass : 'Verification',
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : 'OpenPonk-OntoUML-Verifications-Verification-Classes',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Verification-Classes'
}

{ #category : 'constants' }
AllowedSupertypesVerification class >> abbreviation [
	^ 'AllowedSupertypes'.
]

{ #category : 'updating' }
AllowedSupertypesVerification class >> getUpdatedMessageCode: aVerificationUpdater [

	| validSupertypesCode |
	validSupertypesCode := 'validSupertypes
	"I return dictionary containing collections of allowed supertypes for each OntoUML element stereotype.
	Code generated by getUpdatedMessageCode."

	| result |
	result := Dictionary new.'.
	aVerificationUpdater classSpecifications do: [ :classSpecification |
		self checkStringForCodeInjection: classSpecification name.
		validSupertypesCode := validSupertypesCode
		                       , (String with: Character cr)
		                       , '	result add: self validSupertypesFor'
		                       , classSpecification name , '.' ].
	validSupertypesCode := validSupertypesCode
	                       , (String with: Character cr) , '	^ result.'.
	^ validSupertypesCode
]

{ #category : 'updating' }
AllowedSupertypesVerification class >> getValidSupertypesForCode: aStereotype fromCollection: aCollection [

	| methodTemplate |
	self checkStringForCodeInjection: aStereotype.
	methodTemplate := 'validSupertypesFor' , aStereotype , String cr
	                  ,
	                  '	"I return association between OntoUML element stereotype '
	                  , aStereotype , ' and its allowed supertypes.'
	                  , String cr
	                  ,
	                  '	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"'
	                  , String cr , String cr , '	^ OntoUML'
	                  , aStereotype , ' -> { '.
	aCollection do: [ :item |
		self checkStringForCodeInjection: item.
		methodTemplate := methodTemplate , 'OntoUML' , item , '. ' ].
	methodTemplate := methodTemplate , '}.'.
	^ methodTemplate
]

{ #category : 'updating' }
AllowedSupertypesVerification class >> setValidSupertypesFor: aStereotype fromCollection: aCollection [
	| validSupertypesForCode |
	validSupertypesForCode := self getValidSupertypesForCode: aStereotype fromCollection: aCollection.
	self updateMessage: validSupertypesForCode withClassification: 'constants'.
]

{ #category : 'updating' }
AllowedSupertypesVerification class >> updateFrom: aVerificationUpdater [
	| updatedMessageCode |
	updatedMessageCode := self getUpdatedMessageCode: aVerificationUpdater.
	aVerificationUpdater classSpecifications do: [ :classSpecification |
		self setValidSupertypesFor: classSpecification name fromCollection: classSpecification supertypes. ]. 	
	self updateMessage: updatedMessageCode  withClassification: 'constants'.
	
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypes [
	"I return dictionary containing collections of allowed supertypes for each OntoUML element stereotype.
	Code generated by getUpdatedMessageCode."

	| result |
	result := Dictionary new.
	result add: self validSupertypesForKind.
	result add: self validSupertypesForSubKind.
	result add: self validSupertypesForCollective.
	result add: self validSupertypesForPhase.
	result add: self validSupertypesForQuantity.
	result add: self validSupertypesForRelator.
	result add: self validSupertypesForRole.
	result add: self validSupertypesForMode.
	result add: self validSupertypesForQuality.
	result add: self validSupertypesForCategory.
	result add: self validSupertypesForMixin.
	result add: self validSupertypesForRoleMixin.
	result add: self validSupertypesForPhaseMixin.
	^ result.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForCategory [
	"I return association between OntoUML element stereotype Category and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLCategory -> { OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForCollective [
	"I return association between OntoUML element stereotype Collective and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLCollective -> { OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForKind [
	"I return association between OntoUML element stereotype Kind and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLKind -> { OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForMixin [
	"I return association between OntoUML element stereotype Mixin and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLMixin -> { OntoUMLMixin. OntoUMLCategory. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForMode [
	"I return association between OntoUML element stereotype Mode and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLMode -> { OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForPhase [
	"I return association between OntoUML element stereotype Phase and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLPhase -> { OntoUMLKind. OntoUMLSubKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLRelator. OntoUMLPhase. OntoUMLMixin. OntoUMLPhaseMixin. OntoUMLMode. OntoUMLQuality. OntoUMLCategory. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForPhaseMixin [
	"I return association between OntoUML element stereotype PhaseMixin and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLPhaseMixin -> { OntoUMLMixin. OntoUMLPhaseMixin. OntoUMLCategory. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForQuality [
	"I return association between OntoUML element stereotype Quality and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLQuality -> { OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForQuantity [
	"I return association between OntoUML element stereotype Quantity and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLQuantity -> { OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForRelator [
	"I return association between OntoUML element stereotype Relator and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLRelator -> { OntoUMLCategory. OntoUMLMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForRole [
	"I return association between OntoUML element stereotype Role and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLRole -> { OntoUMLKind. OntoUMLSubKind. OntoUMLCollective. OntoUMLPhase. OntoUMLQuantity. OntoUMLRelator. OntoUMLRole. OntoUMLRoleMixin. OntoUMLMixin. OntoUMLMode. OntoUMLQuality. OntoUMLCategory. OntoUMLPhaseMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForRoleMixin [
	"I return association between OntoUML element stereotype RoleMixin and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLRoleMixin -> { OntoUMLMixin. OntoUMLRoleMixin. OntoUMLCategory. OntoUMLPhaseMixin. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> validSupertypesForSubKind [
	"I return association between OntoUML element stereotype SubKind and its allowed supertypes.
	I am generated by getValidSupertypesFor:FromCollection: and tested by testValidSupertypesFor"

	^ OntoUMLSubKind -> { OntoUMLKind. OntoUMLSubKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLRelator. OntoUMLCategory. OntoUMLMixin. OntoUMLMode. OntoUMLQuality. }.
]

{ #category : 'constants' }
AllowedSupertypesVerification class >> verifiedClass [
	^ OPUMLGeneralization.
]

{ #category : 'verification' }
AllowedSupertypesVerification >> verifyObject: aVerifiedGeneralization withModel: aVerifiedModel [
	| generalStereotype specificStereotype |	
	generalStereotype := self class getStereotype: aVerifiedGeneralization general.
	specificStereotype := self class getStereotype: aVerifiedGeneralization specific.
	(generalStereotype isNil or: specificStereotype isNil) ifTrue: [ ^ {} ].
	((self class validSupertypes at: specificStereotype class) 
		anySatisfy: [ :class | generalStereotype class = class ])
			ifFalse:[ ^ {VerificationMessageError createFor: aVerifiedGeneralization withVerification: self withText: (generalStereotype class name , ' cannot be supertype of ' , specificStereotype class name ,'.') documentationReference: (OntoUMLDotOrgReferences getDefinitionReferenceFor: aVerifiedGeneralization general ) } ].
	^ {}.
]
