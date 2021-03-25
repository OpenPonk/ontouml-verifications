Class {
	#name : #RepRelAntipatternVerification,
	#superclass : #StereotypeVerification,
	#traits : 'TCodeInjectionChecker + TClassUpdater + TAncestorGartherer',
	#classTraits : 'TCodeInjectionChecker classTrait + TClassUpdater classTrait + TAncestorGartherer classTrait',
	#category : #'OntoUML-VerificationFramework-Antipattern-Classes'
}

{ #category : #constants }
RepRelAntipatternVerification class >> verifiedClass [
	^ OPUMLClass.
]

{ #category : #constants }
RepRelAntipatternVerification class >> verifiedStereotypes [
	^ { OntoUMLRelator. }.
]

{ #category : #verification }
RepRelAntipatternVerification >> createWarningMessageFor: aVerifiedObject [
 	^ {VerificationMessageWarning createFor: aVerifiedObject
		withVerification: self
		withText: (self class getStereotype: aVerifiedObject) class name , ' may exist in two identical instances.'}.
	
]

{ #category : #verification }
RepRelAntipatternVerification >> getMediationsFor: aVerifiedObjects fromModel: aVerifiedModel [
	^ OntoUMLModelQuery getAssociationsFrom: aVerifiedModel
			withStereotype: OntoUMLMediation 
			filterBy: [ :association |
				(association memberEnds anySatisfy: [ :property |
					(aVerifiedObjects includes: property type) or: (aVerifiedObjects includes: property owningClass) ]) ]. 
	
]

{ #category : #verification }
RepRelAntipatternVerification >> getUpperBoundMultiplicityOf: aMediation for: aVerifiedObjects [
	| multiplicity upperBound|
	multiplicity := (aMediation memberEnds
		select: [ :mediationProperty | aVerifiedObjects includes: mediationProperty type])
		at: 1.
	upperBound := multiplicity upper.
	upperBound = '*' ifTrue: [ upperBound := Float infinity ].
	upperBound isNumber ifFalse: [ upperBound := 0 ].
	^ upperBound.
]

{ #category : #verification }
RepRelAntipatternVerification >> verifyObject: aVerifiedObject withModel: aVerifiedModel [
 	| mediations verifiedObjectAndAncestors |
	verifiedObjectAndAncestors := self class getAncestorsFor: aVerifiedObject. 
	verifiedObjectAndAncestors add: aVerifiedObject.
	mediations := self getMediationsFor: verifiedObjectAndAncestors fromModel: aVerifiedModel. 
	mediations ifEmpty: [ ^ {} ].
	mediations do: [ :mediation | (self getUpperBoundMultiplicityOf: mediation for: verifiedObjectAndAncestors ) > 1 ifTrue: [ ^ self createWarningMessageFor: aVerifiedObject ] ].
	^ {}.
	
]