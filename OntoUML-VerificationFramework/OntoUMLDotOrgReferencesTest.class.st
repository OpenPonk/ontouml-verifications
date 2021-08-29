Class {
	#name : #OntoUMLDotOrgReferencesTest,
	#superclass : #TestCase,
	#category : #'OntoUML-VerificationFramework-DocumentationReferences'
}

{ #category : #tests }
OntoUMLDotOrgReferencesTest >> getExpectedUpdatedMessageCode [
	^ '"I return documentation reference for: Mock"
getDefinitionRefereceForMock
	^ ''https://ontouml.readthedocs.io/en/latest/mock/index.html'' .'.
]

{ #category : #tests }
OntoUMLDotOrgReferencesTest >> testGetDefinitionRefereceFor [
	| kind class |
	kind := OPUMLClass new.
	kind applyStereotype: OntoUMLKind new.
	class := OPUMLClass new.
	self assert: ((OntoUMLDotOrgReferences getDefinitionRefereceFor: kind) isKindOf: String) equals: true.
	self assert: (OntoUMLDotOrgReferences getDefinitionRefereceFor: class) equals: ''. 
]

{ #category : #tests }
OntoUMLDotOrgReferencesTest >> testGetDefinitionRefereceForStereotype [

	| methodList |
	methodList := (OntoUMLDotOrgReferences class localMethods collect: [ 
		               :method | method selector ]) select: [ :methodName | 
		              methodName matchesRegex: 'getDefinitionRefereceFor.+' ].
	methodList := methodList reject: [ :methodName | 
		              methodName matchesRegex:
			              'getDefinitionRefereceFor.*\:' ].
	self assert: methodList isNotEmpty.
	methodList do: [ :methodName | 
		| url |
		url := (Message selector: methodName) sendTo:
			       OntoUMLDotOrgReferences.
		self
			assert: (url isEmpty or: [ 
					 url matchesRegex:
						 'https?\:\/\/(www\.)?[-a-zA-Z0-9@%._:+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@%_:+.~#?&//=]*)' ])
			description: 'Method ' , methodName asString
				, ' did not return an url, but returned this instead: '
				, url asString ]
]

{ #category : #tests }
OntoUMLDotOrgReferencesTest >> testGetDefinitionReferenceForStereotypeCode [
	| mockAssociation updatedCode |
	mockAssociation := 'Mock' -> 'https://ontouml.readthedocs.io/en/latest/mock/index.html'.
	updatedCode := OntoUMLDotOrgReferences getDefinitionReferenceForStereotypeCode: mockAssociation.
	self assert: updatedCode equals: self getExpectedUpdatedMessageCode.
]
