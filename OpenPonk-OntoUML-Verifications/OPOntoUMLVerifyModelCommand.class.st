"
A model command that runs formal verification and constraint checks on the active OntoUML model.
"
Class {
	#name : 'OPOntoUMLVerifyModelCommand',
	#superclass : 'OPOntoUMLVerificationCommand',
	#category : 'OpenPonk-OntoUML-Verifications-Commands',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Commands'
}

{ #category : 'activation' }
OPOntoUMLVerifyModelCommand class >> modelMenuActivation [
	<classAnnotation>
	^ OPModelMenuActivation
		byItemOf: OPOntoUMLVerificationMenuGroup
		order: 10
		for: OPEditor
]

{ #category : 'accessing' }
OPOntoUMLVerifyModelCommand >> defaultMenuItemName [
	"Answers the display name of the verify model command."
	^ 'Verify model'
]

{ #category : 'execution' }
OPOntoUMLVerifyModelCommand >> execute [
	"Verifies the active model and highlights results in the diagram."
	VerificationUI
		updateVerifiedElements: (VerificationController new verify: self model)
		using: self diagramController
]
