Class {
	#name : 'AlgoritEvaluator',
	#superclass : 'Object',
	#instVars : [
		'vars',
		'lists',
		'watchingVars',
		'varHistory',
		'listsModified',
		'messages',
		'varsModified',
		'random',
		'timer'
	],
	#category : 'Algorit-Project',
	#package : 'Algorit',
	#tag : 'Project'
}

{ #category : 'ston-core' }
AlgoritEvaluator class >> stonAllInstVarNames [
	^ super stonAllInstVarNames \ #(listsModified varsModified random)
]

{ #category : 'operator ops' }
AlgoritEvaluator >> and: aBoolean with: anotherBoolean [

	^ aBoolean and: [ anotherBoolean ]
]

{ #category : 'list ops' }
AlgoritEvaluator >> append: anObject toList: aString [ 
	| list |
	list := lists at: aString asSymbol.
	list add: anObject.
	self listsModified: true
]

{ #category : 'list ops' }
AlgoritEvaluator >> appendFrom: anObject1 to: anObject2 toList: aString [
	| list |
	list := lists at: aString asSymbol.
	anObject1 asNumberNoError to: anObject2 asNumberNoError do: [ :each | list add: each ].
	self listsModified: true
]

{ #category : 'list ops' }
AlgoritEvaluator >> appendRandom: anInteger from: anInteger2 to: anInteger3 toList: aString [
	| list from to count size numbers |
	count := anInteger asNumberNoError.
	from := anInteger2 asNumberNoError.
	to := anInteger3 asNumberNoError.
	size := to - from + 1.
	count > size
		ifTrue: [ numbers := self numbers: count from: from to: to.
			numbers shuffleBy: random ]
		ifFalse: [ numbers := (from to: to) asArray.
			numbers shuffleBy: random.
			numbers := numbers copyFrom: 1 to: count ].
	list := lists at: aString asSymbol.
	numbers do: [ :each | list add: each ].
	self listsModified: true
]

{ #category : 'private' }
AlgoritEvaluator >> appendVar: aString data: anObject [
	varHistory add: { aString. anObject }.
	varsModified := true
]

{ #category : 'variable ops' }
AlgoritEvaluator >> changeVar: aString by: anInteger [
	| v |
	v := vars at: aString asSymbol ifAbsent: [ 0 ].
	v := v asNumberNoError + anInteger.
	self setVar: aString to: v
]

{ #category : 'private' }
AlgoritEvaluator >> clear [

	self clearVarHistory.
	self resetTimer.
	messages := ''
]

{ #category : 'list ops' }
AlgoritEvaluator >> clearList: aString [ 
	lists at: aString asSymbol put: OrderedCollection new.
	self listsModified: true
]

{ #category : 'api' }
AlgoritEvaluator >> clearVarHistory [
	varHistory := OrderedCollection new.
	varsModified := true
]

{ #category : 'operator ops' }
AlgoritEvaluator >> computeFunction: aString of: aNumber [
	aString = 'sqrt'
		ifTrue: [ ^ aNumber sqrt ].
	aString = 'abs'
		ifTrue: [ ^ aNumber abs ].
	aString = 'sign'
		ifTrue: [ ^ aNumber sign ].
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

{ #category : 'private' }
AlgoritEvaluator >> convertToFloat: anObject [

	^ (anObject isNumber and: [ anObject isInteger not ])
		  ifTrue: [ anObject asFloat ]
		  ifFalse: [ anObject ]
]

{ #category : 'private' }
AlgoritEvaluator >> convertToNumber: anObject [

	^ (anObject isString and: [ anObject isNumberString ])
		  ifTrue: [ anObject asNumber ]
		  ifFalse: [ anObject ]
]

{ #category : 'list ops' }
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

{ #category : 'list ops' }
AlgoritEvaluator >> deleteList: aString [
	lists removeKey: aString ifAbsent: [  ]
]

{ #category : 'variable ops' }
AlgoritEvaluator >> deleteVariable: aString [
	watchingVars remove: aString ifAbsent: [  ].
	vars removeKey: aString ifAbsent: [  ].
	varHistory := varHistory reject: [ :each | each first = aString ]
]

{ #category : 'operator ops' }
AlgoritEvaluator >> div: aNumber by: aNumber2 [

	^ aNumber // aNumber2
]

{ #category : 'operator ops' }
AlgoritEvaluator >> divide: aNumber by: aNumber2 [

	^ self convertToFloat: aNumber / aNumber2
]

{ #category : 'operator ops' }
AlgoritEvaluator >> equal: anObject to: anotherObject [

	| arg1 arg2 |
	arg1 := anObject.
	arg2 := anotherObject.
	arg1 == arg2 ifTrue: [ ^ true ].
	(arg1 isString and: [ arg2 isKindOf: Boolean ]) ifTrue: [ 
		arg1 = 'true' ifTrue: [ ^ arg2 = true ].
		arg1 = 'false' ifTrue: [ ^ arg2 = false ] ].
	((arg1 isKindOf: Boolean) and: [ arg2 isString ]) ifTrue: [ 
		arg2 = 'true' ifTrue: [ ^ arg1 = true ].
		arg2 = 'false' ifTrue: [ ^ arg1 = false ] ].
	arg1 := self convertToNumber: arg1.
	arg2 := self convertToNumber: arg2.
	((arg1 isNumber and: [ arg2 isNumber ]) or: [ 
		 arg1 isString and: [ arg2 isString ] ]) ifTrue: [ ^ arg1 = arg2 ].
	^ false
]

{ #category : 'operator ops' }
AlgoritEvaluator >> getFalse [
	^ false
]

{ #category : 'list ops' }
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

{ #category : 'operator ops' }
AlgoritEvaluator >> getTrue [
	^ true
]

{ #category : 'variable ops' }
AlgoritEvaluator >> getVar: aString [ 
	^ vars at: aString ifAbsent: [ 0 ]
]

{ #category : 'initialization' }
AlgoritEvaluator >> initialize [
	vars := Dictionary new.
	lists := Dictionary new.
	watchingVars := Set new.
	random := SharedRandom globalGenerator.
	self clear.
	self listsModified: true
]

{ #category : 'operator ops' }
AlgoritEvaluator >> is: x between: a and: b [
	^ x between: a and: b
]

{ #category : 'testing' }
AlgoritEvaluator >> isWatchingVar: aString [
	^ watchingVars includes: aString
]

{ #category : 'operator ops' }
AlgoritEvaluator >> less: anObject than: anotherObject [

	| arg1 arg2 |
	arg1 := self convertToNumber: anObject.
	arg2 := self convertToNumber: anotherObject.
	((arg1 isNumber and: [ arg2 isNumber ]) or: [ 
		 arg1 isString and: [ arg2 isString ] ]) ifTrue: [ ^ arg1 < arg2 ].
	^ false
]

{ #category : 'operator ops' }
AlgoritEvaluator >> lessEqual: anObject than: anotherObject [

	| arg1 arg2 |
	arg1 := self convertToNumber: anObject.
	arg2 := self convertToNumber: anotherObject.
	((arg1 isNumber and: [ arg2 isNumber ]) or: [ 
		 arg1 isString and: [ arg2 isString ] ]) ifTrue: [ ^ arg1 <= arg2 ].
	^ false
]

{ #category : 'list ops' }
AlgoritEvaluator >> lineCountOfList: aString [ 
	| list |
	list := lists at: aString asSymbol.
	^ list size
]

{ #category : 'list ops' }
AlgoritEvaluator >> list: aString contains: anInteger [ 
	| list |
	list := lists at: aString.
	^ list includes: anInteger
]

{ #category : 'accessing' }
AlgoritEvaluator >> listVarNames [

	^ lists keys
]

{ #category : 'accessing' }
AlgoritEvaluator >> lists [
	^ lists
]

{ #category : 'accessing' }
AlgoritEvaluator >> listsModified [
	^ listsModified ifNil: [ listsModified := false ]
]

{ #category : 'accessing' }
AlgoritEvaluator >> listsModified: aBoolean [
	listsModified := aBoolean
]

{ #category : 'accessing' }
AlgoritEvaluator >> messages [
	^ messages
]

{ #category : 'accessing' }
AlgoritEvaluator >> messages: aString [
	messages := aString
]

{ #category : 'operator ops' }
AlgoritEvaluator >> minus: aNumber with: anotherNumber [

	^ self convertToFloat: aNumber - anotherNumber
]

{ #category : 'operator ops' }
AlgoritEvaluator >> mod: aNumber by: aNumber2 [

	^ aNumber \\ aNumber2
]

{ #category : 'operator ops' }
AlgoritEvaluator >> more: anObject than: anotherObject [

	^ self less: anotherObject than: anObject
]

{ #category : 'operator ops' }
AlgoritEvaluator >> moreEqual: anObject than: anotherObject [

	^ self lessEqual: anotherObject than: anObject
]

{ #category : 'operator ops' }
AlgoritEvaluator >> multiply: aNumber and: anotherNumber [

	^ self convertToFloat: aNumber * anotherNumber
]

{ #category : 'operator ops' }
AlgoritEvaluator >> negated: aNumber [
	^ aNumber negated
]

{ #category : 'operator ops' }
AlgoritEvaluator >> not: aFalse [ 
	^ aFalse not
]

{ #category : 'misc ops' }
AlgoritEvaluator >> now [

	^ (Timespan current - timer) asMilliSeconds // 100 / 10.0
]

{ #category : 'private' }
AlgoritEvaluator >> numbers: anInteger from: anInteger2 to: anInteger3 [
	| stream size rest list |
	rest := anInteger.
	size := anInteger3 - anInteger2 + 1.
	self assert: [ size > 0 ].
	stream := WriteStream on: Array new.
	[ rest >= size ]
		whileTrue: [ stream nextPutAll: (anInteger2 to: anInteger3).
			rest := rest - size ].
	rest > 0
		ifTrue: [ list := (anInteger2 to: anInteger3) asArray.
			list shuffleBy: random.
			stream nextPutAll: (list copyFrom: 1 to: rest) ].
	^ stream contents
]

{ #category : 'operator ops' }
AlgoritEvaluator >> or: aBoolean with: anotherBoolean [

	^ aBoolean or: [ anotherBoolean ]
]

{ #category : 'operator ops' }
AlgoritEvaluator >> plus: aNumber and: anotherNumber [

	^ self convertToFloat: aNumber + anotherNumber
]

{ #category : 'misc ops' }
AlgoritEvaluator >> print: aString [ 
	messages := messages , aString asString
]

{ #category : 'misc ops' }
AlgoritEvaluator >> println: aString [ 
	messages := messages , aString asString , String cr
]

{ #category : 'accessing' }
AlgoritEvaluator >> random [
	^ random
]

{ #category : 'operator ops' }
AlgoritEvaluator >> randomFrom: a to: b [
	^ (a to: b) atRandom: random
]

{ #category : 'misc ops' }
AlgoritEvaluator >> resetTimer [

	timer := Timespan current
]

{ #category : 'list ops' }
AlgoritEvaluator >> reverseList: aString [ 
	| key |
	key := aString asSymbol.
	lists at: key put: (lists at: key) reversed.
	self listsModified: true
]

{ #category : 'operator ops' }
AlgoritEvaluator >> rounded: aNumber [
	^ aNumber rounded
]

{ #category : 'list ops' }
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

{ #category : 'misc ops' }
AlgoritEvaluator >> setRandomSeed: aNumber [
	| seed |
	seed := aNumber asInteger.
	random := seed = 0
		ifTrue: [ SharedRandom globalGenerator ]
		ifFalse: [ Random seed: seed ]
]

{ #category : 'variable ops' }
AlgoritEvaluator >> setVar: aString to: aString2 [ 
	vars at: aString asSymbol put: aString2.
	self appendVar: aString data: aString2
]

{ #category : 'private' }
AlgoritEvaluator >> setWatchingVar: aString to: aBoolean [
	aBoolean
		ifTrue: [ watchingVars add: aString ]
		ifFalse: [ watchingVars remove: aString ifAbsent: [  ] ]
]

{ #category : 'list ops' }
AlgoritEvaluator >> shuffleList: aString [
	| key list |
	key := aString asSymbol.
	list := lists at: key.
	list shuffleBy: random.
	lists at: key put: list.
	self listsModified: true
]

{ #category : 'list ops' }
AlgoritEvaluator >> sortList: aString [ 
	| key |
	key := aString asSymbol.
	lists at: key put: (lists at: key) sorted.
	self listsModified: true
]

{ #category : 'list ops' }
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

{ #category : 'api' }
AlgoritEvaluator >> toggleWatchingVar: aString [
	| b |
	b := self isWatchingVar: aString.
	self setWatchingVar: aString to: b not
]

{ #category : 'operator ops' }
AlgoritEvaluator >> truncated: aNumber [
	^ aNumber truncated
]

{ #category : 'misc ops' }
AlgoritEvaluator >> unknown: aString [

	"do nothing"
]

{ #category : 'accessing' }
AlgoritEvaluator >> varHistory [
	^ varHistory
]

{ #category : 'accessing' }
AlgoritEvaluator >> varNames [

	^ vars keys
]

{ #category : 'accessing' }
AlgoritEvaluator >> vars [
	^ vars
]

{ #category : 'accessing' }
AlgoritEvaluator >> varsModified [
	^ varsModified ifNil: [ varsModified := false ]
]

{ #category : 'accessing' }
AlgoritEvaluator >> varsModified: aBoolean [
	varsModified := aBoolean
]

{ #category : 'accessing' }
AlgoritEvaluator >> watchingVarAndValues [
	^ watchingVars asOrderedCollection sorted
		collect: [ :each | 
			{each.
			(vars at: each)} ]
]

{ #category : 'accessing' }
AlgoritEvaluator >> watchingVarHistory [
	| list |
	list := varHistory
		select: [ :each | watchingVars includes: each first ].
	^ list withIndexCollect: [ :each :index | {index} , each ]
]

{ #category : 'accessing' }
AlgoritEvaluator >> watchingVars [
	^ watchingVars
]
