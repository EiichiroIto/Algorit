Class {
	#name : #ListBarGraph,
	#superclass : #Morph,
	#instVars : [
		'indexes',
		'stepTime',
		'list'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #accessing }
ListBarGraph >> indexes [

	^ indexes
]

{ #category : #accessing }
ListBarGraph >> indexes: anObject [

	indexes := anObject
]

{ #category : #initialization }
ListBarGraph >> initialize [
	super initialize.
	stepTime := 1000
]

{ #category : #stepping }
ListBarGraph >> step [

	
]

{ #category : #accessing }
ListBarGraph >> stepTime [

	^ stepTime
]

{ #category : #accessing }
ListBarGraph >> stepTime: anObject [

	stepTime := anObject
]
