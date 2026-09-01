"
I represent mock class used for for tests instead of OntoUMLClassStereotypeYaml.
"
Class {
	#name : 'MockOntoUMLClassStereotypeYaml',
	#superclass : 'OntoUMLClassStereotypeYaml',
	#category : 'OpenPonk-OntoUML-Verifications-Updating',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Updating'
}

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> abstract: aValue [
	yaml add: 'abstract' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> dependency: aValue [
	yaml add: 'dependency' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> forbiddenAssociations: aValue [
	yaml add: 'forbidden_associations' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> identityPrinciple: aValue [
	yaml add: 'identity_principle' -> aValue.
]

{ #category : 'initialization' }
MockOntoUMLClassStereotypeYaml >> initialize [
	self yaml: Dictionary new.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> name: aValue [
	yaml add: 'name' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> parent: aValue [
	yaml add: 'parent' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> providesIdentity: aValue [
	yaml add: 'provides_identity' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> rigidity: aValue [
	yaml add: 'rigidity' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> subtypes: aValue [
	yaml add: 'subtypes' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLClassStereotypeYaml >> supertypes: aValue [
	yaml add: 'supertypes' -> aValue.
]
