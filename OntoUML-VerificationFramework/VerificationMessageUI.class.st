"
I am responsible for aquiring name of object referenced in VerificationMessage.
"
Class {
	#name : 'VerificationMessageUI',
	#superclass : 'Object',
	#category : 'OntoUML-VerificationFramework-UI',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'UI'
}

{ #category : 'displaying' }
VerificationMessageUI class >> getObjectReferenceName: aVerificationMessage [
	(aVerificationMessage objectReference respondsTo: #name)
		ifTrue: [ ^ aVerificationMessage objectReference name ].
	(aVerificationMessage objectReference isKindOf: OPUMLGeneralization)
		ifTrue: [ ^ 'Generalization: ' , aVerificationMessage objectReference general name , ' -> '
				, aVerificationMessage objectReference specific name ]
]
