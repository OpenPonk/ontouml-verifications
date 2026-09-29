"
Verifies activation rules, profile guards, and Commander 1 menu items in the OntoUML model menu.
"
Class {
	#name : 'OPOntoUMLModelMenuTest',
	#superclass : 'TestCase',
	#instVars : [
		'toolbarPresenter',
		'mockWorkbench',
		'projectController'
	],
	#category : 'OpenPonk-OntoUML-Verifications-Verification-Tests',
	#package : 'OpenPonk-OntoUML-Verifications',
	#tag : 'Verification-Tests'
}

{ #category : 'running' }
OPOntoUMLModelMenuTest >> setUp [
	super setUp.
	projectController := OPProjectController new.
	projectController project: OPProject new.
	mockWorkbench := Mock new.
	mockWorkbench stub projectController willReturn: projectController.
	mockWorkbench stub workbench willReturn: mockWorkbench.
	mockWorkbench stub announcer willReturn: Announcer new.
	toolbarPresenter := OPWorkbenchToolbar newApplication: SpApplication defaultApplication.
	toolbarPresenter owner: mockWorkbench
]

{ #category : 'running' }
OPOntoUMLModelMenuTest >> tearDown [
	toolbarPresenter := nil.
	mockWorkbench := nil.
	projectController := nil.
	super tearDown
]

{ #category : 'tests' }
OPOntoUMLModelMenuTest >> testModelMenuContainsNoOntoUmlCommandsWhenGenericUmlEditorFocusedWithoutProfile [
	"Verifies that generic UML editor without OntoUML profile does not contain any OntoUML-specific commands."
	| umlPlugin testEditor modelMenuItem subMenuNames |
	umlPlugin := OPPluginRegistry default plugins
		detect: [ :eachPluginCandidate | eachPluginCandidate isKindOf: OPUmlClassEditorPlugin ].
	testEditor := (OPEditor on: umlPlugin)
		workbench: mockWorkbench;
		yourself.
	testEditor openEmptyModel: OPUMLPackage new.

	toolbarPresenter focusedEditor: testEditor.
	modelMenuItem := toolbarPresenter menu menuGroups first menuItems
		detect: [ :eachMenuItem | eachMenuItem name = 'Model' ].

	subMenuNames := modelMenuItem subMenu menuGroups
		flatCollect: [ :eachGroup | eachGroup menuItems collect: [ :eachItem | eachItem name ] ].
	self deny: (subMenuNames includesAny: #( 'Patterns' 'Verification' 'Transform to UML' ))
]

{ #category : 'tests' }
OPOntoUMLModelMenuTest >> testModelMenuContainsOntoUmlCommandsWhenUmlEditorHasOntoUmlProfile [
	"Verifies that Model menu is enabled and contains OntoUML verification items when OntoUML profile is applied."
	| umlPlugin testEditor umlPackage ontoProfile profileApplication modelMenuItem subMenuNames |
	umlPlugin := OPUmlClassEditorPlugin new.
	testEditor := (OPEditor on: umlPlugin)
		workbench: mockWorkbench;
		yourself.
	umlPackage := OPUMLPackage new.
	ontoProfile := OntoUMLProfileFactory profile.
	profileApplication := OPUMLProfileApplication new appliedProfile: ontoProfile.
	umlPackage profileApplications add: profileApplication.
	testEditor openEmptyModel: umlPackage.

	toolbarPresenter focusedEditor: testEditor.
	modelMenuItem := toolbarPresenter menu menuGroups first menuItems
		detect: [ :eachMenuItem | eachMenuItem name = 'Model' ].

	self assert: modelMenuItem isEnabled.
	subMenuNames := modelMenuItem subMenu menuGroups
		flatCollect: [ :eachGroup | eachGroup menuItems collect: [ :eachItem | eachItem name ] ].
	self assertCollection: subMenuNames includesAll: #( 'Verification' )
]

{ #category : 'tests' }
OPOntoUMLModelMenuTest >> testVerificationSubMenuContainsAllVerificationCommandsWhenOntoUmlProfileApplied [
	"Verifies that Verification submenu contains all 3 verification items."
	| umlPlugin testEditor umlPackage ontoProfile profileApplication modelMenuItem verificationItems verificationNames |
	umlPlugin := OPPluginRegistry default plugins
		detect: [ :eachPluginCandidate | eachPluginCandidate isKindOf: OPUmlClassEditorPlugin ].
	testEditor := (OPEditor on: umlPlugin)
		workbench: mockWorkbench;
		yourself.
	umlPackage := OPUMLPackage new.
	ontoProfile := OntoUMLProfileFactory profile.
	profileApplication := OPUMLProfileApplication new appliedProfile: ontoProfile.
	umlPackage profileApplications add: profileApplication.
	testEditor openEmptyModel: umlPackage.

	toolbarPresenter focusedEditor: testEditor.
	modelMenuItem := toolbarPresenter menu menuGroups first menuItems
		detect: [ :eachMenuItem | eachMenuItem name = 'Model' ].
	verificationItems := modelMenuItem subMenu menuGroups
		flatCollect: [ :eachGroup | eachGroup menuItems select: [ :eachItem | eachItem name = 'Verification' ] ].
	self assert: verificationItems isNotEmpty.
	verificationNames := verificationItems first subMenu menuGroups
		flatCollect: [ :eachGroup | eachGroup menuItems collect: [ :eachItem | eachItem name ] ].
	self assertCollection: verificationNames includesAll: #(
		'Verify model'
		'Detect anti-patterns'
		'Remove highlights' )
]
