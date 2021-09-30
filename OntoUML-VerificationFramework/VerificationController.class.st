"
I represent main gate to the verification framework.

My responsibility is to start verifications and return their results in form of VerificationResults instance.
"
Class {
	#name : #VerificationController,
	#superclass : #Object,
	#category : #'OntoUML-VerificationFramework-Controllers'
}

{ #category : #verification }
VerificationController >> detectAntiPatternsIn: aVerifiedModel [
	| verifiedObjects antiPatternVerifications results |
	verifiedObjects := self getVerifiedObjects: aVerifiedModel.
	antiPatternVerifications := self getAntiPatternVerifications select: [ :antipattern | VerificationFrameworkSettings getInstance getSettingFor: antipattern ].
	results := VerificationResults new.
	(verifiedObjects do: 
		[ :verifiedObject | (self verifySingleObject: verifiedObject withVerifications: antiPatternVerifications withModel: verifiedObjects withResults: results) ]).
	^ results.
]

{ #category : #verification }
VerificationController >> getAntiPatternVerifications [
	^ (RPackageOrganizer default packageNamed: 'OntoUML-VerificationFramework')
		definedClasses
		select: [ :class | class tags asSet includes: 'Antipattern-Classes'. ].
]

{ #category : #verification }
VerificationController >> getVerifications [
	^ (RPackageOrganizer default packageNamed: 'OntoUML-VerificationFramework')
		definedClasses
		select: [ :class | class tags asSet includes: 'Verification-Classes' ].
]

{ #category : #verification }
VerificationController >> getVerifiedObjects: aVerifiedModel [
	| verifiedObjects generalizations |
	verifiedObjects := aVerifiedModel packagedElements select:	[ :element | (element isKindOf: OPUMLElement) and: (element isKindOf: OPUMLGeneralization) not].
	generalizations := (verifiedObjects flatCollect: [ :object | object generalizations ]).
	verifiedObjects addAll: generalizations.
	verifiedObjects addAll: (generalizations flatCollect: [ :generalization | generalization generalizationSets ]).	
	^ verifiedObjects.
	
]

{ #category : #verification }
VerificationController >> verify: aVerifiedModel [
	| verifiedObjects verifications results |
	verifiedObjects := self getVerifiedObjects: aVerifiedModel.
	verifications := self getVerifications select: [ :verification | VerificationFrameworkSettings getInstance getSettingFor: verification ].
	results := VerificationResults new.
	(verifiedObjects do: [ :verifiedObject | (self verifySingleObject: verifiedObject withVerifications: verifications withModel: verifiedObjects withResults: results) ]).
	^ results.
]

{ #category : #verification }
VerificationController >> verifySingleObject: aVerifiedObject withVerifications: aVerifications withModel: aVerifiedModel withResults: aVerificationResults [
	^ (aVerifications do: [ :verification | aVerificationResults addResults: (verification verify: aVerifiedObject withModel: aVerifiedModel) ]).
]
