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
		do: [ Smalltalk
				at: #BaselineOfClassEditor
				ifAbsent: [ self
						error:
							'Unable to load OntoUMLVerification as standalone repository. Load it by loading ClassEditor.' ].
			spec
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
