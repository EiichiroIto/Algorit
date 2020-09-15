Class {
	#name : #AlgoritEvaluator,
	#superclass : #Object,
	#instVars : [
		'vars',
		'lists',
		'watchingVars',
		'varHistory',
		'listsModified',
		'messages',
		'varsModified'
	],
	#category : #'Algorit-Project'
}

{ #category : #'list ops' }
AlgoritEvaluator >> append: anObject toList: aString [ 
	| list |
	list := lists at: aString asSymbol.
	list add: anObject.
	self listsModified: true
]

{ #category : #'list ops' }
AlgoritEvaluator >> appendFrom: anObject1 to: anObject2 toList: aString [
	| list |
	list := lists at: aString asSymbol.
	anObject1 asNumberNoError to: anObject2 asNumberNoError do: [ :each | list add: each ].
	self listsModified: true
]

{ #category : #private }
AlgoritEvaluator >> appendVar: aString data: anObject [
	varHistory add: { aString. anObject }.
	varsModified := true
]

{ #category : #'variable ops' }
AlgoritEvaluator >> changeVar: aString by: anInteger [
	| v |
	v := vars at: aString asSymbol ifAbsent: [ 0 ].
	v := v asNumberNoError + anInteger.
	self setVar: aString to: v
]

{ #category : #private }
AlgoritEvaluator >> clear [
	varHistory := OrderedCollection new.
	messages := ''.
	self varsModified: true
]

{ #category : #'list ops' }
AlgoritEvaluator >> clearList: aString [ 
	lists at: aString asSymbol put: OrderedCollection new.
	self listsModified: true
]

{ #category : #'operator ops' }
AlgoritEvaluator >> computeFunction: aString of: aNumber [
	aString = 'sqrt'
		ifTrue: [ ^ aNumber sqrt ].
	aString = 'abs'
		ifTrue: [ ^ aNumber abs ].
	aString = 'sin'
		ifTrue: [ ^ aNumber degreesToRadians sin ].
	aString = 'cos'
		ifTrue: [ ^ aNumber degreesToRadians cos ].
	aString = 'tan'
		ifTrue: [ ^ aNumber degreesToRadians tan ].
	aString = 'asin'
		ifTrue: [ ^ aNumber arcSin radiansToDegrees ].
	aString = 'acos'
		ifTrue: [ ^ aNumber arcCos radiansToDegrees ].
	aString = 'atan'
		ifTrue: [ ^ aNumber arcTan radiansToDegrees ].
	aString = 'ln'
		ifTrue: [ ^ aNumber ln ].
	aString = 'log'
		ifTrue: [ ^ aNumber log ].
	aString = 'e ^'
		ifTrue: [ ^ aNumber exp ].
	aString = '10 ^'
		ifTrue: [ ^ 10 raisedTo: aNumber ].
	self error
]

{ #category : #'list ops' }
AlgoritEvaluator >> deleteLine: anInteger ofList: aString [
	| list pos |
	list := lists at: aString asSymbol.
	pos := anInteger < 0
		ifTrue: [ list size + anInteger + 1 ]
		ifFalse: [ anInteger ].
	(pos between: 1 and: list size)
		ifFalse: [ ^ self ].
	list removeIndex: pos.
	self listsModified: true
]

{ #category : #accessing }
AlgoritEvaluator >> deleteList: aString [
	lists removeKey: aString ifAbsent: [  ]
]

{ #category : #accessing }
AlgoritEvaluator >> deleteVariable: aString [
	watchingVars remove: aString ifAbsent: [  ].
	vars removeKey: aString ifAbsent: [  ].
	varHistory := varHistory reject: [ :each | each second = aString ]
]

{ #category : #'operator ops' }
AlgoritEvaluator >> getFalse [
	^ false
]

{ #category : #'list ops' }
AlgoritEvaluator >> getLine: anInteger ofList: aString [ 
	| list pos |
	list := lists at: aString asSymbol.
	pos := anInteger < 0
		ifTrue: [ list size + anInteger + 1 ]
		ifFalse: [ anInteger ].
	(pos between: 1 and: list size)
		ifFalse: [ ^ self error ].
	^ list at: pos
]

{ #category : #'operator ops' }
AlgoritEvaluator >> getTrue [
	^ true
]

{ #category : #'variable ops' }
AlgoritEvaluator >> getVar: aString [ 
	^ vars at: aString ifAbsent: [ 0 ]
]

{ #category : #initialization }
AlgoritEvaluator >> initialize [
	vars := Dictionary new.
	lists := Dictionary new.
	watchingVars := Set new.
	self clear.
	self listsModified: true
]

{ #category : #'operator ops' }
AlgoritEvaluator >> is: x between: a and: b [
	^ x between: a and: b
]

{ #category : #testing }
AlgoritEvaluator >> isWatchingVar: aString [
	^ watchingVars includes: aString
]

{ #category : #'list ops' }
AlgoritEvaluator >> lineCountOfList: aString [ 
	| list |
	list := lists at: aString asSymbol.
	^ list size
]

{ #category : #'list ops' }
AlgoritEvaluator >> list: aString contains: anInteger [ 
	| list |
	list := lists at: aString.
	^ list includes: anInteger
]

{ #category : #accessing }
AlgoritEvaluator >> lists [
	^ lists
]

{ #category : #accessing }
AlgoritEvaluator >> listsModified [
	^ listsModified
]

{ #category : #accessing }
AlgoritEvaluator >> listsModified: aBoolean [
	listsModified := aBoolean
]

{ #category : #accessing }
AlgoritEvaluator >> messages [
	^ messages
]

{ #category : #accessing }
AlgoritEvaluator >> messages: aString [
	messages := aString
]

{ #category : #'operator ops' }
AlgoritEvaluator >> negated: aNumber [
	^ aNumber negated
]

{ #category : #'operator ops' }
AlgoritEvaluator >> not: aFalse [ 
	^ aFalse not
]

{ #category : #'misc ops' }
AlgoritEvaluator >> print: aString [ 
	messages := messages , aString asString
]

{ #category : #'misc ops' }
AlgoritEvaluator >> println: aString [ 
	messages := messages , aString asString , String crlf
]

{ #category : #'operator ops' }
AlgoritEvaluator >> randomFrom: a to: b [
	^ (a to: b) atRandom
]

{ #category : #'operator ops' }
AlgoritEvaluator >> rounded: aNumber [
	^ aNumber rounded
]

{ #category : #'list ops' }
AlgoritEvaluator >> setLine: anInteger ofList: aString to: anObject [
	| list pos |
	list := lists at: aString asSymbol.
	pos := anInteger < 0
		ifTrue: [ list size + anInteger + 1 ]
		ifFalse: [ anInteger ].
	(pos between: 1 and: list size)
		ifFalse: [ ^ self ].
	list at: pos put: anObject.
	self listsModified: true
]

{ #category : #'variable ops' }
AlgoritEvaluator >> setVar: aString to: aString2 [ 
	vars at: aString asSymbol put: aString2.
	self appendVar: aString data: aString2
]

{ #category : #private }
AlgoritEvaluator >> setWatchingVar: aString to: aBoolean [
	aBoolean
		ifTrue: [ watchingVars add: aString ]
		ifFalse: [ watchingVars remove: aString ifAbsent: [  ] ]
]

{ #category : #'list ops' }
AlgoritEvaluator >> shuffleList: aString [ 
	| key |
	key := aString asSymbol.
	lists at: key put: (lists at: key) shuffled.
	self listsModified: true
]

{ #category : #'list ops' }
AlgoritEvaluator >> sortList: aString [ 
	| key |
	key := aString asSymbol.
	lists at: key put: (lists at: key) sorted.
	self listsModified: true
]

{ #category : #'list ops' }
AlgoritEvaluator >> swapLine: anInteger and: anInteger2 ofList: aString [
	| list p1 p2 |
	list := lists at: aString asSymbol.
	p1 := anInteger < 0
		ifTrue: [ list size + anInteger + 1 ]
		ifFalse: [ anInteger ].
	p2 := anInteger2 < 0
		ifTrue: [ list size + anInteger2 + 1 ]
		ifFalse: [ anInteger2 ].
	(p1 between: 1 and: list size)
		ifFalse: [ ^ self ].
	(p2 between: 1 and: list size)
		ifFalse: [ ^ self ].
	list swap: p1 with: p2.
	self listsModified: true
]

{ #category : #accessing }
AlgoritEvaluator >> toggleWatchingVar: aString [
	| b |
	b := self isWatchingVar: aString.
	self setWatchingVar: aString to: b not
]

{ #category : #'operator ops' }
AlgoritEvaluator >> truncated: aNumber [
	^ aNumber truncated
]

{ #category : #accessing }
AlgoritEvaluator >> varHistory [
	^ varHistory
]

{ #category : #accessing }
AlgoritEvaluator >> vars [
	^ vars
]

{ #category : #accessing }
AlgoritEvaluator >> varsModified [
	^ varsModified
]

{ #category : #accessing }
AlgoritEvaluator >> varsModified: aBoolean [
	varsModified := aBoolean
]

{ #category : #accessing }
AlgoritEvaluator >> watchingVarAndValues [
	^ watchingVars asOrderedCollection sorted
		collect: [ :each | 
			{each.
			(vars at: each)} ]
]

{ #category : #accessing }
AlgoritEvaluator >> watchingVarHistory [
	| list |
	list := varHistory
		select: [ :each | watchingVars includes: each first ].
	^ list withIndexCollect: [ :each :index | {index} , each ]
]

{ #category : #accessing }
AlgoritEvaluator >> watchingVars [
	^ watchingVars
]
