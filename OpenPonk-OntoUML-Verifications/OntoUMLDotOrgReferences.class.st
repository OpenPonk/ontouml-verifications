Class {
	#name : 'OntoUMLDotOrgReferences',
	#superclass : 'Object',
	#traits : 'TCodeInjectionChecker + TClassUpdater + TProfileGatherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TProfileGatherer classTrait',
	#category : 'OpenPonk-OntoUML-Verifications-DocumentationReferences',
	#package : 'OpenPonk-OntoUML-Verifications',
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
	"I return documentation reference for: BinOver"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/BinOver/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForCategory [
	"I return documentation reference for: Category"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/category/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForCharacterization [
	"I return documentation reference for: Characterization"

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
	"I return documentation reference for: Collective"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/collective/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForComponentOf [
	"I return documentation reference for: ComponentOf"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/componentOf/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForContainment [
	"I return documentation reference for: Containment"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/containment/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForDecInt [
	"I return documentation reference for: DecInt"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/DecInt/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForDepPhase [
	"I return documentation reference for: DepPhase"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/DepPhase/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForDerivation [
	"I return documentation reference for: Derivation"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/derivation/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForFormal [
	"I return documentation reference for: Formal"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/formal/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForFreeRole [
	"I return documentation reference for: FreeRole"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/FreeRole/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForGSRig [
	"I return documentation reference for: GSRig"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/GSRig/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForHetColl [
	"I return documentation reference for: HetColl"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/HetColl/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForHomoFunc [
	"I return documentation reference for: HomoFunc"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/HomoFunc/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForIdentityRequired [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForImpAbs [
	"I return documentation reference for: ImpAbs"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/ImpAbs/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForKind [
	"I return documentation reference for: Kind"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/kind/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMaterial [
	"I return documentation reference for: Material"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/material/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMediation [
	"I return documentation reference for: Mediation"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/mediation/index.html' .
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMemberOf [
	"I return documentation reference for: MemberOf"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/memberOf/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMixIden [
	"I return documentation reference for: MixIden"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MixIden/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMixRig [
	"I return documentation reference for: MixRig"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MixRig/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMixin [
	"I return documentation reference for: Mixin"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/mixin/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMode [
	"I return documentation reference for: Mode"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/aspects/mode/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForMultDep [
	"I return documentation reference for: MultDep"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MultDep/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPartOfGenSet [
	^ '' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPartOver [
	"I return documentation reference for: PartOver"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/PartOver/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPhase [
	"I return documentation reference for: Phase"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/phase/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForPhaseMixin [
	"I return documentation reference for: PhaseMixin"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/phasemixin/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForQuality [
	"I return documentation reference for: Quality"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/aspects/quality/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForQuantity [
	"I return documentation reference for: Quantity"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/quantity/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRealtor [
	"I return documentation reference for: Realtor"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/relator/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelComp [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelComp/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelOver [
	"I return documentation reference for: RelOver"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelOver/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelRig [
	"I return documentation reference for: RelRig"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelRig/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRelSpec [
	"I return documentation reference for: RelSpec"

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
	"I return documentation reference for: RepRel"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RepRel/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForRole [
	"I return documentation reference for: Role"

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
	"I return documentation reference for: Rolemixin"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/rolemixin/index.html' .
]

{ #category : 'updating' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForStereotypeCode: aReferenceAssociation [

	| methodCode |
	self checkStringForCodeInjection: aReferenceAssociation key.
	methodCode := 'getDefinitionReferenceFor' , aReferenceAssociation key
	              , '
	"I return documentation reference for: ' , aReferenceAssociation key
	              , '"

	^ ''' , aReferenceAssociation value , ''' .'.
	^ methodCode
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForStructuration [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/structuration/index.html'
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubCollectionOf [
	"I return documentation reference for: SubCollectionOf"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/subCollectionOf/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubKind [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/subkind/index.html'
]

{ #category : 'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubQuantityOf [
	"I return documentation reference for: SubQuantityOf"

	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/subQuantityOf/index.html' .
]

{ #category : 'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForSubkind [
	"I return documentation reference for: Subkind"

	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/subkind/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForUndefFormal [
	"I return documentation reference for: UndefFormal"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefFormal/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForUndefPhase [
	"I return documentation reference for: UndefPhase"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefPhase/index.html' .
]

{ #category : 'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForWholeOver [
	"I return documentation reference for: WholeOver"

	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/WholeOver/index.html' .
]

{ #category : 'updating' }
OntoUMLDotOrgReferences class >> updateFrom: aVerificationUpdater [
	aVerificationUpdater classDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode: reference ) withClassification: 'constants - class'. ].
	aVerificationUpdater relationshipDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - relationship'. ].
	aVerificationUpdater antipatternDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - antipattern'. ].
]
