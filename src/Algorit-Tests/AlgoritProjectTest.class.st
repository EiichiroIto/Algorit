"
An AlgoritProjectTest is a test class for testing the behavior of AlgoritProject
"
Class {
	#name : #AlgoritProjectTest,
	#superclass : #TestCase,
	#category : #'Algorit-Tests'
}

{ #category : #private }
AlgoritProjectTest >> newProject [

	^ AlgoritProject new
]

{ #category : #test }
AlgoritProjectTest >> testFileVersionString [

	self
		assert: self newProject newProjectReadWriter fileVersionString
		equals: 'AlgoritV01'
]

{ #category : #test }
AlgoritProjectTest >> testNewScript [

	| project script |
	project := self newProject.
	script := project newScript.
	self assert: (script isKindOf: AlgoritScript).
	self assert: script project identicalTo: project
]

{ #category : #test }
AlgoritProjectTest >> testSetupScripts [

	| project |
	project := self newProject.
	self assert: project scripts isEmpty.
	project setupScripts.
	self assert: project scripts notEmpty.
	self assert: project scripts size equals: 1.
	self assert: (project scripts first isKindOf: AlgoritScript)
]
