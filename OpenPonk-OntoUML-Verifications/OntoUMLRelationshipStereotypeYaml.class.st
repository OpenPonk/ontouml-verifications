"
I represent single documentation for single relationship stereotype and provide access to its properties.
"
Class {
	#name : 'OntoUMLRelationshipStereotypeYaml',
	#superclass : 'OntoUMLStereotypeYaml',
	#category : 'OpenPonk-OntoUML-Verifications-Updating',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Updating'
}

{ #category : 'accessing' }
OntoUMLRelationshipStereotypeYaml >> allowedSources [
	^ self sourceEnd at: 'allowed'.
]

{ #category : 'accessing' }
OntoUMLRelationshipStereotypeYaml >> allowedTargets [
	^ self targetEnd at: 'allowed'.
]

{ #category : 'accessing' }
OntoUMLRelationshipStereotypeYaml >> binaryProperties [
	^ self yaml at: 'binary_properties'.
]

{ #category : 'accessing' }
OntoUMLRelationshipStereotypeYaml >> directed [
	^ self yaml at: 'directed'.
]

{ #category : 'accessing' }
OntoUMLRelationshipStereotypeYaml >> name [
	^ self class tmpCorrectStereotypeName: (self yaml at: 'name') capitalized.
]

{ #category : 'accessing' }
OntoUMLRelationshipStereotypeYaml >> sourceEnd [
	^ self yaml at: 'source_end'.
]

{ #category : 'accessing' }
OntoUMLRelationshipStereotypeYaml >> targetEnd [
	^ self yaml at: 'target_end'.
]
