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
				package: 'OntoUML-VerificationFramework'.
			spec
				group: 'default'
				with:
					#('OntoUML-VerificationFramework') ]
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
