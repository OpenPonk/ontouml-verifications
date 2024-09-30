Trait {
	#name : 'TAncestorGartherer',
	#category : 'OntoUML-VerificationFramework-Traits',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Traits'
}

{ #category : 'utilities' }
TAncestorGartherer classSide >> getAncestorsFor: aChild [
	| ancestorSet |
	ancestorSet := Set new.
	self getAncestorsFor: aChild into: ancestorSet.
	^ ancestorSet.
]

{ #category : 'utilities' }
TAncestorGartherer classSide >> getAncestorsFor: aTarget into: aAncestorsSet [ 
	aTarget generalizations do: [ :generalization | 
		(aAncestorsSet includes: generalization general) ifFalse: [ 
			aAncestorsSet add: generalization general.
			self getAncestorsFor: generalization general into: aAncestorsSet. ]. ].
]
