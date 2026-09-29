"
An abstract base class for Commander 1 model commands providing OntoUML verification and antipattern diagnostics.
"
Class {
	#name : 'OPOntoUMLVerificationCommand',
	#superclass : 'OPModelCommand',
	#category : 'OpenPonk-OntoUML-Verifications-Commands',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Commands'
}

{ #category : 'testing' }
OPOntoUMLVerificationCommand class >> canBeExecutedInEditor: anEditor [
	"Answers true if the active editor has the OntoUML profile applied on its UML model."
	^ self isAbstract not and: [ OntoUMLProfileFactory isAppliedTo: anEditor ]
]

{ #category : 'testing' }
OPOntoUMLVerificationCommand class >> isAbstract [
	"Answers true if this class is the abstract root of OntoUML verification commands."
	^ self = OPOntoUMLVerificationCommand
]

{ #category : 'accessing' }
OPOntoUMLVerificationCommand >> defaultMenuIcon [
	"Answers the icon form for OntoUML verification commands."
	^ OntoUMLIcons ontoumlIcon
]
