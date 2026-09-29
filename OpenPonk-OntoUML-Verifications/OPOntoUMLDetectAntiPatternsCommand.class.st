"
A model command that scans the active OntoUML model for structural and semantic antipatterns.
"
Class {
	#name : 'OPOntoUMLDetectAntiPatternsCommand',
	#superclass : 'OPOntoUMLVerificationCommand',
	#category : 'OpenPonk-OntoUML-Verifications-Commands',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Commands'
}

{ #category : 'activation' }
OPOntoUMLDetectAntiPatternsCommand class >> modelMenuActivation [
	<classAnnotation>
	^ OPModelMenuActivation
		byItemOf: OPOntoUMLVerificationMenuGroup
		order: 20
		for: OPEditor
]

{ #category : 'accessing' }
OPOntoUMLDetectAntiPatternsCommand >> defaultMenuItemName [
	"Answers the display name of the detect anti-patterns command."
	^ 'Detect anti-patterns'
]

{ #category : 'execution' }
OPOntoUMLDetectAntiPatternsCommand >> execute [
	"Detects anti-patterns in the active model and highlights results in the diagram."
	VerificationUI
		updateVerifiedElements: (VerificationController new detectAntiPatternsIn: self model)
		using: self diagramController
]
