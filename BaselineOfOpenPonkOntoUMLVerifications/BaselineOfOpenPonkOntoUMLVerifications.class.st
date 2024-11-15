Class {
	#name : 'BaselineOfOpenPonkOntoUMLVerifications',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOpenPonkOntoUMLVerifications',
	#package : 'BaselineOfOpenPonkOntoUMLVerifications'
}

{ #category : 'baselines' }
BaselineOfOpenPonkOntoUMLVerifications >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'PetitParser' with: [
			spec
				repository: 'github://moosetechnology/PetitParser:v3.0.x';
				loads:
					#( 'Core' 'Tests' 'Examples' 'Islands' 'Analyzer' 'Preprocessor'
					   'Indent' 'Extension' 'TestsExtension' 'Parser' ) ].
		spec baseline: 'OpenPonkOntoUMLModelQuery-Plugin' with: [
			spec
				className: 'BaselineOfOpenPonkOntoUMLModelQuery';
				repository: 'github://openponk/ontouml-modelquery';
				loads: 'plugin' ].
		spec
			project: 'OpenPonkOntoUMLModelQuery'
			copyFrom: 'OpenPonkOntoUMLModelQuery-Plugin'
			with: [ spec loads: 'default' ].
		spec
			package: 'OpenPonk-OntoUML-Verifications'
			with: [ spec requires: #( 'PetitParser' ) ].
		spec
			group: 'plugin'
			with:
			#( 'OpenPonkOntoUMLModelQuery-Plugin' 'OpenPonk-OntoUML-Verifications' ).
		spec
			group: 'default'
			with: #( OpenPonkOntoUMLModelQuery 'OpenPonk-OntoUML-Verifications' ) ]
]
