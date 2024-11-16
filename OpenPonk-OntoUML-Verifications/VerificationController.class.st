"
I represent main gate to the verification framework.

My responsibility is to start verifications and return their results in form of VerificationResults instance.
"
Class {
	#name : 'VerificationController',
	#superclass : 'Object',
	#category : 'OpenPonk-OntoUML-Verifications-Controllers',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Controllers'
}

{ #category : 'testing' }
VerificationController class >> isVerifiable: aObject includeGeneralizations: aBoolean [
	(aObject isKindOf: OPUMLClass) ifTrue: [ ^ true. ].
	(aObject isKindOf: OPUMLAssociation) ifTrue: [ ^ true. ].
	(aBoolean and: [ aObject isKindOf: OPUMLAssociation. ]) ifTrue: [ ^ true. ].
	^ false.
]

{ #category : 'verification' }
VerificationController >> detectAntiPatternsIn: aVerifiedModel [
	| verifiedObjects antiPatternVerifications results |
	verifiedObjects := self getVerifiedObjects: aVerifiedModel.
	antiPatternVerifications := self getAntiPatternVerifications select: [ :antipattern | VerificationFrameworkSettings getInstance getSettingFor: antipattern ].
	results := VerificationResults new.
	(verifiedObjects do: 
		[ :verifiedObject | (self verifySingleObject: verifiedObject withVerifications: antiPatternVerifications withModel: verifiedObjects withResults: results) ]).
	^ results.
]

{ #category : 'verification' }
VerificationController >> getAntiPatternVerifications [

	^ (self packageOrganizer packageNamed:
		   'OpenPonk-OntoUML-Verifications') definedClasses select: [ :class |
		  class packageTag name = 'Antipattern-Classes' ]
]

{ #category : 'verification' }
VerificationController >> getVerifications [

	^ (self packageOrganizer packageNamed:
		   'OpenPonk-OntoUML-Verifications') definedClasses select: [ :class |
		  class packageTag name = 'Verification-Classes' ]
]

{ #category : 'verification' }
VerificationController >> getVerifiedObjects: aVerifiedModel [
	| verifiedObjects generalizations |
	verifiedObjects := aVerifiedModel packagedElements select:	[ :element | self class isVerifiable: element includeGeneralizations: false. ].
	generalizations := (verifiedObjects flatCollect: [ :object | object generalizations ]) asSet.
	verifiedObjects addAll: generalizations.
	verifiedObjects addAll: (OntoUMLModelQuery getGeneralizationSetsFrom: aVerifiedModel packagedElements) asSet.
	^ verifiedObjects.
	
]

{ #category : 'verification' }
VerificationController >> verify: aVerifiedModel [
	| verifiedObjects verifications results |
	verifiedObjects := self getVerifiedObjects: aVerifiedModel.
	verifications := self getVerifications select: [ :verification | VerificationFrameworkSettings getInstance getSettingFor: verification ].
	results := VerificationResults new.
	(verifiedObjects do: [ :verifiedObject | (self verifySingleObject: verifiedObject withVerifications: verifications withModel: verifiedObjects withResults: results) ]).
	^ results.
]

{ #category : 'verification' }
VerificationController >> verifySingleObject: aVerifiedObject withVerifications: aVerifications withModel: aVerifiedModel withResults: aVerificationResults [
	^ (aVerifications do: [ :verification | aVerificationResults addResults: (verification verify: aVerifiedObject withModel: aVerifiedModel) ]).
]
