"
I am responsible for updating verification framework using sepcifitactions from https://github.com/OntoUML/OntoUML
First I read references from updatingIndex.yaml and then update all classes tagged as Verification-Classes and class OntoUMLDotOrgReferences.
"
Class {
	#name : 'OntoUMLVerificationUpdater',
	#superclass : 'Object',
	#instVars : [
		'classSpecifications',
		'relationshipSpecifications',
		'documentationReferences',
		'updatingIndex'
	],
	#category : 'OntoUML-VerificationFramework-Updating',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Updating'
}

{ #category : 'updating' }
OntoUMLVerificationUpdater class >> updateVerifications [

	<script>
	| updater |
	updater := self new.
	updater classSpecifications: updater loadClassSpecifications.
	updater relationshipSpecifications:
		updater loadRelationshipSpecifications.
	updater loadDocumentationReferences.
	updater updateReferences.
	updater updateVerifications
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> antipatternDocumentationReferences [
	^ (documentationReferences at: 'anti-patterns') associations .
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> classDocumentationReferences [
	^ (documentationReferences at: 'classes') associations .
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> classSpecifications [
	^ classSpecifications.
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> classSpecifications: aSpecifications [
	classSpecifications := aSpecifications.
]

{ #category : 'updating' }
OntoUMLVerificationUpdater >> getClassSpecificationPaths [
	^ (self updatingIndex at: 'verifications') at: 'class_specification_paths'.
]

{ #category : 'updating' }
OntoUMLVerificationUpdater >> getRelationshipSpecificationPaths [
	^ (self updatingIndex at: 'verifications') at: 'relationship_specification_paths'.
]

{ #category : 'updating' }
OntoUMLVerificationUpdater >> getVerifications [
	^ (RPackageOrganizer default packageNamed: 'OntoUML-VerificationFramework')
		definedClasses
		select: [ :class | (class tags asSet includes: 'Verification-Classes') "or: (class tags asSet includes: 'Antipattern-Classes')" ].
]

{ #category : 'constants' }
OntoUMLVerificationUpdater >> indexUrl [
	^ self sourceAddress , 'updatingIndex.yaml'.
]

{ #category : 'loading' }
OntoUMLVerificationUpdater >> loadClassSpecification: aUrl [
	^ self parseClassYaml: ((ZnEasy get: aUrl) contents copyReplaceAll: '?' with: 'true').
]

{ #category : 'loading' }
OntoUMLVerificationUpdater >> loadClassSpecifications [
	^ (self getClassSpecificationPaths collect:  [ :specificationPath | 
			(self loadClassSpecification: 
				(self sourceAddress , specificationPath , self specificationFileName)) ])
			select: [ :specification | specification isNotNil ].
]

{ #category : 'loading' }
OntoUMLVerificationUpdater >> loadDocumentationReferences [
	documentationReferences := (self updatingIndex at: 'documentationReferences') .
]

{ #category : 'loading' }
OntoUMLVerificationUpdater >> loadIndex [
	^ self parseYaml: (ZnEasy get: self indexUrl) contents.
]

{ #category : 'loading' }
OntoUMLVerificationUpdater >> loadRelationshipSpecification: aUrl [
	^ self parseRelationshipYaml: ((ZnEasy get: aUrl) contents copyReplaceAll: '?' with: 'true').
]

{ #category : 'loading' }
OntoUMLVerificationUpdater >> loadRelationshipSpecifications [
	^ (self getRelationshipSpecificationPaths collect:  [ :specificationPath | 
			(self loadRelationshipSpecification: 
				(self sourceAddress , specificationPath , self specificationFileName)) ])
			select: [ :specification | specification isNotNil ].
]

{ #category : 'parsing' }
OntoUMLVerificationUpdater >> parseClassYaml: aParsedYaml [ 
	^ OntoUMLClassStereotypeYaml createFromYaml: ((self parseYaml: aParsedYaml) at: 'class_stereotype').
]

{ #category : 'parsing' }
OntoUMLVerificationUpdater >> parseRelationshipYaml: aParsedYaml [ 
	| parsedFile |
	parsedFile := self parseYaml: aParsedYaml.
	(parsedFile keys anySatisfy: [ :key | key = 'relationship_stereotype' ]) ifTrue: [ ^ OntoUMLRelationshipStereotypeYaml createFromYaml: (parsedFile at: 'relationship_stereotype') ].
	(parsedFile keys anySatisfy: [ :key | key = 'aggregation_stereotype' ]) ifTrue: [ ^ OntoUMLRelationshipStereotypeYaml createFromYaml: (parsedFile at: 'aggregation_stereotype') ].
	^ nil.
]

{ #category : 'parsing' }
OntoUMLVerificationUpdater >> parseYaml: aParsedYaml [ 
	| yamlParser |
	yamlParser := PPYAMLGrammar new.
	^ yamlParser parse: aParsedYaml.
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> relationshipDocumentationReferences [
	^ (documentationReferences at: 'relationships') associations .
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> relationshipSpecifications [
	^ relationshipSpecifications.
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> relationshipSpecifications: aSpecifications [
	relationshipSpecifications := aSpecifications.
]

{ #category : 'constants' }
OntoUMLVerificationUpdater >> sourceAddress [
	^ 'https://raw.githubusercontent.com/OntoUML/OntoUML/master/'.
]

{ #category : 'constants' }
OntoUMLVerificationUpdater >> specificationFileName [
	^ 'meta.yml'.
]

{ #category : 'updating' }
OntoUMLVerificationUpdater >> updateDocumentationReferences [
	OntoUMLDotOrgReferences updateFrom: self .
]

{ #category : 'updating' }
OntoUMLVerificationUpdater >> updateReferences [
	OntoUMLDotOrgReferences updateFrom: self.
]

{ #category : 'updating' }
OntoUMLVerificationUpdater >> updateVerifications [
	self getVerifications do: [ :verification | verification updateFrom: self ].
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> updatingIndex [
 	updatingIndex ifNil: [ updatingIndex := self loadIndex ].
	^ updatingIndex.
]

{ #category : 'acccessing' }
OntoUMLVerificationUpdater >> updatingIndex: aIndex [
 	updatingIndex := aIndex.
]
