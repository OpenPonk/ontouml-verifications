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
	methodList := (OntoUMLDotOrgReferences  class localMethods 
		collect: [ :method | method selector ]) 
			select: [ :methodName | 	methodName matchesRegex: 'getDefinitionRefereceFor.+' ].
	methodList := methodList reject: [ :methodName | 	methodName = 'getDefinitionRefereceFor:' ].
	self assert: methodList isNotEmpty.
	methodList do: [ :methodName | 
		self assert: (((OntoUMLDotOrgReferences class >> (methodName asSymbol)) valueWithReceiver: nil arguments: #())  findString: 'http://') equals: 0. ].
]

{ #category : #tests }
OntoUMLDotOrgReferencesTest >> testGetDefinitionReferenceForStereotypeCode [
	| mockAssociation updatedCode |
	mockAssociation := 'Mock' -> 'https://ontouml.readthedocs.io/en/latest/mock/index.html'.
	updatedCode := OntoUMLDotOrgReferences getDefinitionReferenceForStereotypeCode: mockAssociation.
	self assert: updatedCode equals: self getExpectedUpdatedMessageCode.
]
