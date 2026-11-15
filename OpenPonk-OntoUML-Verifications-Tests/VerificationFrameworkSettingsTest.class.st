"
Tests configuration persistence and preference handling for the OntoUML verification framework.
"
Class {
	#name : 'VerificationFrameworkSettingsTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Tests-Settings',
	#package : 'OpenPonk-OntoUML-Verifications-Tests',
	#tag : 'Settings'
}

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testGetSettingFor [

	| settings |
	settings := VerificationFrameworkSettings new.
	self assert: (settings getSettingFor: 'A') description: 'Unconfigured setting should default to true'.
	settings setSettingFor: 'A' withValue: false.
	self deny: (settings getSettingFor: 'A') description: 'Setting updated to false should return false'
]

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testOntoUMLAntipatternsCategoryCanBeOpenedInSpecSettings [

	| method pragma builder declaration node presenter initialValue |
	method := VerificationFrameworkSettings class >> #settingsOnImpAbsAntipatternVerification:.
	pragma := method pragmaAt: #systemsettings.
	self deny: pragma identicalTo: nil.
	self assert: pragma selector equals: #systemsettings.

	builder := SettingTreeBuilder new.
	VerificationFrameworkSettings settingsOnImpAbsAntipatternVerification: builder.
	declaration := builder nodeList first settingDeclaration.
	self assert: declaration target identicalTo: VerificationFrameworkSettings.
	self assert: declaration targetSelector equals: #settingsInstance.

	node := StSettingNode new
		        declaration: declaration;
		        yourself.
	presenter := node asPresenterOn: StSettingDetailPresenter new.
	presenter build.

	initialValue := VerificationFrameworkSettings settingsInstance accessImpAbsAntipatternVerification.
	[
		presenter value: initialValue not.
		self assert: VerificationFrameworkSettings settingsInstance accessImpAbsAntipatternVerification equals: initialValue not.
		presenter value: initialValue.
		self assert: VerificationFrameworkSettings settingsInstance accessImpAbsAntipatternVerification equals: initialValue ] ensure: [
		VerificationFrameworkSettings settingsInstance accessImpAbsAntipatternVerification: initialValue ]
]

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testOntoUMLVerificationsCategoryCanBeOpenedInSpecSettings [

	| method pragma builder declaration node presenter initialValue |
	method := VerificationFrameworkSettings class >> #settingsOnRelationDependencyVerification:.
	pragma := method pragmaAt: #systemsettings.
	self deny: pragma identicalTo: nil.
	self assert: pragma selector equals: #systemsettings.

	builder := SettingTreeBuilder new.
	VerificationFrameworkSettings settingsOnRelationDependencyVerification: builder.
	declaration := builder nodeList first settingDeclaration.
	self assert: declaration target identicalTo: VerificationFrameworkSettings.
	self assert: declaration targetSelector equals: #settingsInstance.

	node := StSettingNode new
		        declaration: declaration;
		        yourself.
	presenter := node asPresenterOn: StSettingDetailPresenter new.
	presenter build.

	initialValue := VerificationFrameworkSettings settingsInstance accessRelationDependencyVerification.
	[
		presenter value: initialValue not.
		self assert: VerificationFrameworkSettings settingsInstance accessRelationDependencyVerification equals: initialValue not.
		presenter value: initialValue.
		self assert: VerificationFrameworkSettings settingsInstance accessRelationDependencyVerification equals: initialValue ] ensure: [
		VerificationFrameworkSettings settingsInstance accessRelationDependencyVerification: initialValue ]
]

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testSetSettingForWithValue [

	| settings |
	settings := VerificationFrameworkSettings new.
	self assert: (settings getSettingFor: 'A') description: 'Unconfigured setting should default to true'.
	settings setSettingFor: 'A' withValue: false.
	self deny: (settings getSettingFor: 'A') description: 'Setting updated to false should return false'.
	settings setSettingFor: 'A' withValue: true.
	self assert: (settings getSettingFor: 'A') description: 'Setting updated back to true should return true'
]
