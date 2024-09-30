"
I am verification for BinOver anti-pattern. 

Overriden methods: verifiedClass, verifyObject:withModel:

Documentation for BinOver anti-pattern can be found on ontouml.org. Direct link is located in OntoUMLDotOrgReferences getDefinitionReferenceForBinOver.
"
Class {
	#name : 'BinOverAntipatternVerification',
	#superclass : 'Verification',
	#traits : 'TCodeInjectionChecker + TClassUpdater',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait',
	#category : 'OntoUML-VerificationFramework-Antipattern-Classes',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Antipattern-Classes'
}

{ #category : 'constants' }
BinOverAntipatternVerification class >> abbreviation [
	^ 'BinOver'.
]

{ #category : 'constants' }
BinOverAntipatternVerification class >> identityProviders [
	^ { OntoUMLKind. OntoUMLCollective. OntoUMLQuantity. OntoUMLRelator. OntoUMLMode. OntoUMLQuality. }
]

{ #category : 'constants' }
BinOverAntipatternVerification class >> verifiedClass [
	^ OPUMLAssociation.
]

{ #category : 'verification' }
BinOverAntipatternVerification >> calculateIdentityPathFor: aSource withProvider: aIdentityProvider [
	| pathDictionary |
	pathDictionary := self getAncestorTreeFor: aSource withIdentityProvider: aIdentityProvider.
	^ self getIdentityPathFor: aSource withProvider: aIdentityProvider from: pathDictionary.
]

{ #category : 'verification' }
BinOverAntipatternVerification >> checkBinOverFor: aSource and: aTarget from: aModel [
	| sourceStereotype targetStereotype sourceAndAncestors targetAndAncestors | 
	sourceStereotype := OntoUMLModelQuery getStereotype: aSource.
	targetStereotype := OntoUMLModelQuery getStereotype: aTarget.
	sourceAndAncestors := OntoUMLModelQuery getAncestorsFor: aSource.
	sourceAndAncestors add: aSource.
	targetAndAncestors := OntoUMLModelQuery getAncestorsFor: aTarget.
	targetAndAncestors add: aTarget.
	
	aSource = aTarget ifTrue: [ ^ true. ].
	(sourceAndAncestors includes: aTarget) ifTrue: [ ^ true. ].
	(targetAndAncestors includes: aSource) ifTrue: [ ^ true. ].
	((OntoUMLModelQuery is: sourceStereotype oclKindOf: 'Sortal') and: 
		(OntoUMLModelQuery is: targetStereotype oclKindOf: 'Sortal')) ifTrue:
			[ ^ self checkIdentityOverlapFor: aSource withAncestors: sourceAndAncestors and: aTarget withAncestors: targetAndAncestors. ].
	(({ OntoUMLRelator. OntoUMLMode. } includes: sourceStereotype class) and: 
		({ OntoUMLRelator. OntoUMLMode. } includes: targetStereotype)) ifTrue:
			[ ^ self checkOverlapFor: sourceAndAncestors and: targetAndAncestors. ].
	((OntoUMLModelQuery is: sourceStereotype oclKindOf: 'MixinClass') and: 
		(OntoUMLModelQuery is: targetStereotype oclKindOf: 'MixinClass')) ifTrue:
			[ ^ self checkBinOverForMixins: aSource and: aTarget from: aModel. ].
	^ false.
]

{ #category : 'verification' }
BinOverAntipatternVerification >> checkBinOverForMixins: aSource and: aTarget from: aModel [ 
	| sourceChildren targetChildren sourceAncestors targetAncestors |
	sourceChildren := (OntoUMLModelQuery getDescendantsFor: aSource from: aModel) 
		select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'Sortal' ].
	targetChildren := (OntoUMLModelQuery getDescendantsFor: aTarget from: aModel) 
		select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'Sortal' ].
	(sourceChildren anySatisfy: [ :source | targetChildren includes: source ]) ifTrue: [ ^ true. ].
	sourceAncestors := (OntoUMLModelQuery getAncestorsFor: aSource) select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'MixinClass' ].
	targetAncestors := (OntoUMLModelQuery getAncestorsFor: aSource) select: [ :entity | OntoUMLModelQuery isStereotypeOf: entity oclKindOf: 'MixinClass' ].
	^ sourceChildren isEmpty and: (targetChildren isEmpty and: (sourceAncestors anySatisfy: [ :source | targetAncestors includes: source ])).
]

{ #category : 'verification' }
BinOverAntipatternVerification >> checkIdentityOverlapFor: aSource withAncestors: aSourceAncestors and: aTarget withAncestors: aTargetAncestors [ 
	| sourceIdentityProviders targetIdentityProviders overlap sourcePath targetPath |
	sourceIdentityProviders := aSourceAncestors select: [ :entity |
		 self class identityProviders includes: (OntoUMLModelQuery getStereotypeClass: entity) ].
	targetIdentityProviders := aTargetAncestors select: [ :entity |
		 self class identityProviders includes: (OntoUMLModelQuery getStereotypeClass: entity) ].
	
	overlap := sourceIdentityProviders intersection: targetIdentityProviders.	
	(overlap size < 1) ifTrue: [ ^ false. ].
	^ overlap anySatisfy: [ :identityProvider | 
		sourcePath := self calculateIdentityPathFor: aSource withProvider: identityProvider.
		targetPath := self calculateIdentityPathFor: aTarget withProvider: identityProvider.
		self isDisjointMissingFor: sourcePath and: targetPath withIdentityProvider: identityProvider. ].
]

{ #category : 'verification' }
BinOverAntipatternVerification >> checkOverlapFor: aSourceSet and: aTargetSet [
	^ aSourceSet anySatisfy: [ :source | aTargetSet includes: source ].
]

{ #category : 'verification' }
BinOverAntipatternVerification >> getAncestorTreeFor: aSource withIdentityProvider: identityProvider [
	| pathDictionary queue openedSet closedSet entity |
	pathDictionary := Dictionary new.
	closedSet := Set new.
	openedSet := Set new.
	queue := WaitfreeQueue new.
	queue nextPut: aSource.
	openedSet add: aSource.
	[queue isEmpty] whileFalse: [
		entity := queue nextOrNil.
		closedSet add: queue.
		entity = identityProvider ifTrue: [ queue flush. ]
		ifFalse:[
		entity generalizations do: [ :generalization |
			((closedSet includes: generalization general)
				or: (openedSet includes: generalization general))
			 	ifFalse: [ openedSet add: generalization general.
					queue nextPut: generalization general. 
					pathDictionary add: (generalization general -> generalization) ]. ]. ]. ].
	^ pathDictionary.
]

{ #category : 'verification' }
BinOverAntipatternVerification >> getIdentityPathFor: aSource withProvider: aIdentityProvider from: aIdentityPathDictionary [
	| pathEntity pathGeneralization result |
	result := Dictionary new.
	pathEntity := aIdentityProvider.
	[pathEntity = aSource] whileFalse: 
		[ 	pathGeneralization := aIdentityPathDictionary at: pathEntity.
		 	result add: (pathEntity -> pathGeneralization).
			pathEntity := pathGeneralization specific. ].
	^ result.
]

{ #category : 'verification' }
BinOverAntipatternVerification >> isDisjointMissingFor: sourcePath and: targetPath withIdentityProvider: identityProvider [
	| sourceGeneralization targetGeneralization commonGeneralizationSets |
	sourceGeneralization := sourcePath at: identityProvider.
	targetGeneralization := targetPath at: identityProvider.
	[ sourceGeneralization = targetGeneralization ] whileTrue: [ 
		sourceGeneralization := sourcePath at: sourceGeneralization specific.
		targetGeneralization := targetPath at: targetGeneralization specific. ].
	commonGeneralizationSets := sourceGeneralization generalizationSets select: [ :genSet |
		 targetGeneralization generalizationSets includes: genSet ].
	commonGeneralizationSets isEmpty ifTrue: [ ^ true. ].
	"else"
	^ commonGeneralizationSets anySatisfy: [ :genSet | (genSet isDisjoint) not. ].
]

{ #category : 'verification' }
BinOverAntipatternVerification >> verifyObject: aVerifiedAssociation withModel: aVerifiedModel [
	| source target |
	source := OntoUMLModelQuery getSourceFrom: aVerifiedAssociation.
	target := OntoUMLModelQuery getTargetFrom: aVerifiedAssociation.
	(self checkBinOverFor: source and: target from: aVerifiedModel) ifTrue: [ ^ { VerificationMessageWarning createFor: aVerifiedAssociation 
		withVerification: self 
		withText: 'Both ends of the ' , 
			(OntoUMLModelQuery getAssociationName:  aVerifiedAssociation) ,
			 ' association can be represented by the same individual: ' , source name
		documentationReference: OntoUMLDotOrgReferences getDefinitionReferenceForBinOver. } ].
	^ {}.
]
