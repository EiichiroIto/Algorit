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
AlgoritProjectTest >> testAddScriptNamed [

	| project script |
	project := self newProject.
	self assert: project scripts isEmpty.
	script := project addScriptNamed: 'abc'.
	self assert: script objName equals: 'abc'.
	self assert: script project equals: project.
	self assert: project scripts size equals: 1.
	self assert: project scripts first equals: script
]

{ #category : #test }
AlgoritProjectTest >> testFileVersionString [

	self
		assert: self newProject newProjectReadWriter fileVersionString
		equals: 'AlgoritV01'
]
