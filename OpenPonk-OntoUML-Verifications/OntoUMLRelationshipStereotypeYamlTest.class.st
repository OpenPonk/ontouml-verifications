"
I represent tests for OntoUMLRelationshipStereotypeYaml.
"
Class {
	#name : 'OntoUMLRelationshipStereotypeYamlTest',
	#superclass : 'OntoUMLStereotypeYamlTest',
	#category : 'OpenPonk-OntoUML-Verifications-Updating',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Updating'
}

{ #category : 'constants' }
OntoUMLRelationshipStereotypeYamlTest >> getTestedClass [
 ^ OntoUMLRelationshipStereotypeYaml.
]

{ #category : 'constants' }
OntoUMLRelationshipStereotypeYamlTest >> referenceYaml [
	^ super referenceYaml at: 'aggregation_stereotype'.
]

{ #category : 'constants' }
OntoUMLRelationshipStereotypeYamlTest >> referenceYamlAlternative [
	^ super referenceYamlAlternative at: 'relationship_stereotype'.
]

{ #category : 'constants' }
OntoUMLRelationshipStereotypeYamlTest >> referenceYamlAlternativeText [
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
    cyclicity: false
'.
]

{ #category : 'constants' }
OntoUMLRelationshipStereotypeYamlTest >> referenceYamlText [
	^ 'aggregation_stereotype:
  name: memberOf
  directed: true
  source_end:
    allowed:
    - Collective
    min: 1
    max: "*"
    readOnly: undefined
  target_end:
    allowed:
    - Collective
    - Functional complex
    min: 1
    max: "*"
    readOnly: undefined
  binary_properties:
    reflexivity: false
    transitivity: false
    symmetry: false
    cyclicity: false
'.
]

{ #category : 'tests' }
OntoUMLRelationshipStereotypeYamlTest >> testAllowedSources [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml allowedSources equals: ((self referenceYaml at: 'source_end') at: 'allowed').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml allowedSources equals: ((self referenceYamlAlternative at: 'source_end') at: 'allowed').
]

{ #category : 'tests' }
OntoUMLRelationshipStereotypeYamlTest >> testAllowedTargets [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml allowedTargets equals: ((self referenceYaml at: 'target_end') at: 'allowed').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml allowedTargets equals: ((self referenceYamlAlternative at: 'target_end') at: 'allowed').
]

{ #category : 'tests' }
OntoUMLRelationshipStereotypeYamlTest >> testBinaryProperties [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml binaryProperties equals: (self referenceYaml at: 'binary_properties').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml binaryProperties equals: (self referenceYamlAlternative at: 'binary_properties').
]

{ #category : 'tests' }
OntoUMLRelationshipStereotypeYamlTest >> testDirected [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml directed equals: (self referenceYaml at: 'directed').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml directed equals: (self referenceYamlAlternative at: 'directed').
]

{ #category : 'tests' }
OntoUMLRelationshipStereotypeYamlTest >> testName [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml name equals: (self referenceYaml at: 'name') capitalized.
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml name equals: (self referenceYamlAlternative at: 'name') capitalized.
]

{ #category : 'tests' }
OntoUMLRelationshipStereotypeYamlTest >> testSourceEnd [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml sourceEnd equals: (self referenceYaml at: 'source_end').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml sourceEnd equals: (self referenceYamlAlternative at: 'source_end').
]

{ #category : 'tests' }
OntoUMLRelationshipStereotypeYamlTest >> testTargetEnd [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml targetEnd equals: (self referenceYaml at: 'target_end').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml targetEnd equals: (self referenceYamlAlternative at: 'target_end').
]
