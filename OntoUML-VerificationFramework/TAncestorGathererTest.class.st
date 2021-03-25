Class {
	#name : #TAncestorGathererTest,
	#superclass : #TestCase,
	#traits : 'TAncestorGartherer',
	#classTraits : 'TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Traits'
}

{ #category : #'as yet unclassified' }
TAncestorGathererTest >> createClass: aName withStereotype: aStereotype [
	| result |
	result := OPUMLClass new.
	result applyStereotype: aStereotype new.
	result name: aName.
	^ result.
]

{ #category : #'as yet unclassified' }
TAncestorGathererTest >> createGeneralizationFor: aGeneral withSpecific: aSpecific [
	| generalization |
	generalization := OPUMLGeneralization new.
	generalization general: aGeneral;
	specific: aSpecific.
	^ generalization.
]

{ #category : #'as yet unclassified' }
TAncestorGathererTest >> getResultSet [
	^ { 'parent1'. 'parent2'. 'parent3'. 'parent4'.} asSet.
]

{ #category : #'as yet unclassified' }
TAncestorGathererTest >> getTestModel [
	| testedChild parent1 parent2 parent3 parent4 sibling outsideElement |
	testedChild := 	self createClass: 'testedChild' withStereotype: OntoUMLRole.
	parent1 := self createClass: 'parent1' withStereotype: OntoUMLRoleMixin.
	parent2 := self createClass: 'parent2' withStereotype: OntoUMLSubKind.
	parent3 := self createClass: 'parent3' withStereotype: OntoUMLSubKind.
	parent4 := self createClass: 'parent4' withStereotype: OntoUMLKind.
	sibling := 	self createClass: 'sibling' withStereotype: OntoUMLRole.
	outsideElement := self createClass: 'outsideElement' withStereotype: OntoUMLKind.
	
	^ { testedChild. parent1. parent2. parent3. parent4. sibling. outsideElement. 
		self createGeneralizationFor: parent1 withSpecific: testedChild.
		self createGeneralizationFor: parent2 withSpecific: testedChild.
		self createGeneralizationFor: parent3 withSpecific: parent2.
		self createGeneralizationFor: parent2 withSpecific: parent3.
		self createGeneralizationFor: parent4 withSpecific: parent2.
		self createGeneralizationFor: parent1 withSpecific: sibling.
		}.
]
