"
Tests ancestor collection algorithms provided by the TAncestorGatherer trait across ontological generalization hierarchies.
"
Class {
	#name : 'TAncestorGathererTest',
	#superclass : 'TestCase',
	#traits : 'TAncestorGartherer',
	#classTraits : 'TAncestorGartherer classTrait',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Traits',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Traits'
}

{ #category : 'tests - utility' }
TAncestorGathererTest >> createClass: aName withStereotype: aStereotype [
	| result |
	result := OPUMLClass new.
	result applyStereotype: aStereotype new.
	result name: aName.
	^ result.
]

{ #category : 'tests - utility' }
TAncestorGathererTest >> createGeneralizationFor: aGeneral withSpecific: aSpecific [
	| generalization |
	generalization := OPUMLGeneralization new.
	generalization general: aGeneral;
	specific: aSpecific.
	^ generalization.
]

{ #category : 'tests - constants' }
TAncestorGathererTest >> getResultSet [

	^ { 'parent1'. 'parent2'. 'parent3'. 'parent4' } asSet
]

{ #category : 'tests - constants' }
TAncestorGathererTest >> getTestModel [

	| testedChild parent1 parent2 parent3 parent4 sibling outsideElement |
	testedChild := self createClass: 'testedChild' withStereotype: OntoUMLRole.
	parent1 := self createClass: 'parent1' withStereotype: OntoUMLRoleMixin.
	parent2 := self createClass: 'parent2' withStereotype: OntoUMLSubKind.
	parent3 := self createClass: 'parent3' withStereotype: OntoUMLSubKind.
	parent4 := self createClass: 'parent4' withStereotype: OntoUMLKind.
	sibling := self createClass: 'sibling' withStereotype: OntoUMLRole.
	outsideElement := self createClass: 'outsideElement' withStereotype: OntoUMLKind.

	^ {
		  testedChild.
		  parent1.
		  parent2.
		  parent3.
		  parent4.
		  sibling.
		  outsideElement.
		  (self createGeneralizationFor: parent1 withSpecific: testedChild).
		  (self createGeneralizationFor: parent2 withSpecific: testedChild).
		  (self createGeneralizationFor: parent3 withSpecific: parent2).
		  (self createGeneralizationFor: parent2 withSpecific: parent3).
		  (self createGeneralizationFor: parent4 withSpecific: parent2).
		  (self createGeneralizationFor: parent1 withSpecific: sibling) }
]

{ #category : 'tests' }
TAncestorGathererTest >> testGetAncestorsFor [

	| model testedChild ancestors |
	model := self getTestModel.
	testedChild := model first.
	ancestors := self class getAncestorsFor: testedChild.
	self assert: ancestors class identicalTo: Set.
	self assertCollection: ancestors hasSameElements: (model copyFrom: 2 to: 5).
	self assertCollection: (ancestors collect: #name) hasSameElements: self getResultSet
]

{ #category : 'tests' }
TAncestorGathererTest >> testGetAncestorsForElementWithoutGeneralizations [

	| model outsideElement ancestors |
	model := self getTestModel.
	outsideElement := model at: 7.
	ancestors := self class getAncestorsFor: outsideElement.
	self assert: ancestors class identicalTo: Set.
	self assertEmpty: ancestors
]

{ #category : 'tests' }
TAncestorGathererTest >> testGetAncestorsForInto [

	| model testedChild existingElement ancestors |
	model := self getTestModel.
	testedChild := model first.
	existingElement := model at: 7.
	ancestors := Set with: existingElement.
	self class getAncestorsFor: testedChild into: ancestors.
	self assertCollection: ancestors hasSameElements: (model copyFrom: 2 to: 5) , { existingElement }
]

{ #category : 'tests' }
TAncestorGathererTest >> testGetAncestorsForSibling [

	| model sibling ancestors |
	model := self getTestModel.
	sibling := model at: 6.
	ancestors := self class getAncestorsFor: sibling.
	self assertCollection: ancestors hasSameElements: { model second }
]
