"
I represent UI for verification framework. 
I define items in menu that are responsible for starting anti-pattern detection, applying verification and removing higlights.
I am also responsible for displaying results and highliting elements in the model.
"
Class {
	#name : #VerificationUI,
	#superclass : #Object,
	#category : #'OntoUML-VerificationFramework-UI'
}

{ #category : #specs }
VerificationUI class >> changeElementColorTo: aColor using: aController [

	(aController respondsTo: #diagramElement) ifFalse: [ ^ self ].
	aController diagramElement style strokeColor: aColor.
	aController diagramElement update
]

{ #category : #specs }
VerificationUI class >> removeHighlightsFromElementsIn: aDiagramController [
	aDiagramController controllers do: [ :controller | self changeElementColorTo: Color black using: controller ].
	aDiagramController updateView.
]

{ #category : #toolbar }
VerificationUI class >> toolbarMenu: aBuilder [

	<opEditorToolbarMenu: #OPUmlClassEditorPlugin>
	| appliedProfiles |
	appliedProfiles := aBuilder model diagramController model
		                   profileApplications collect: #appliedProfile.
	(appliedProfiles noneSatisfy: [ :each | each name = 'OntoUML' ]) 
		ifTrue: [ ^ self ].
	self toolbarMenuItemFor: aBuilder
]

{ #category : #specs }
VerificationUI class >> toolbarMenuItemFor: aBuilder [

	(aBuilder item: 'Verification')
		icon: OntoUMLIcons ontoumlIcon;
		action: [  ];
		with: [ 
			(aBuilder item: 'Verify model') action: [ 
					self
						updateVerifiedElements: (VerificationController new verify:
									 aBuilder model diagramController model)
						using: aBuilder model diagramController ].
			(aBuilder item: 'Detect anti-patterns') action: [ 
					self
						updateVerifiedElements:
							(VerificationController new detectAntiPatternsIn:
									 aBuilder model diagramController model)
						using: aBuilder model diagramController ].
			(aBuilder item: 'Remove highlights') action: [ 
					self removeHighlightsFromElementsIn:
							aBuilder model diagramController ] ]
]

{ #category : #specs }
VerificationUI class >> updateVerifiedElementStyle: aVerificationResults using: aController [
	| color |
	(VerificationController isVerifiable: aController model includeGeneralizations: true) ifFalse: [ ^ self. ].
	color := Color black.
	(aVerificationResults hasWarnings: aController model) ifTrue: [ color := Color orange. ].
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
