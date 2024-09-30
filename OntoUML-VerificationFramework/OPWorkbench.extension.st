Extension { #name : 'OPWorkbench' }

{ #category : '*OntoUML-VerificationFramework' }
OPWorkbench >> getAntiPatternSettingMessageFor: aAntiPattern [
	^ aAntiPattern name , '
	<systemsettings>
	(aBuilder group: #ontoumlAntipatterns) label: ''OntoUML Anti-patterns''.
	(aBuilder setting: #access', aAntiPattern shortcut ,')
		parent: #ontoumlAntipatterns;
		target: self ;
		label: ''' , aAntiPattern shortcut , ' anti-pattern'';
		description: ''Allow or deny detection of this anti-pattern.'';
		default: true'.
]

{ #category : '*OntoUML-VerificationFramework' }
OPWorkbench class >> verificationFrameworkSettingsGroups: aBuilder [

	"I create groups for anti-patterns and verifications."

	<systemsettings>
	(aBuilder group: #ontoumlAntipatterns)
		label: 'OntoUML Anti-patterns';
		parent: #openponk;
		order: 250.
	(aBuilder group: #ontoumlVerifications)
		label: 'OntoUML Verifications';
		parent: #openponk;
		order: 240
]
