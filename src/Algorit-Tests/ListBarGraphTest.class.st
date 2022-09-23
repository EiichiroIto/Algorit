"
A ListBarGraphTest is a test class for testing the behavior of ListBarGraph
"
Class {
	#name : #ListBarGraphTest,
	#superclass : #TestCase,
	#category : #'Algorit-Tests'
}

{ #category : #private }
ListBarGraphTest >> newMorph [

	^ ListBarGraph new
]

{ #category : #private }
ListBarGraphTest >> newScript [

	^ AlgoritScript new
]

{ #category : #private }
ListBarGraphTest >> setupList: aString values: aCollection to: aScript [

	aScript addList: aString.
	aCollection do: [ :each | 
		aScript evaluator append: each toList: aString ]
]

{ #category : #test }
ListBarGraphTest >> testAxisColor [

	| morph |
	morph := self newMorph.
	self assert: (morph axisColor isKindOf: Color)
]

{ #category : #test }
ListBarGraphTest >> testBarHeight [

	| morph |
	morph := self newMorph.
	morph extent: 100 @ 100.
	self assert: morph barHeight equals: 80.
	morph extent: 100 @ 5.
	self assert: morph barHeight equals: 10
]

{ #category : #test }
ListBarGraphTest >> testBarOffset [

	| morph |
	morph := self newMorph.
	self assert: morph barOffset isPoint
]

{ #category : #test }
ListBarGraphTest >> testBarWidth [

	| morph |
	morph := self newMorph.
	morph extent: 100 @ 100.
	self assert: morph barWidth equals: 80.
	morph extent: 5 @ 100.
	self assert: morph barWidth equals: 10
]

{ #category : #test }
ListBarGraphTest >> testCachedForm [

	| morph f |
	morph := self newMorph.
	self assert: morph cachedForm isNil.
	f := Form extent: 1 @ 1 depth: 32.
	morph cachedForm: f.
	self assert: morph cachedForm identicalTo: f
]

{ #category : #test }
ListBarGraphTest >> testCheckListSizeChanged [

	| morph script |
	morph := self newMorph.
	script := self newScript.
	morph script: script.
	self setupList: 'a' values: #( 10 20 30 ) to: script.
	morph listName: 'a'.
	morph updateIndex.
	self assert: morph indexes notNil.
	self assert: morph listCount equals: 3.
	morph checkListSizeChanged.
	self assert: morph indexes notNil.
	self assert: morph listCount equals: 3.
	morph updateIndex.
	self setupList: 'a' values: #( 40 50 60 ) to: script.
	morph checkListSizeChanged.
	self assert: morph indexes notNil.
	self assert: morph listCount equals: 3.
	self setupList: 'a' values: #( 40 50 60 70 ) to: script.
	morph checkListSizeChanged.
	self assert: morph indexes isNil.
	self assert: morph listCount isNil
]

{ #category : #test }
ListBarGraphTest >> testDefaultStepTime [

	| morph |
	morph := self newMorph.
	self assert: morph defaultStepTime isInteger
]

{ #category : #test }
ListBarGraphTest >> testIndexes [

	| morph a |
	morph := self newMorph.
	self assert: morph indexes isNil.
	a := Array with: 1 with: 2.
	morph indexes: a.
	self assert: morph indexes identicalTo: a
]

{ #category : #test }
ListBarGraphTest >> testInitialize [

	| morph |
	morph := self newMorph.
	self deny: morph needsUpdate.
	self assert: morph stepTime equals: morph defaultStepTime
]

{ #category : #test }
ListBarGraphTest >> testListCount [

	| morph |
	morph := self newMorph.
	self assert: morph listCount isNil.
	morph listCount: 123.
	self assert: morph listCount equals: 123.
	morph listCount: 456.
	self assert: morph listCount equals: 456
]

{ #category : #test }
ListBarGraphTest >> testListName [

	| morph |
	morph := self newMorph.
	self assert: morph listName isNil.
	morph listName: 'abc'.
	self assert: morph listName equals: 'abc'.
	morph listName: 'def'.
	self assert: morph listName equals: 'def'
]

{ #category : #test }
ListBarGraphTest >> testNeedsUpdate [

	| morph |
	morph := self newMorph.
	self deny: morph needsUpdate.
	morph needsUpdate: true.
	self assert: morph needsUpdate.
	morph needsUpdate: false.
	self deny: morph needsUpdate
	
]

{ #category : #test }
ListBarGraphTest >> testNegativeBarColor [

	| morph |
	morph := self newMorph.
	self assert: (morph negativeBarColor isKindOf: Color)
]

{ #category : #test }
ListBarGraphTest >> testPositiveBarColor [

	| morph |
	morph := self newMorph.
	self assert: (morph positiveBarColor isKindOf: Color)
]

{ #category : #test }
ListBarGraphTest >> testScaleFont [

	| morph |
	morph := self newMorph.
	self assert: (morph scaleFont isKindOf: LogicalFont)
]

{ #category : #test }
ListBarGraphTest >> testScaleOffset [

	| morph |
	morph := self newMorph.
	self assert: morph scaleOffset isPoint
]

{ #category : #test }
ListBarGraphTest >> testScript [

	| morph s |
	morph := self newMorph.
	self assert: morph script isNil.
	s := self newScript.
	morph script: s.
	self assert: morph script identicalTo: s
]

{ #category : #test }
ListBarGraphTest >> testStepTime [

	| morph |
	morph := self newMorph.
	self assert: morph stepTime equals: morph defaultStepTime.
	morph stepTime: 123.
	self assert: morph stepTime equals: 123
]

{ #category : #test }
ListBarGraphTest >> testUpdateIndex [

	| morph script |
	morph := self newMorph.
	script := self newScript.
	morph script: nil.
	morph listName: nil.
	morph updateIndex.
	self assert: morph indexes isNil.
	morph script: script.
	morph updateIndex.
	self assert: morph indexes isNil.
	self assert: morph listCount isNil.
	self setupList: 'a' values: #( 10 20 30 ) to: script.
	morph listName: 'a'.
	morph updateIndex.
	self assertCollection: morph indexes equals: #( 1 2 3 ).
	self assert: morph listCount equals: 3.
	self setupList: 'b' values: (Array new: 100) to: script.
	morph extent: 50 @ 50.
	morph listName: 'b'.
	morph updateIndex.
	self assert: morph indexes size equals: morph barWidth.
	morph indexes do: [ :each | self assert: (each between: 1 and: 100) ].
	self assert: morph listCount equals: 100
]

{ #category : #test }
ListBarGraphTest >> testUpdateListName [

	| morph script |
	morph := self newMorph.
	morph script: nil.
	morph listName: nil.
	morph updateListName.
	self assert: morph listName isNil.
	script := self newScript.
	morph script: script.
	morph updateListName.
	self assert: morph listName isNil.
	self setupList: 'a' values: #( 1 2 3 ) to: script.
	self setupList: 'b' values: #( 4 5 6 ) to: script.
	morph listName: nil.
	morph updateListName.
	self assert: morph listName equals: 'a'.
	morph listName: 'a'.
	morph updateListName.
	self assert: morph listName equals: 'a'.
	morph listName: 'b'.
	morph updateListName.
	self assert: morph listName equals: 'b'.
	morph listName: 'c'.
	morph updateListName.
	self assert: morph listName equals: 'a'.
	script deleteList: 'a'.
	morph listName: 'c'.
	morph updateListName.
	self assert: morph listName equals: 'b'.
	script deleteList: 'b'.
	morph listName: 'c'.
	morph updateListName.
	self assert: morph listName isNil
]

{ #category : #test }
ListBarGraphTest >> testValues [

	| morph script |
	morph := self newMorph.
	script := self newScript.
	self setupList: 'a' values: #( 10 20 30 40 50 ) to: script.
	morph script: script.
	morph listName: 'a'.
	morph indexes: #( 1 2 3 ).
	self assertCollection: morph values equals: #( 10 20 30 ).
	morph indexes: #( 1 3 5 ).
	self assertCollection: morph values equals: #( 10 30 50 )
]

{ #category : #test }
ListBarGraphTest >> testYCoordsOfMinMax [

	| morph ret |
	morph := self newMorph.
	morph extent: 100 @ 100.
	ret := morph yCoordsOf: 0 min: 0 max: 100.
	self assert: ret equals: 0.
	ret := morph yCoordsOf: 100 min: 0 max: 100.
	self assert: ret equals: 80.
	ret := morph yCoordsOf: 50 min: 0 max: 100.
	self assert: ret equals: 40.
	ret := morph yCoordsOf: 0 min: -100 max: 0.
	self assert: ret equals: 80.
	ret := morph yCoordsOf: -100 min: -100 max: 0.
	self assert: ret equals: 0.
	ret := morph yCoordsOf: -50 min: -100 max: 0.
	self assert: ret equals: 40
]
