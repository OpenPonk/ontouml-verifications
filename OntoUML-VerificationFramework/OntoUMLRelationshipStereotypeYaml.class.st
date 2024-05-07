"
I represent single documentation for single relationship stereotype and provide access to its properties.
"
Class {
	#name : 'OntoUMLRelationshipStereotypeYaml',
	#superclass : 'OntoUMLStereotypeYaml',
	#category : 'OntoUML-VerificationFramework-Updating',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Updating'
}

{ #category : 'acccessing' }
OntoUMLRelationshipStereotypeYaml >> allowedSources [
	^ self sourceEnd at: 'allowed'.
]

{ #category : 'acccessing' }
OntoUMLRelationshipStereotypeYaml >> allowedTargets [
	^ self targetEnd at: 'allowed'.
]

{ #category : 'acccessing' }
OntoUMLRelationshipStereotypeYaml >> binaryProperties [
	^ self yaml at: 'binary_properties'.
]

{ #category : 'acccessing' }
OntoUMLRelationshipStereotypeYaml >> directed [
	^ self yaml at: 'directed'.
]

{ #category : 'acccessing' }
OntoUMLRelationshipStereotypeYaml >> name [
	^ self class tmpCorrectStereotypeName: (self yaml at: 'name') capitalized.
]

{ #category : 'acccessing' }
OntoUMLRelationshipStereotypeYaml >> sourceEnd [
	^ self yaml at: 'source_end'.
]

{ #category : 'acccessing' }
OntoUMLRelationshipStereotypeYaml >> targetEnd [
	^ self yaml at: 'target_end'.
]
