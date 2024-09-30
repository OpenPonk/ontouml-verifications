Class {
	#name : 'OntoUMLVerificationUpdaterTest',
	#superclass : 'TestCase',
	#category : 'OntoUML-VerificationFramework-Updating',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Updating'
}

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> parseReferenceYaml: aReferenceYamlText [
	| yamlParser |
	yamlParser := PPYAMLGrammar new.
	^ yamlParser parse: aReferenceYamlText.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceAggregationYaml [
	^ self parseReferenceYaml: self referenceAggregationYamlText.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceAggregationYamlText [
	^ 'aggregation_stereotype:
  name: subQuantityOf
  directed: true
  source_end:
    allowed:
    - Quantity
    min: 1
    max: 1
    readOnly: undefined
  target_end:
    allowed:
    - Quantity
    min: 1
    max: 1
    readOnly: undefined
  binary_properties:
    reflexivity: false
    transitivity: true
    symmetry: false
    cyclicity: false'.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceClassYaml [
	^ self parseReferenceYaml: self referenceClassYamlText.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceClassYamlText [
	^ 'class_stereotype:
  name: Mode
  parent: Aspect
  provides_identity: true
  identity_principle: single
  rigidity: rigid
  dependency: mandatory
  supertypes:
  - Category
  - Mixin
  subtypes:
  - Subkind
  - Role
  - Phase
  - Mode
  forbidden_associations:
  - Structuration
  - ComponentOf
  - SubCollectionOf
  - MemberOf
  - SubQuantityOf
  - Derivation
  abstract: true'.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceIndexYaml [
	^ self parseReferenceYaml: self referenceIndexYamlText.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceIndexYamlText [
	^ 'verifications:
    relationship_specification_paths:
        - relationships/aggregations/componentOf/
        - relationships/aggregations/containment/
        - relationships/aggregations/memberOf/
        - relationships/aggregations/subCollectionOf/
        - relationships/aggregations/subQuantityOf/
        - relationships/characterization/
        - relationships/derivation/
        - relationships/formal/
        - relationships/material/
        - relationships/mediation/
    class_specification_paths:
        - classes/sortals/kind/
        - classes/sortals/subkind/
        - classes/sortals/collective/
        - classes/sortals/phase/
        - classes/sortals/quantity/
        - classes/sortals/relator/
        - classes/sortals/role/
        - classes/aspects/mode/
        - classes/aspects/quality/
        - classes/nonsortals/category/
        - classes/nonsortals/mixin/
        - classes/nonsortals/rolemixin/'.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceRelationshipYaml [
	^ self parseReferenceYaml: self referenceRelationshipYamlText.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceRelationshipYamlText [
	^ 'relationship_stereotype:
  name: characterization
  directed: true
  source_end:
    allowed: "*"
    min: 1
    max: 1
    readOnly: undefined
  target_end:
    allowed:
    - Quality
    - Mode
    min: 1
    max: "*"
    readOnly: undefined
  binary_properties:
    reflexivity: false
    transitivity: false
    symmetry: false
    cyclicity: false'.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceYaml [
	^ self parseReferenceYaml: self referenceYamlText.
]

{ #category : 'constants' }
OntoUMLVerificationUpdaterTest >> referenceYamlText [
	^ 'test:
	-reference
	-text'.
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testClassSpecifications [
	| updater | 
	updater := OntoUMLVerificationUpdater new.
	updater classSpecifications: 'test'.
	self assert: updater classSpecifications equals: 'test'.
	updater classSpecifications: 'second test'.
	self assert: updater classSpecifications equals: 'second test'.
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testGetClassSpecificationPaths [
	| updater result | 
	updater := OntoUMLVerificationUpdater new.
	updater updatingIndex: self referenceIndexYaml.
	result := updater getClassSpecificationPaths.
	self assert: result equals: ((updater updatingIndex at: 'verifications') at: 'class_specification_paths').
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testGetRelationshipSpecificationPaths [
	| updater result | 
	updater := OntoUMLVerificationUpdater new.
	updater updatingIndex: self referenceIndexYaml.
	result := updater getRelationshipSpecificationPaths.
	self assert: result equals: ((updater updatingIndex at: 'verifications') at: 'relationship_specification_paths').
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testGetVerifications [
	| controller verifications |
	controller := VerificationController new.
	verifications := controller getVerifications.
	self assert: (verifications isKindOf: Collection).
	self assert: (verifications isEmpty) equals: false.
	self assert: (verifications anySatisfy: [ :verificationClass | verificationClass = Verification ]) equals: true. 
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testIndexUrl [
	| updater | 
	updater := OntoUMLVerificationUpdater new.
	self assert: updater indexUrl equals: 'https://raw.githubusercontent.com/OntoUML/OntoUML/master/updatingIndex.yaml'.
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testParseClassYaml [
	| updater result | 
	updater := OntoUMLVerificationUpdater new.
	result := updater parseClassYaml: self referenceClassYamlText.
	self assert: result class equals: OntoUMLClassStereotypeYaml.
	self assert: result yaml equals: (self referenceClassYaml at: 'class_stereotype').
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testParseRelationshipYaml [
	| updater result | 
	updater := OntoUMLVerificationUpdater new.
	result := updater parseRelationshipYaml: self referenceRelationshipYamlText.
	self assert: result class equals: OntoUMLRelationshipStereotypeYaml.
	self assert: result yaml equals: (self referenceRelationshipYaml at: 'relationship_stereotype').
	result := updater parseRelationshipYaml: self referenceAggregationYamlText.
	self assert: result class equals: OntoUMLRelationshipStereotypeYaml.
	self assert: result yaml equals: (self referenceAggregationYaml at: 'aggregation_stereotype').
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testParseYaml [
	| updater | 
	updater := OntoUMLVerificationUpdater new.
	self assert: (updater parseYaml: self referenceClassYamlText) equals: self referenceClassYaml.
	self assert: (updater parseYaml: self referenceAggregationYamlText) equals: self referenceAggregationYaml.
	self assert: (updater parseYaml: self referenceRelationshipYamlText) equals: self referenceRelationshipYaml.
	self assert: (updater parseYaml: self referenceYamlText) equals: self referenceYaml.
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testRelationshipSpecifications [
	| updater | 
	updater := OntoUMLVerificationUpdater new.
	updater relationshipSpecifications: 'test'.
	self assert: updater relationshipSpecifications equals: 'test'.
	updater relationshipSpecifications: 'second test'.
	self assert: updater relationshipSpecifications equals: 'second test'.
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testSourceAddress [
	| updater | 
	updater := OntoUMLVerificationUpdater new.
	self assert: updater sourceAddress equals: 'https://raw.githubusercontent.com/OntoUML/OntoUML/master/'.
]

{ #category : 'tests' }
OntoUMLVerificationUpdaterTest >> testSpecificationFileName [
	| updater | 
	updater := OntoUMLVerificationUpdater new.
	self assert: updater specificationFileName equals: 'meta.yml'.
]
