"
An AlgoritAppTest is a test class for testing the behavior of AlgoritApp
"
Class {
	#name : #AlgoritAppTest,
	#superclass : #TestCase,
	#category : #'Algorit-Tests'
}

{ #category : #private }
AlgoritAppTest >> newApp [

	^ AlgoritApp new
]

{ #category : #tests }
AlgoritAppTest >> testRegisterDropHandler [

	| app obj |
	app := self newApp.
	self assert: ExternalDropHandler registeredHandlers isEmpty.
	app registerDropHandler.
	self assert: ExternalDropHandler registeredHandlers size equals: 1.
	obj := ExternalDropHandler registeredHandlers first.
	self assert: obj extension equals: app extension.
	app unregisterDropHandler.
	self assert: ExternalDropHandler registeredHandlers isEmpty
]

{ #category : #tests }
AlgoritAppTest >> testUnegisterDropHandler [

	self testRegisterDropHandler
]
