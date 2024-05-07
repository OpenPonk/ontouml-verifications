Class {
	#name : 'VerificationFrameworkSettingsTest',
	#superclass : 'TestCase',
	#category : 'OntoUML-VerificationFramework-Settings',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Settings'
}

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testGetSettingFor [
	| settings |
	settings := VerificationFrameworkSettings new.
	self assert: (settings getSettingFor: 'A') equals: true.
	settings setSettingFor: 'A' withValue: false.
	self assert: (settings getSettingFor: 'A') equals: false.
	
]

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testSetSettingForWithValue [
	| settings |
	settings := VerificationFrameworkSettings new.
	self assert: (settings getSettingFor: 'A') equals: true.
	settings setSettingFor: 'A' withValue: false.
	self assert: (settings getSettingFor: 'A') equals: false.
	
]
