Class {
	#name : #VerificationResultsUI,
	#superclass : #Object,
	#instVars : [
		'verificationResults',
		'controller',
		'highlighted'
	],
	#category : #'OntoUML-VerificationFramework-UI'
}

{ #category : #'instance creation' }
VerificationResultsUI class >> createUIFor: aVerificationResults withControllers: aControllers [
	| verUI |
	verUI := self new.
	verUI verificationResults: aVerificationResults;
	controller: aControllers.
	^ verUI.
]

{ #category : #accessing }
VerificationResultsUI >> changeElementColor: aElement toColor: aColor [
	| diagramElementArray |
	diagramElementArray := (self controller controllers select: [ :aController | aController model = aElement ]) asArray.
	diagramElementArray ifNotEmpty: [ diagramElementArray first diagramElement style strokeColor: aColor.
		diagramElementArray first diagramElement update. ] .
]

{ #category : #accessing }
VerificationResultsUI >> controller [
	^ controller .
]

{ #category : #accessing }
VerificationResultsUI >> controller: aController [
	controller := aController.
]

{ #category : #accessing }
VerificationResultsUI >> getElementColor: aElement [
	(self controller controllers select: [ :aController | aController model = aElement ])
		do: [ :aController | ^ aController diagramElement style strokeColor. ].
]

{ #category : #'gt-inspector-extension' }
VerificationResultsUI >> gtInspectorTableIn: composite [ 
	<gtInspectorPresentationOrder: -15>
	(composite custom: GLMTableSelectablePresentation new)
		addOnSelectChangedHandler: self;
		title: 'Results';
		display: [ self verificationResults results ];
		column: 'Severity' evaluated: #severity;
		column: 'Object' evaluated: #objectReference;
		column: 'Reason' evaluated: #messageText;
		column: 'Documentation' evaluated: #documentationReference.
		"when: [ :table | table selection anySatisfy: [ :selected | (self highlighted includes: selected) not ] ]"
		"selectionAct: [ :table | 
			self highlightElement: table selection objectReference.
			]
			entitled: 'Highligh element'."
]

{ #category : #accessing }
VerificationResultsUI >> highlightElement: aElement [
	(highlighted includes: aElement) ifTrue: [ ^ self ].
	highlighted associations do: [ :highEl | self changeElementColor: highEl key toColor: highEl value. ].
	highlighted := Dictionary new.
	highlighted add: ( aElement -> (self getElementColor: aElement)).
	highlighted keys do: [ :highEl | self changeElementColor: highEl toColor: Color green. ].
]

{ #category : #accessing }
VerificationResultsUI >> highlighted [
	^ highlighted ifNil: [ highlighted := Dictionary new. ]
]

{ #category : #initialization }
VerificationResultsUI >> initialize [
	highlighted := Dictionary new.
]

{ #category : #accessing }
VerificationResultsUI >> notifySelectChanged: aSelection [
	self highlightElement: aSelection objectReference.
]

{ #category : #accessing }
VerificationResultsUI >> verificationResults [
	^ verificationResults.
]

{ #category : #accessing }
VerificationResultsUI >> verificationResults: aVerificationResults [ 
	verificationResults := aVerificationResults.
]
