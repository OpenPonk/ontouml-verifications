"
I represent tests for OntoUMLStereotypeYaml.
"
Class {
	#name : #OntoUMLStereotypeYamlTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationFramework-Updating'
}

{ #category : #constants }
OntoUMLStereotypeYamlTest >> getTestedClass [
	^ OntoUMLStereotypeYaml.
]

{ #category : #constants }
OntoUMLStereotypeYamlTest >> getTestedClassInstance: aYaml [
	^ self getTestedClass createFromYaml: aYaml.
]

{ #category : #constants }
OntoUMLStereotypeYamlTest >> parseReferenceYaml: aReferenceYamlText [
	| yamlParser |
	yamlParser := PPYAMLGrammar new.
	^ yamlParser parse: aReferenceYamlText.
]

{ #category : #constants }
OntoUMLStereotypeYamlTest >> referenceYaml [
	^ self parseReferenceYaml: self referenceYamlText.
]

{ #category : #constants }
OntoUMLStereotypeYamlTest >> referenceYamlAlternative [
	^ self parseReferenceYaml: self referenceYamlAlternativeText.
]

{ #category : #constants }
OntoUMLStereotypeYamlTest >> referenceYamlAlternativeText [
	^ 'test:
	-alternative'.
]

{ #category : #constants }
OntoUMLStereotypeYamlTest >> referenceYamlText [
	^ 'test:
	-reference
	-text'.
]

{ #category : #tests }
OntoUMLStereotypeYamlTest >> testCreateFromYaml [
	| stereotypeYaml |
	stereotypeYaml := self getTestedClass createFromYaml: self referenceYaml.
	self assert: stereotypeYaml yaml equals: self referenceYaml.
]

{ #category : #tests }
OntoUMLStereotypeYamlTest >> testSourceEnd [
	| stereotypeYaml |
	stereotypeYaml := self getTestedClassInstance: self referenceYaml.
	self assert: stereotypeYaml yaml equals: self referenceYaml.	
	stereotypeYaml yaml: self referenceYamlAlternative.
	self assert: stereotypeYaml yaml equals: self referenceYamlAlternative.
]

{ #category : #tests }
OntoUMLStereotypeYamlTest >> testTmpCorrectStereotypeCase [
	self assert: (self getTestedClass tmpCorrectStereotypeCase: 'Subkind') equals: 'SubKind'.
	self assert: (self getTestedClass tmpCorrectStereotypeCase: 'subkiNd') equals: 'SubKind'.
	self assert: (self getTestedClass tmpCorrectStereotypeCase: 'sUbKind') equals: 'SubKind'.
	self assert: (self getTestedClass tmpCorrectStereotypeCase: 'kiNd') equals: 'kiNd'.
	self assert: (self getTestedClass tmpCorrectStereotypeCase: 'sUb') equals: 'sUb'.
]

{ #category : #tests }
OntoUMLStereotypeYamlTest >> testTmpCorrectStereotypeName [
	self assert: (self getTestedClass tmpCorrectStereotypeName: 'Formal') equals: 'DomainFormal'.
	self assert: (self getTestedClass tmpCorrectStereotypeName: 'FoRmal') equals: 'DomainFormal'.
	self assert: (self getTestedClass tmpCorrectStereotypeName: 'formal') equals: 'DomainFormal'.
	self assert: (self getTestedClass tmpCorrectStereotypeName: 'kiNd') equals: 'kiNd'.
	self assert: (self getTestedClass tmpCorrectStereotypeName: 'sUb') equals: 'sUb'.
]
