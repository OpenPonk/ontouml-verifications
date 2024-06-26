"
I am class responsible for creating UI for VerificationRestults.
"
Class {
	#name : 'VerificationResultsUI',
	#superclass : 'Object',
	#instVars : [
		'verificationResults',
		'controller',
		'highlighted'
	],
	#category : 'OntoUML-VerificationFramework-UI',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'UI'
}

{ #category : 'instance creation' }
VerificationResultsUI class >> createUIFor: aVerificationResults withControllers: aControllers [
	| verUI |
	verUI := self new.
	verUI verificationResults: aVerificationResults;
	controller: aControllers.
	^ verUI.
]

{ #category : 'accessing' }
VerificationResultsUI >> changeElementColor: aElement toColor: aColor [

	| diagramElementArray |
	diagramElementArray := (self controller controllers select: [
		                        :aController | aController model = aElement ])
		                       asArray.
	diagramElementArray ifNotEmpty: [
		| diagramElement |
		diagramElement := diagramElementArray first diagramElement.
		(diagramElement respondsTo: #strokeColor:) ifTrue: [
			diagramElement strokeColor: aColor ] ]
]

{ #category : 'accessing' }
VerificationResultsUI >> controller [
	^ controller .
]

{ #category : 'accessing' }
VerificationResultsUI >> controller: aController [
	controller := aController.
]

{ #category : 'accessing' }
VerificationResultsUI >> getElementColor: aElement [

	self controller controllers
		select: [ :aController | aController model = aElement ]
		thenDo: [ :aController | ^ aController diagramElement strokeColor ]
]

{ #category : 'accessing' }
VerificationResultsUI >> highlightElement: aElement [
	(highlighted includes: aElement) ifTrue: [ ^ self ].
	highlighted associations do: [ :highEl | self changeElementColor: highEl key toColor: highEl value. ].
	highlighted := Dictionary new.
	highlighted add: ( aElement -> (self getElementColor: aElement)).
	highlighted keys do: [ :highEl | self changeElementColor: highEl toColor: Color green. ].
]

{ #category : 'accessing' }
VerificationResultsUI >> highlighted [
	^ highlighted ifNil: [ highlighted := Dictionary new. ]
]

{ #category : 'initialization' }
VerificationResultsUI >> initialize [
	highlighted := Dictionary new.
]

{ #category : 'gt-inspector-extension' }
VerificationResultsUI >> inspectorTableIn: composite [

	<inspectorPresentationOrder: -15 title: 'Results'>
	^ SpTablePresenter new
		  beResizable;
		  items: self verificationResults results asArray;
		  whenSelectedDo: [ :item | self notifySelectChanged: item ];
		  addColumn: (SpStringTableColumn new
				   title: 'Severity';
				   evaluated: #severity;
				   width: 55);
		  addColumn:
		  (SpStringTableColumn title: 'Object' evaluated: #objectReference);
		  addColumn:
		  (SpStringTableColumn title: 'Reason' evaluated: #messageText);
		  addColumn: (SpLinkTableColumn
				   title: 'Documentation'
				   evaluated: #documentationReference
				   url: #documentationReference)
]

{ #category : 'accessing' }
VerificationResultsUI >> notifySelectChanged: aSelection [
	aSelection ifNotNil: [ self highlightElement: aSelection objectReference. ].
]

{ #category : 'accessing' }
VerificationResultsUI >> verificationResults [
	^ verificationResults.
]

{ #category : 'accessing' }
VerificationResultsUI >> verificationResults: aVerificationResults [ 
	verificationResults := aVerificationResults.
]
