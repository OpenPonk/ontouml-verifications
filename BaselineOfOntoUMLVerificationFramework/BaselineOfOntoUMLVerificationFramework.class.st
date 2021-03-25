Class {
	#name : #BaselineOfOntoUMLVerificationFramework,
	#superclass : #BaselineOf,
	#category : #BaselineOfOntoUMLVerificationFramework
}

{ #category : #baselines }
BaselineOfOntoUMLVerificationFramework >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				preLoadDoIt: #checkClassEditor;
				package: 'OntoUML-Profile'.
			spec
				package: 'OntoUML-ModelQuery'
				with: [ spec requires: #('OntoUML-Profile') ].
			spec 
				package: 'OntoUML-VerificationFramework' 
				with: [ spec requires: #('OntoUML-ModelQuery OntoUML-Profile') ].
			spec
				group: 'default'
				with:
					#('OntoUML-Profile OntoUML-ModelQuery OntoUML-VerificationFramework') ]
]

{ #category : #baselines }
BaselineOfOntoUMLVerificationFramework >> checkClassEditor [
	Smalltalk
		at: #BaselineOfClassEditor
		ifAbsent: [ Metacello new
				baseline: 'ClassEditor';
				repository: 'github://openponk/class-editor/repository';
				load: #('no-verifications') ]
]
