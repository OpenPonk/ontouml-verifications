"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBaselineOfOntoUMLVerifications,
	#superclass : #PackageManifest,
	#category : #'BaselineOfOntoUMLVerifications-Manifest'
}

{ #category : #'code-critics' }
ManifestBaselineOfOntoUMLVerifications class >> ruleRBGlobalVariablesUsageV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BaselineOfOntoUMLVerifications #baselineOf: #false)) #'2020-03-04T09:08:48.14293+01:00') )
]
