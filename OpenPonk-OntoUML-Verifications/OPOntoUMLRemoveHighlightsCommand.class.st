"
A model command that removes visual verification and antipattern highlight markers from the OntoUML diagram.
"
Class {
	#name : 'OPOntoUMLRemoveHighlightsCommand',
	#superclass : 'OPOntoUMLVerificationCommand',
	#category : 'OpenPonk-OntoUML-Verifications-Commands',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Commands'
}

{ #category : 'activation' }
OPOntoUMLRemoveHighlightsCommand class >> modelMenuActivation [
	<classAnnotation>
	^ OPModelMenuActivation
		byItemOf: OPOntoUMLVerificationMenuGroup
		order: 30
		for: OPEditor
]

{ #category : 'accessing' }
OPOntoUMLRemoveHighlightsCommand >> defaultMenuItemName [
	"Answers the display name of the remove highlights command."
	^ 'Remove highlights'
]

{ #category : 'execution' }
OPOntoUMLRemoveHighlightsCommand >> execute [
	"Removes verification highlights from elements in the active diagram."
	VerificationUI removeHighlightsFromElementsIn: self diagramController
]
