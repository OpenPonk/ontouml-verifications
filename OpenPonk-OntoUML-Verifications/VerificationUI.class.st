"
I represent UI for verification framework. 
I define items in menu that are responsible for starting anti-pattern detection, applying verification and removing higlights.
I am also responsible for displaying results and highliting elements in the model.
"
Class {
	#name : 'VerificationUI',
	#superclass : 'Object',
	#category : 'OpenPonk-OntoUML-Verifications-UI',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'UI'
}

{ #category : 'specs' }
VerificationUI class >> changeElementColorTo: aColor using: aController [

	| diagramElement |
	(aController respondsTo: #diagramElement) ifFalse: [ ^ self ].
	diagramElement := aController diagramElement.
	(diagramElement respondsTo: #strokeColor:) ifFalse: [ ^ self ].
	aController diagramElement strokeColor: aColor
]

{ #category : 'specs' }
VerificationUI class >> removeHighlightsFromElementsIn: aDiagramController [

	aDiagramController controllers do: [ :controller | 
		self changeElementColorTo: Color black using: controller ].
	aDiagramController updateCanvas
]

{ #category : 'specs' }
VerificationUI class >> updateVerifiedElementStyle: aVerificationResults using: aController [

	| color diagramElement |
	(VerificationController
		 isVerifiable: aController model
		 includeGeneralizations: true) ifFalse: [ ^ self ].
	diagramElement := aController diagramElement.
	(diagramElement respondsTo: #strokeColor:) ifFalse: [ ^ self ].
	color := Color black.
	(aVerificationResults hasWarnings: aController model) ifTrue: [
		color := Color orange ].
	(aVerificationResults hasErrors: aController model) ifTrue: [
		color := Color red ].
	diagramElement strokeColor: color
]

{ #category : 'specs' }
VerificationUI class >> updateVerifiedElements: aVerificationResults using: aDiagramController [

	aDiagramController controllers do: [ :controller | 
		self
			updateVerifiedElementStyle: aVerificationResults
			using: controller ].
	aDiagramController updateCanvas.
	(VerificationResultsUI
		 createUIFor: aVerificationResults
		 withControllers: aDiagramController) inspect
]
