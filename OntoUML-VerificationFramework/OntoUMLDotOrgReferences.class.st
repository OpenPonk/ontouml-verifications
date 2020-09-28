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

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForDerivation [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/derivation/index.html' .
]

{ #category : #'constants - relationship' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForFormal [
	^ 'https://ontouml.readthedocs.io/en/latest/relationships/formal/index.html' .
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

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMixin [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/nonsortals/mixin/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForMode [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/aspects/mode/index.html' .
]

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForPhase [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/phase/index.html' .
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

{ #category : #'constants - class' }
OntoUMLDotOrgReferences class >> getDefinitionRefereceForRelator [
	^ 'https://ontouml.readthedocs.io/en/latest/classes/sortals/relator/index.html'
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
	aVerificationUpdater classDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - class'. ].
	aVerificationUpdater relationshipDocumentationReferences do: [ :reference | self updateMessage: (self getDefinitionReferenceForStereotypeCode:  reference ) withClassification: 'constants - relationship'. ].
]
