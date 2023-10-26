Class {
	#name : #BaselineOfOntoUMLVerificationFramework,
	#superclass : #BaselineOf,
	#category : #BaselineOfOntoUMLVerificationFramework
}

{ #category : #baselines }
BaselineOfOntoUMLVerificationFramework >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'PetitParser' with: [
			spec
				repository: 'github://moosetechnology/PetitParser:v3.x.x/src';
				loads:
					#( 'Core' 'Tests' 'Examples' 'Islands' 'Analyzer' 'Preprocessor'
					   'Indent' 'Extension' 'TestsExtension' 'Parser' ) ].
		spec baseline: 'OntoUMLModelQuery-Plugin' with: [
			spec
				className: 'BaselineOfOntoUMLModelQuery';
				repository: 'github://openponk/ontouml-modelquery';
				loads: 'plugin' ].
		spec
			project: 'OntoUMLModelQuery'
			copyFrom: 'OntoUMLModelQuery-Plugin'
			with: [ spec loads: 'default' ].
		spec
			package: 'OntoUML-VerificationFramework'
			with: [ spec requires: #( 'PetitParser' ) ].
		spec
			group: 'plugin'
			with:
			#( 'OntoUMLModelQuery-Plugin' 'OntoUML-VerificationFramework' ).
		spec
			group: 'default'
			with: #( OntoUMLModelQuery 'OntoUML-VerificationFramework' ) ]
]
