Class {
	#name : #AlgoritStepperMorph,
	#superclass : #Morph,
	#instVars : [
		'block',
		'stepTime'
	],
	#category : #'Algorit-Morphic'
}

{ #category : #private }
AlgoritStepperMorph >> defaultStepTime [
	^ 100
]

{ #category : #'stepping and presenter' }
AlgoritStepperMorph >> step [
	block ifNil: [ ^ self ].
	block value
]

{ #category : #stepping }
AlgoritStepperMorph >> stepTime [
	^ stepTime ifNil: [ self defaultStepTime ]
]

{ #category : #stepping }
AlgoritStepperMorph >> stepTime: anInteger [
	stepTime := anInteger
]

{ #category : #'stepping and presenter' }
AlgoritStepperMorph >> wantsSteps [
	^ true
]

{ #category : #accessing }
AlgoritStepperMorph >> whenStepsDo: aBlock [
	block := aBlock
]
