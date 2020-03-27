Class {
	#name : #BaselineOfOntoUMLVerifications,
	#superclass : #BaselineOf,
	#category : #BaselineOfOntoUMLVerifications
}

{ #category : #baselines }
BaselineOfOntoUMLVerifications >> baselineOf: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				preLoadDoIt: #checkClassEditor;
				package: 'OntoUML-VerificationTraits';
				package: 'OntoUML-VerificationMessages';
				package: 'OntoUML-VerificationResults';
				package: 'OntoUML-Verifications'
					with: [ spec requires: #('OntoUML-VerificationTraits') ];
				package: 'OntoUML-VerificationController'
					with: [ spec requires: #('OntoUML-Verifications') ];
				package: 'OntoUML-VerificationTests'
					with: [ spec requires: #('OntoUML-Verifications') ].
			spec
				group: 'default'
				with:
					#('OntoUML-VerificationTests' 'OntoUML-VerificationController' 'OntoUML-VerificationResults' 'OntoUML-VerificationMessages') ]
]

{ #category : #baselines }
BaselineOfOntoUMLVerifications >> checkClassEditor [
	Smalltalk
		at: #BaselineOfClassEditor
		ifAbsent: [ Metacello new
				baseline: 'ClassEditor';
				repository: 'github://openponk/class-editor/repository';
				load ]
]
