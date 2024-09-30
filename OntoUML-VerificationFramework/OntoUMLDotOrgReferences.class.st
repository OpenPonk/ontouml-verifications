Class {
	#name : 'OntoUMLDotOrgReferences',
	#superclass : 'Object',
	#traits : 'TCodeInjectionChecker + TClassUpdater + TProfileGatherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TProfileGatherer classTrait',
	#category : 'OntoUML-VerificationFramework-DocumentationReferences',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'DocumentationReferences'
}

{ #category : 'constants' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceFor: aOntoUMLObject [
	(self getStereotype:  aOntoUMLObject) ifNil: [ ^ '' ] 
	ifNotNil: [ ^ self perform: ('getDefinitionReferenceFor' ,  (self getStereotype:  aOntoUMLObject) umlClassName) asSymbol]
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForAllowedSubtypes [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForAllowedSupertypes [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForBinOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/BinOver/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForCategory [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/category/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForCharacterization [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/characterization/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForCharacterized [
	^ '' .
]

{ #category : 'constants' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForClass: aVerificationClass [
	^ self perform: ('getDefinitionReferenceFor' ,  aVerificationClass abbreviation) asSymbol.
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForCollective [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/collective/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForComponentOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/componentOf/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForContainment [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/containment/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForDecInt [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/DecInt/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForDepPhase [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/DepPhase/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForDerivation [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/derivation/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForFormal [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/formal/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForFreeRole [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/FreeRole/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForGSRig [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/GSRig/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForHetColl [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/HetColl/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForHomoFunc [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/HomoFunc/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForIdentityRequired [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForImpAbs [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/ImpAbs/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForKind [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/kind/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMaterial [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/material/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMediation [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/mediation/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMemberOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/memberOf/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMixIden [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MixIden/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMixRig [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MixRig/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/mixin/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMode [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/aspects/mode/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMultDep [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MultDep/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPartOfGenSet [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPartOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/PartOver/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPhase [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/phase/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPhaseMixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/phasemixin/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForQuality [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/aspects/quality/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForQuantity [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/quantity/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRealtor [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/relator/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelComp [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelComp/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelOver/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelRig [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelRig/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelSpec [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelSpec/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelationSource [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelationTarget [
	^ '' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelator [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/relator/index.html'
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelatorMediationDependency [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRepRel [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RepRel/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRole [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/role/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRoleMediationDependency [
	^ '' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRoleMixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/rolemixin/index.html'
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRolemixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/rolemixin/index.html' .
]

{ #category : 'updating' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForStereotypeCode: aReferenceAssociation [
	| methodCode |
 	self checkStringForCodeInjection: aReferenceAssociation key.
	methodCode := '"I return documentation reference for: ' , aReferenceAssociation key , '"
getDefinitionReferenceFor' , aReferenceAssociation key , '
	^ ''' , aReferenceAssociation value , ''' .'.
	^ methodCode.
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForStructuration [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/structuration/index.html'
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubCollectionOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/subCollectionOf/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubKind [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/subkind/index.html'
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubQuantityOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/subQuantityOf/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubkind [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/subkind/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForUndefFormal [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefFormal/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForUndefPhase [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefPhase/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForWholeOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/WholeOver/index.html' .
]

{ #category : 'updating' }
OntoUMLDotOrgReferences class >> updateFrom: aVerificationUpdater [
	aVerificationUpdater classDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode: reference ) withClassification: 'constants - class'. ].
	aVerificationUpdater relationshipDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - relationship'. ].
	aVerificationUpdater antipatternDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - antipattern'. ].
]
