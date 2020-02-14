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
        baseline: 'ClassEditor'
          with: [ spec repository: 'github://openponk/class-editor/repository' ].
      spec
        	package: 'OntoUML-VerificationTraits'
        		with: [ spec requires: #('ClassEditor') ];
			package: 'OntoUML-VerificationMessages'
        		with: [ spec requires: #('ClassEditor') ];
			package: 'OntoUML-VerificationResults'
        		with: [ spec requires: #('ClassEditor') ];
			package: 'OntoUML-Verifications'
        		with: [ spec requires: #('OntoUML-VerificationTraits') ];
			package: 'OntoUML-VerificationController'
        		with: [ spec requires: #('OntoUML-Verifications') ];
			package: 'OntoUML-VerificationTests'
        		with: [ spec requires: #('OntoUML-Verifications') ].

      spec group: 'default' with: #('OntoUML-VerificationTests' 'OntoUML-VerificationController' 'OntoUML-VerificationResults' 'OntoUML-VerificationMessages') ]
]
