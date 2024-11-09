Class {
	#name : 'TClassUpdaterTest',
	#superclass : 'TestCase',
	#traits : 'TClassUpdater',
	#classTraits : 'TClassUpdater classTrait',
	#instVars : [
		'updaterClass'
	],
	#category : 'OntoUML-VerificationFramework-Traits',
	#package : 'OntoUML-VerificationFramework',
	#tag : 'Traits'
}

{ #category : 'running' }
TClassUpdaterTest >> setUp [

	super setUp.

	updaterClass := (Object << #TClassUpdaterTempTestClass)
		                traits: { TClassUpdater };
		                package: self tempPackageName;
		                install
]

{ #category : 'running' }
TClassUpdaterTest >> tearDown [

	updaterClass ifNotNil: [ :theClass | theClass removeFromSystem ].
	self packageOrganizer removePackage: self tempPackageName.
	
	super tearDown
]

{ #category : 'constrants' }
TClassUpdaterTest >> tempPackageName [

	^ 'OntoUML-VerificationFramework-TempTestClasses'
]

{ #category : 'tests' }
TClassUpdaterTest >> testUpdateMessageWithClassification [

	| testCode |
	testCode := 'testMethod: aResponse
	^ aResponse.'.
	self deny: (updaterClass class canUnderstand: #testMethod:).
	updaterClass updateMessage: testCode withClassification: 'test'.
	self assert: (updaterClass class canUnderstand: #testMethod:).
	self
		assert: (updaterClass class >> #testMethod:) sourceCode
		equals: testCode.
	self
		assert: (updaterClass class >> #testMethod:) protocolName
		equals: 'test'
]
