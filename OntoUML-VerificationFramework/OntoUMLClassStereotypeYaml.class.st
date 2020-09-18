Class {
	#name : #OntoUMLClassStereotypeYaml,
	#superclass : #OntoUMLStereotypeYaml,
	#category : #'OntoUML-VerificationFramework-Updating'
}

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> abstract [
	^ self yaml at: 'abstract'
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> dependency [
	^ self yaml at: 'dependency'
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> forbiddenAssociations [
	^ self yaml at: 'forbidden_associations'
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> identityPriciple [
	^ self yaml at: 'identity_principle'
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> name [
	^ self class tmpCorrectStereotypeCase: (self yaml at: 'name')
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> parent [
	^ self class tmpCorrectStereotypeCase: (self yaml at: 'parent')
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> providesIdentity [
	^ (self yaml at: 'provides_identity') = 'true'
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> rigidity [
	^ self yaml at: 'rigidity'
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> subtypes [
	^ (self yaml at: 'subtypes')
		collect: [ :arg1 | self class tmpCorrectStereotypeCase: arg1 ]
]

{ #category : #'as yet unclassified' }
OntoUMLClassStereotypeYaml >> supertypes [
	^ (self yaml at: 'supertypes')
		collect: [ :arg1 | self class tmpCorrectStereotypeCase: arg1 ]
]
