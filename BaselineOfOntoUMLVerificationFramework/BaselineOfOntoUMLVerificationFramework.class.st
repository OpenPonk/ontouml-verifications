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
				baseline: 'OntoUMLModelQuery-Plugin'
				with: [ spec
						className: 'BaselineOfOntoUMLModelQuery';
						repository: 'github://openponk/ontouml-modelquery';
						loads: 'plugin' ].
			spec
				baseline: 'OntoUMLModelQuery'
				with: [ spec repository: 'github://openponk/ontouml-modelquery' ].
			spec package: 'OntoUML-VerificationFramework'.
			spec
				group: 'plugin'
				with: #('OntoUMLModelQuery-Plugin' 'OntoUML-VerificationFramework').
			spec
				group: 'default'
				with: #(OntoUMLModelQuery 'OntoUML-VerificationFramework') ]
]
