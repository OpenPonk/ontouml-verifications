"
I represent tests for OntoUMLClassStereotypeYaml.
"
Class {
	#name : #OntoUMLClassStereotypeYamlTest,
	#superclass : #OntoUMLStereotypeYamlTest,
	#category : #'OntoUML-VerificationFramework-Updating'
}

{ #category : #constants }
OntoUMLClassStereotypeYamlTest >> getTestedClass [
 ^ OntoUMLClassStereotypeYaml.
]

{ #category : #constants }
OntoUMLClassStereotypeYamlTest >> referenceYaml [
	^ super referenceYaml at: 'class_stereotype'.
]

{ #category : #constants }
OntoUMLClassStereotypeYamlTest >> referenceYamlAlternative [
	^ super referenceYamlAlternative at: 'class_stereotype'.
]

{ #category : #constants }
OntoUMLClassStereotypeYamlTest >> referenceYamlAlternativeText [
	^ 'class_stereotype:
  name: Mixin
  parent: SemiRigidNonSortal
  provides_identity: false
  identity_principle: multiple
  rigidity: semirigid
  dependency: optional
  supertypes:
  - Mixin
  subtypes:
  - Subkind
  - Kind
  - Collective
  - Quantity
  - Category
  - Mixin
  - Role
  - Phase
  - RoleMixin
  - Relator
  forbidden_associations:
  - Structuration
  abstract: true
'.
]

{ #category : #constants }
OntoUMLClassStereotypeYamlTest >> referenceYamlText [
	^ 'class_stereotype:
  name: Role
  parent: AntiRigidSortal
  provides_identity: false
  identity_principle: simple
  rigidity: antirigid
  dependency: mandatory
  supertypes:
  - Kind
  - Subkind
  - Collective
  - Phase
  - Quantity
  - Relator
  - Role
  - RoleMixin
  - Mixin
  subtypes:
  - Role
  forbidden_associations:
  - Structuration
  abstract: undefined
'.
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testAbstract [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml abstract equals: (self referenceYaml at: 'abstract').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml abstract equals: (self referenceYamlAlternative at: 'abstract').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testDependency [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml forbiddenAssociations equals: (self referenceYaml at: 'forbidden_associations').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml forbiddenAssociations equals: (self referenceYamlAlternative at: 'forbidden_associations').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testForbiddenAssociations [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml forbiddenAssociations equals: (self referenceYaml at: 'forbidden_associations').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml forbiddenAssociations equals: (self referenceYamlAlternative at: 'forbidden_associations').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testIdentityPriciple [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml identityPriciple equals: (self referenceYaml at: 'identity_principle').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml identityPriciple equals: (self referenceYamlAlternative at: 'identity_principle').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testName [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml name equals: (self referenceYaml at: 'name').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml name equals: (self referenceYamlAlternative at: 'name').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testParent [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml parent equals: (self referenceYaml at: 'parent').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml parent equals: (self referenceYamlAlternative at: 'parent').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testProvidesIdentity [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml providesIdentity equals: ((self referenceYaml at: 'provides_identity') = 'true').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml providesIdentity equals: ((self referenceYamlAlternative at: 'provides_identity') = 'true').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testRigidity [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml rigidity equals: (self referenceYaml at: 'rigidity').
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml rigidity equals: (self referenceYamlAlternative at: 'rigidity').
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testSubtypes [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml subtypes equals: ((self referenceYaml at: 'subtypes') collect: [ :stereotype | self getTestedClass tmpCorrectStereotypeCase: stereotype ]).
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml subtypes equals: ((self referenceYamlAlternative at: 'subtypes') collect: [ :stereotype | self getTestedClass tmpCorrectStereotypeCase: stereotype ]).
]

{ #category : #tests }
OntoUMLClassStereotypeYamlTest >> testSupertypes [
	| classYaml |
	classYaml := self getTestedClassInstance: self referenceYaml.	
	self assert: classYaml supertypes equals: ((self referenceYaml at: 'supertypes') collect: [ :stereotype | self getTestedClass tmpCorrectStereotypeCase: stereotype ]).
	classYaml := self getTestedClassInstance: self referenceYamlAlternative.	
	self assert: classYaml supertypes equals: ((self referenceYamlAlternative at: 'supertypes') collect: [ :stereotype | self getTestedClass tmpCorrectStereotypeCase: stereotype ]).
]
