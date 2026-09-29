"
I represent mock class used for for tests instead of OntoUMLRelationshipStereotypeYaml.
"
Class {
	#name : 'MockOntoUMLRelationshipStereotypeYaml',
	#superclass : 'OntoUMLRelationshipStereotypeYaml',
	#category : 'OpenPonk-OntoUML-Verifications-Updating',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Updating'
}

{ #category : 'accessing' }
MockOntoUMLRelationshipStereotypeYaml >> binaryProperties: aValue [
	yaml add: 'binary_properties' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLRelationshipStereotypeYaml >> directed: aValue [
	yaml add: 'directed' -> aValue.
]

{ #category : 'initialization' }
MockOntoUMLRelationshipStereotypeYaml >> initialize [
	self yaml: Dictionary new.
]

{ #category : 'accessing' }
MockOntoUMLRelationshipStereotypeYaml >> name: aValue [
	yaml add: 'name' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLRelationshipStereotypeYaml >> sourceEnd: aValue [
	yaml add: 'source_end' -> aValue.
]

{ #category : 'accessing' }
MockOntoUMLRelationshipStereotypeYaml >> targetEnd: aValue [
	yaml add: 'target_end' -> aValue.
]
