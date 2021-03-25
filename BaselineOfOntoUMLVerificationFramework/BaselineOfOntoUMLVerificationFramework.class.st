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
				baseline: 'ClassEditor'
				with: [ spec repository: 'github://openponk/class-editor/repository' ].
			spec
				baseline: 'OntoUMLModelQuery'
				with: [ spec repository: 'github://openponk/ontouml-modelquery' ].
			spec
				package: 'OntoUML-VerificationFramework'
				with: [ spec requires: #('OntoUMLModelQuery' 'ClassEditor') ].
			spec group: 'default' with: #('OntoUML-VerificationFramework') ]
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
