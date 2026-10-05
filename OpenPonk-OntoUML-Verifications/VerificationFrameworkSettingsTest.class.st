"
Tests configuration persistence and preference handling for the OntoUML verification framework.
"
Class {
	#name : 'VerificationFrameworkSettingsTest',
	#superclass : 'TestCase',
	#category : 'OpenPonk-OntoUML-Verifications-Settings',
	#package : 'OpenPonk-OntoUML-Verifications',
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
VerificationFrameworkSettingsTest >> testOntoUMLAntipatternsCategoryCanBeOpenedInSpecSettings [
	| method pragma builder declaration node presenter initialValue |
	method := VerificationFrameworkSettings class >> #settingsOnImpAbsAntipatternVerification:.
	pragma := method pragmaAt: #systemsettings.
	self assert: pragma isNotNil description: 'Method must declare <systemsettings> pragma'.

	builder := SettingTreeBuilder new.
	VerificationFrameworkSettings settingsOnImpAbsAntipatternVerification: builder.
	declaration := builder nodeList first settingDeclaration.
	self assert: declaration target equals: VerificationFrameworkSettings.
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
		self assert: VerificationFrameworkSettings settingsInstance accessImpAbsAntipatternVerification equals: initialValue
	] ensure: [
		VerificationFrameworkSettings settingsInstance accessImpAbsAntipatternVerification: initialValue ]
]

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testOntoUMLVerificationsCategoryCanBeOpenedInSpecSettings [
	| method pragma builder declaration node presenter initialValue |
	method := VerificationFrameworkSettings class >> #settingsOnRoleMediationDependencyVerification:.
	pragma := method pragmaAt: #systemsettings.
	self assert: pragma isNotNil description: 'Method must declare <systemsettings> pragma'.

	builder := SettingTreeBuilder new.
	VerificationFrameworkSettings settingsOnRoleMediationDependencyVerification: builder.
	declaration := builder nodeList first settingDeclaration.
	self assert: declaration target equals: VerificationFrameworkSettings.
	self assert: declaration targetSelector equals: #settingsInstance.

	node := StSettingNode new
		declaration: declaration;
		yourself.
	presenter := node asPresenterOn: StSettingDetailPresenter new.
	presenter build.

	initialValue := VerificationFrameworkSettings settingsInstance accessRoleMediationDependencyVerification.
	[
		presenter value: initialValue not.
		self assert: VerificationFrameworkSettings settingsInstance accessRoleMediationDependencyVerification equals: initialValue not.
		presenter value: initialValue.
		self assert: VerificationFrameworkSettings settingsInstance accessRoleMediationDependencyVerification equals: initialValue
	] ensure: [
		VerificationFrameworkSettings settingsInstance accessRoleMediationDependencyVerification: initialValue ]
]

{ #category : 'tests' }
VerificationFrameworkSettingsTest >> testSetSettingForWithValue [
	| settings |
	settings := VerificationFrameworkSettings new.
	self assert: (settings getSettingFor: 'A') equals: true.
	settings setSettingFor: 'A' withValue: false.
	self assert: (settings getSettingFor: 'A') equals: false.
	
]
