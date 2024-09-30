"
I represent single documentation for single stereotype.
"
Class {
	#name : 'OntoUMLStereotypeYaml',
	#superclass : 'Object',
	#instVars : [
		'yaml'
	],
	#category : 'OntoUML-VerificationFramework-Updating',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Updating'
}

{ #category : 'instance creation' }
OntoUMLStereotypeYaml class >> createFromYaml: arg1 [
	| tmp1 |
	tmp1 := self basicNew.
	tmp1 yaml: arg1.
	^ tmp1
]

{ #category : 'correcting' }
OntoUMLStereotypeYaml class >> tmpCorrectStereotypeCase: arg1 [
	arg1 asLowercase = 'subkind'
		ifTrue: [ ^ 'SubKind' ].
	^ arg1
]

{ #category : 'correcting' }
OntoUMLStereotypeYaml class >> tmpCorrectStereotypeName: aName [
	aName asLowercase = 'formal'
		ifTrue: [ ^ 'DomainFormal' ].
	^ aName.
]

{ #category : 'accessing' }
OntoUMLStereotypeYaml >> yaml [
	^ yaml
]

{ #category : 'accessing' }
OntoUMLStereotypeYaml >> yaml: aYaml [
	yaml := aYaml
]
