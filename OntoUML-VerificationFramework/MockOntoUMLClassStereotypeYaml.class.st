"
I represent mock class used for for tests instead of OntoUMLClassStereotypeYaml.
"
Class {
	#name : #MockOntoUMLClassStereotypeYaml,
	#superclass : #OntoUMLClassStereotypeYaml,
	#category : #'OntoUML-VerificationFramework-Updating'
}

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> abstract: aValue [
	yaml add: 'abstract' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> dependency: aValue [
	yaml add: 'dependency' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> forbiddenAssociations: aValue [
	yaml add: 'forbidden_associations' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> identityPrinciple: aValue [
	yaml add: 'identity_principle' -> aValue.
]

{ #category : #initialization }
MockOntoUMLClassStereotypeYaml >> initialize [
	self yaml: Dictionary new.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> name: aValue [
	yaml add: 'name' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> parent: aValue [
	yaml add: 'parent' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> providesIdentity: aValue [
	yaml add: 'provides_identity' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> rigidity: aValue [
	yaml add: 'rigidity' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> subtypes: aValue [
	yaml add: 'subtypes' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLClassStereotypeYaml >> supertypes: aValue [
	yaml add: 'supertypes' -> aValue.
]
