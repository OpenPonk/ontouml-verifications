Trait {
	#name : 'TAncestorGartherer',
	#category : 'OpenPonk-OntoUML-Verifications-Traits',
	#package : 'OpenPonk-OntoUML-Verifications',
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
