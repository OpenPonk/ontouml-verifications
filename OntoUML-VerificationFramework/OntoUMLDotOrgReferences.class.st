Class {
	#name : #OntoUMLDotOrgReferences,
	#superclass : #Object,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TProfileGatherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TProfileGatherer classTrait',
	#category : #'OntoUML-VerificationFramework-DocumentationReferences'
}

{ #category : #constants }
OntoUMLDotOrgReferences class >> getDefinitionRefereceFor: aOntoUMLObject [
	(self getStereotype:  aOntoUMLObject) ifNil: [ ^ '' ] 
	ifNotNil: [ ^ self perform: ('getDefinitionRefereceFor' ,  (self getStereotype:  aOntoUMLObject) umlClassName) asSymbol]
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForBinOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/BinOver/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForCategory [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/category/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForCharacterization [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/characterization/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForCollective [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/collective/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForComponentOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/componentOf/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForContainment [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/containment/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForDecInt [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/DecInt/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForDepPhase [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/DepPhase/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForDerivation [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/derivation/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForFormal [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/formal/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForFreeRole [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/FreeRole/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForGSRig [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/GSRig/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForHetColl [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/HetColl/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForHomoFunc [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/HomoFunc/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForImpAbs [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/ImpAbs/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForKind [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/kind/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMaterial [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/material/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMediation [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/mediation/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMemberOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/memberOf/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMixIden [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MixIden/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMixRig [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MixRig/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/mixin/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMode [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/aspects/mode/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMultDep [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/MultDep/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForPartOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/PartOver/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForPhase [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/phase/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForPhaseMixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/phasemixin/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForQuality [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/aspects/quality/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForQuantity [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/quantity/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRealtor [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/relator/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRelOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelOver/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRelRig [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelRig/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRelSpec [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RelSpec/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRelator [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/relator/index.html'
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRepRel [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/RepRel/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRole [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/role/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRoleMixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/rolemixin/index.html'
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRolemixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/rolemixin/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForStructuration [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/structuration/index.html'
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForSubCollectionOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/subCollectionOf/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForSubKind [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/subkind/index.html'
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForSubQuantityOf [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/aggregations/subQuantityOf/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForSubkind [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/subkind/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForUndefFormal [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefFormal/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForUndefPhase [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/UndefPhase/index.html' .
]

{ #category : #'constants - antipattern' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForWholeOver [
	^ 'https://ontouml.readthedocs.io/en/latest/anti-patterns/WholeOver/index.html' .
]

{ #category : #updating }
OntoUMLDotOrgReferences class >> getDefinitionReferenceForStereotypeCode: aReferenceAssociation [
	| methodCode |
 	self checkStringForCodeInjection: aReferenceAssociation key.
	methodCode := '"I return documentation reference for: ' , aReferenceAssociation key , '"
getDefinitionRefereceFor' , aReferenceAssociation key , '
	^ ''' , aReferenceAssociation value , ''' .'.
	^ methodCode.
]

{ #category : #updating }
OntoUMLDotOrgReferences class >> updateFrom: aVerificationUpdater [
	aVerificationUpdater classDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode: reference ) withClassification: 'constants - class'. ].
	aVerificationUpdater relationshipDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - relationship'. ].
	aVerificationUpdater antipatternDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - antipattern'. ].
]
