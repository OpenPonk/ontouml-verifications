Class {
	#name : #OntoUMLClassStereotypeYaml,
	#superclass : #OntoUMLStereotypeYaml,
	#category : #'OntoUML-VerificationFramework-Updating'
}

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> abstract [
	^ self yaml at: 'abstract'
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> dependency [
	^ self yaml at: 'dependency'
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> forbiddenAssociations [
	^ self yaml at: 'forbidden_associations'
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> identityPriciple [
	^ self yaml at: 'identity_principle'
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> name [
	^ self class tmpCorrectStereotypeCase: (self yaml at: 'name')
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> parent [
	^ self class tmpCorrectStereotypeCase: (self yaml at: 'parent')
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> providesIdentity [
	^ (self yaml at: 'provides_identity') = 'true'
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> rigidity [
	^ self yaml at: 'rigidity'
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> subtypes [
	^ (self yaml at: 'subtypes')
		collect: [ :arg1 | self class tmpCorrectStereotypeCase: arg1 ]
]

{ #category : #accessing }
OntoUMLClassStereotypeYaml >> supertypes [
	^ (self yaml at: 'supertypes')
		collect: [ :arg1 | self class tmpCorrectStereotypeCase: arg1 ]
]
