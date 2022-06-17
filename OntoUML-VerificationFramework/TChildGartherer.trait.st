Trait {
	#name : #TChildGartherer,
	#category : #'OntoUML-VerificationFramework-Traits'
}

{ #category : #verification }
TChildGartherer classSide >> getAllChildrenFor: aAncestor from: aModel [
	| childrenSet |
	childrenSet := Set new.
	self getAllChildrenFor: aAncestor into: childrenSet from: aModel.
	^ childrenSet.
]

{ #category : #verification }
TChildGartherer classSide >> getAllChildrenFor: aTarget into: aChildrenSet from: aModel [
	((aModel select: [ :object | object isKindOf: OPUMLGeneralization. ])
		select: [ :generalization | generalization general = aTarget. ])
			do: [ :generalization | 
			(aChildrenSet includes: generalization specific) ifFalse: [ 
				aChildrenSet add: generalization specific.
				self getAllChildrenFor: generalization specific into: aChildrenSet from: aModel]. ].
]

{ #category : #verification }
TChildGartherer classSide >> getDescendantsFor: aAncestor from: aModel [
	| childrenSet |
	childrenSet := Set new.
	self getDescendantsFor: aAncestor from: aModel into: childrenSet.
	^ childrenSet
]

{ #category : #verification }
TChildGartherer classSide >> getDescendantsFor: aTarget from: aModel into: aChildrenSet [
	((aModel select: [ :object | object isKindOf: OPUMLGeneralization ])
		select: [ :generalization | generalization general = aTarget ])
		do: [ :generalization | 
			(aChildrenSet includes: generalization specific)
				ifFalse: [ aChildrenSet add: generalization specific.
					self
						getDescendantsFor: generalization specific
						from: aModel
						into: aChildrenSet ] ]
]
