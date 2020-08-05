"
An AlgoritStepperMorphTest is a test class for testing the behavior of AlgoritStepperMorph
"
Class {
	#name : #AlgoritStepperMorphTest,
	#superclass : #TestCase,
	#category : #'Algorit-Tests'
}

{ #category : #private }
AlgoritStepperMorphTest >> newMorph [
	^ AlgoritStepperMorph new
]

{ #category : #test }
AlgoritStepperMorphTest >> testDefaultStepTime [
	self assert: self newMorph defaultStepTime equals: 100
]

{ #category : #test }
AlgoritStepperMorphTest >> testStepTime [
	| s |
	s := self newMorph.
	self assert: s stepTime equals: s defaultStepTime.
	s stepTime: 123.
	self assert: s stepTime equals: 123
]
