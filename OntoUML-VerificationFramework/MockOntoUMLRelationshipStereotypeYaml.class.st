"
I represent mock class used for for tests instead of OntoUMLRelationshipStereotypeYaml.
"
Class {
	#name : #MockOntoUMLRelationshipStereotypeYaml,
	#superclass : #OntoUMLRelationshipStereotypeYaml,
	#category : #'OntoUML-VerificationFramework-Updating'
}

{ #category : #acccessing }
MockOntoUMLRelationshipStereotypeYaml >> binaryProperties: aValue [
	yaml add: 'binary_properties' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLRelationshipStereotypeYaml >> directed: aValue [
	yaml add: 'directed' -> aValue.
]

{ #category : #initialization }
MockOntoUMLRelationshipStereotypeYaml >> initialize [
	self yaml: Dictionary new.
]

{ #category : #acccessing }
MockOntoUMLRelationshipStereotypeYaml >> name: aValue [
	yaml add: 'name' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLRelationshipStereotypeYaml >> sourceEnd: aValue [
	yaml add: 'source_end' -> aValue.
]

{ #category : #acccessing }
MockOntoUMLRelationshipStereotypeYaml >> targetEnd: aValue [
	yaml add: 'target_end' -> aValue.
]
