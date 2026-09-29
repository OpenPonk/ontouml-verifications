"
A Commander 1 menu group that aggregates OntoUML verification, antipattern detection, and diagnostic commands.
"
Class {
	#name : 'OPOntoUMLVerificationMenuGroup',
	#superclass : 'CmdMenuGroup',
	#category : 'OpenPonk-OntoUML-Verifications-Commands',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Commands'
}

{ #category : 'accessing' }
OPOntoUMLVerificationMenuGroup >> icon [
	"Answers the OntoUML icon for the verification submenu."
	^ OntoUMLIcons ontoumlIcon
]

{ #category : 'accessing' }
OPOntoUMLVerificationMenuGroup >> name [
	"Answers the display name of the verification menu group."
	^ 'Verification'
]

{ #category : 'accessing' }
OPOntoUMLVerificationMenuGroup >> order [
	"Answers the order priority of the verification menu group."
	^ 30
]
