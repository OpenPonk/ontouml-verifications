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
				with: [ spec requires: #('OntoUMLModelQuery') ].
			spec group: 'plugin' with: #('OntoUML-VerificationFramework').
			spec
				group: 'default'
				with: #(ClassEditor 'OntoUML-VerificationFramework') ]
]
