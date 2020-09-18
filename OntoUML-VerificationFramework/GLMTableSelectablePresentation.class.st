Class {
	#name : #GLMTableSelectablePresentation,
	#superclass : #GLMTablePresentation,
	#instVars : [
		'onSelectHandlers'
	],
	#category : #'OntoUML-VerificationFramework-UI'
}

{ #category : #'accessing ports' }
GLMTableSelectablePresentation >> addOnSelectChangedHandler: aHandlerClass [
	onSelectHandlers add: aHandlerClass .
]

{ #category : #initialization }
GLMTableSelectablePresentation >> initialize [
	super initialize.
	onSelectHandlers := OrderedCollection new.
]

{ #category : #'accessing ports' }
GLMTableSelectablePresentation >> onSelectChangedHandlers [
	^ onSelectHandlers.
]

{ #category : #'accessing ports' }
GLMTableSelectablePresentation >> selection: anObject [
  super selection: anObject.
  onSelectHandlers do: [ :handler | handler notifySelectChanged: self selection ].
]
