Class {
	#name : #VerificationUI,
	#superclass : #ComposablePresenter,
	#category : #'OntoUML-VerificationFramework-UI'
}

{ #category : #specs }
VerificationUI class >> defaultSpec [
]

{ #category : #toolbar }
VerificationUI class >> toolbarMenu: aBuilder [ 
	<opEditorToolbarMenu: #OPUmlClassEditorPlugin>
	| builder |
	builder := aBuilder model diagramController model profileApplications.
	(builder isEmpty or: [ builder anyOne appliedProfile name ~= 'OntoUML' ])
		ifTrue: [ ^ self ].
	self toolbarMenuItemFor: aBuilder
]

{ #category : #specs }
VerificationUI class >> toolbarMenuItemFor: aBuilder [
	^ (aBuilder item: 'Verify model')
		action: [ self updateVerifiedElements: (VerificationController new verify: aBuilder model diagramController model) using: aBuilder model diagramController. ].
]

{ #category : #specs }
VerificationUI class >> updateVerifiedElementStyle: aVerificationResults using: aController [
	| color |
	color := Color black.
	(aVerificationResults hasWarnings: aController model) ifTrue: [ color := Color yellow. ].
	(aVerificationResults hasErrors: aController model) ifTrue: [ color := Color red. ].
	aController diagramElement style strokeColor: color.
	aController diagramElement update.
]

{ #category : #specs }
VerificationUI class >> updateVerifiedElements: aVerificationResults using: aDiagramController [
	aDiagramController controllers do: [ :controller | self updateVerifiedElementStyle: aVerificationResults using: controller ].
	aDiagramController updateView.
	(VerificationResultsUI createUIFor: aVerificationResults withControllers: aDiagramController) inspect.
]

{ #category : #initialization }
VerificationUI >> initializeWidgets [
	"We don't need to initialize anything."
]
