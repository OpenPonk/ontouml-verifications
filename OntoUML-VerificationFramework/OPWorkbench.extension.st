Extension { #name : #OPWorkbench }

{ #category : #'*OntoUML-VerificationFramework' }
OPWorkbench >> getAntiPatternSettingMessageFor: aAntiPattern [
	^ aAntiPattern name , '
	<systemsettings>
	(aBuilder group: #antipatterns) label: ''Anti-patterns''.
	(aBuilder setting: #access', aAntiPattern shortcut ,')
		parent: #antipatterns;
		target: self ;
		label: ''' , aAntiPattern shortcut , ' anti-pattern'';
		description: ''Allow or deny detection of this anti-pattern.'';
		default: true'.
]

{ #category : #'*OntoUML-VerificationFramework' }
OPWorkbench class >> verificationFrameworkSettingsGroups: aBuilder [
	<systemsettings>
	"I create groups for anti-patterns and verifications."
	(aBuilder group: #antipatterns) label: 'Anti-patterns'.
	(aBuilder group: #verifications) label: 'Verifications'.
]
