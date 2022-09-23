Class {
	#name : #ListBarGraph,
	#superclass : #Morph,
	#instVars : [
		'indexes',
		'stepTime',
		'script',
		'listName',
		'cachedForm',
		'needsUpdate',
		'listCount'
	],
	#category : #'Algorit-Morphic'
}

{ #category : #private }
ListBarGraph >> axisColor [

	^ Color gray
]

{ #category : #private }
ListBarGraph >> barHeight [

	^ self height - 20 max: 10
]

{ #category : #private }
ListBarGraph >> barOffset [

	^ 20 @ 10
]

{ #category : #private }
ListBarGraph >> barWidth [

	^ self width - 20 max: 10
]

{ #category : #accessing }
ListBarGraph >> cachedForm [

	^ cachedForm
]

{ #category : #accessing }
ListBarGraph >> cachedForm: anObject [

	cachedForm := anObject
]

{ #category : #private }
ListBarGraph >> checkListSizeChanged [

	| count |
	script ifNil: [ ^ self ].
	listName ifNil: [ ^ self ].
	count := script evaluator lineCountOfList: listName.
	listCount ~= count ifTrue: [ indexes := listCount := nil ]
]

{ #category : #'event handling' }
ListBarGraph >> click: evt [

	self showMenu: evt
]

{ #category : #private }
ListBarGraph >> defaultStepTime [

	^ 1000
]

{ #category : #drawing }
ListBarGraph >> drawAxesY0: anInteger on: aCanvas [

	| x1 x2 y1 y2 y0 |
	x1 := self barOffset x.
	y1 := self barOffset y.
	x2 := x1 + self barWidth.
	y2 := y1 + self barHeight.
	y0 := y2 - anInteger.
	aCanvas
		line: x1 @ y1
		to: x1 @ y2
		width: 1
		color: self axisColor;
		line: x1 @ y0
		to: x2 @ y0
		width: 1
		color: self axisColor.
	aCanvas
		drawString: '0'
		at: x1 @ y0 - self scaleOffset
		font: self scaleFont
		color: self axisColor
]

{ #category : #drawing }
ListBarGraph >> drawBarGraph: aCollection on: aCanvas [

	| min max |
	aCanvas drawString: listName at: self barWidth // 2 @ 0.
	aCollection ifNil: [ ^ self ].
	aCollection isEmpty ifTrue: [ ^ self ].
	min := aCollection min.
	max := aCollection max.
	min >= 0
		ifTrue: [ self drawPositiveValues: aCollection max: max on: aCanvas ]
		ifFalse: [ 
			max < 0
				ifTrue: [ 
				self drawNegativeValues: aCollection min: min on: aCanvas ]
				ifFalse: [ 
					self
						drawPositiveNegativeValues: aCollection
						min: min
						max: max
						on: aCanvas ] ]
]

{ #category : #drawing }
ListBarGraph >> drawNegativeBar: anInteger y0: anInteger2 width: anInteger3 at: aPoint on: aCanvas [

	| p count |
	count := anInteger3 - 1 min: 10 max: 1.
	p := aPoint + ((anInteger3 - 10 max: 0) // 2 @ 0).
	count timesRepeat: [ 
		aCanvas
			line: p - (0 @ anInteger2)
			to: p - (0 @ anInteger)
			width: 1
			color: self negativeBarColor.
		p := p + (1 @ 0) ]
]

{ #category : #drawing }
ListBarGraph >> drawNegativeValues: aCollection min: aMinNumber on: aCanvas [

	| bw p dy |
	bw := self barWidth // indexes size.
	p := self barOffset + (0 @ self barHeight).
	aCollection do: [ :each | 
		dy := self yCoordsOf: each min: aMinNumber max: 0.
		self
			drawNegativeBar: dy
			y0: self barHeight
			width: bw
			at: p
			on: aCanvas.
		p := p + (bw @ 0) ].
	self
		drawAxesY0: self barHeight on: aCanvas;
		drawScale: aMinNumber y0: 0 on: aCanvas
]

{ #category : #drawing }
ListBarGraph >> drawOn: aCanvas [

	super drawOn: aCanvas.
	cachedForm ifNil: [ ^ self ].
	aCanvas drawImage: cachedForm at: self topLeft
]

{ #category : #drawing }
ListBarGraph >> drawPositiveBar: anInteger y0: anInteger2 width: anInteger3 at: aPoint on: aCanvas [

	| p count |
	count := anInteger3 - 1 min: 10 max: 1.
	p := aPoint + ((anInteger3 - 10 max: 0) // 2 @ 0).
	count timesRepeat: [ 
		aCanvas
			line: p - (0 @ anInteger)
			to: p - (0 @ anInteger2)
			width: 1
			color: self positiveBarColor.
		p := p + (1 @ 0) ]
]

{ #category : #drawing }
ListBarGraph >> drawPositiveNegativeValues: aCollection min: aMinNumber max: aMaxNumber on: aCanvas [

	| bw p dy y0 |
	bw := self barWidth // indexes size.
	p := self barOffset + (0 @ self barHeight).
	y0 := self yCoordsOf: 0 min: aMinNumber max: aMaxNumber.
	aCollection do: [ :each | 
		dy := self yCoordsOf: each min: aMinNumber max: aMaxNumber.
		each >= 0
			ifTrue: [ 
				self
					drawPositiveBar: dy
					y0: y0
					width: bw
					at: p
					on: aCanvas ]
			ifFalse: [ 
				self
					drawNegativeBar: dy
					y0: y0
					width: bw
					at: p
					on: aCanvas ].
		p := p + (bw @ 0) ].
	self
		drawAxesY0: y0 on: aCanvas;
		drawScale: aMaxNumber y0: self barHeight on: aCanvas;
		drawScale: aMinNumber y0: 0 on: aCanvas
]

{ #category : #drawing }
ListBarGraph >> drawPositiveValues: aCollection max: aMaxNumber on: aCanvas [

	| bw p dy |
	bw := self barWidth // indexes size.
	p := self barOffset + (0 @ self barHeight).
	aCollection do: [ :each | 
		dy := self yCoordsOf: each min: 0 max: aMaxNumber.
		self
			drawPositiveBar: dy
			y0: 0
			width: bw
			at: p
			on: aCanvas.
		p := p + (bw @ 0) ].
	self
		drawAxesY0: 0 on: aCanvas;
		drawScale: aMaxNumber y0: self barHeight on: aCanvas
]

{ #category : #drawing }
ListBarGraph >> drawScale: aNumber y0: anInteger on: aCanvas [

	| str p |
	str := aNumber isInteger
		       ifTrue: [ aNumber asString ]
		       ifFalse: [ aNumber asFloat printShowingDecimalPlaces: 1 ].
	p := self barOffset - self scaleOffset
	     + (0 @ (self barHeight - anInteger)).
	aCanvas
		drawString: str
		at: p
		font: self scaleFont
		color: self axisColor
]

{ #category : #geometry }
ListBarGraph >> extent: aPoint [

	super extent: aPoint.
	needsUpdate := true.
	indexes := listCount := nil
]

{ #category : #'event handling' }
ListBarGraph >> handlesMouseDown: evt [

	^ true
]

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
	stepTime := self defaultStepTime.
	needsUpdate := false.
	self color: self theme backgroundColor
]

{ #category : #accessing }
ListBarGraph >> listCount [

	^ listCount
]

{ #category : #accessing }
ListBarGraph >> listCount: anObject [

	^ listCount := anObject
]

{ #category : #accessing }
ListBarGraph >> listName [

	^ listName
]

{ #category : #accessing }
ListBarGraph >> listName: anObject [

	listName := anObject
]

{ #category : #'event handling' }
ListBarGraph >> mouseDown: evt [

	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #accessing }
ListBarGraph >> needsUpdate [

	^ needsUpdate
]

{ #category : #accessing }
ListBarGraph >> needsUpdate: anObject [

	needsUpdate := anObject
]

{ #category : #private }
ListBarGraph >> negativeBarColor [

	^ Color red
]

{ #category : #private }
ListBarGraph >> positiveBarColor [

	^ Color blue
]

{ #category : #private }
ListBarGraph >> scaleFont [

	^ StandardFonts balloonFont
]

{ #category : #private }
ListBarGraph >> scaleOffset [

	^ 2 + (self scaleFont widthOfString: '0')
	  @ (self scaleFont height // 2)
]

{ #category : #accessing }
ListBarGraph >> script [

	^ script
]

{ #category : #accessing }
ListBarGraph >> script: anObject [

	script := anObject.
	listName := nil.
	needsUpdate := true
]

{ #category : #private }
ListBarGraph >> showMenu: anEvent [

	| list choice |
	script ifNil: [ ^ self ].
	list := script listVarNames sorted.
	list isEmpty ifTrue: [ ^ self ].
	list size = 1
		ifTrue: [ listName := list first ]
		ifFalse: [ 
			choice := AlgoritApp
				          select: 'Choose list var to display.' localized
				          chooseFrom: list.
			choice ifNil: [ ^ self ].
			listName := choice ].
	self updateIndex.
	needsUpdate := true
]

{ #category : #stepping }
ListBarGraph >> step [

	needsUpdate ifFalse: [ ^ self ].
	needsUpdate := false.
	self update.
	self changed
]

{ #category : #accessing }
ListBarGraph >> stepTime [

	^ stepTime
]

{ #category : #accessing }
ListBarGraph >> stepTime: anObject [

	stepTime := anObject
]

{ #category : #private }
ListBarGraph >> update [

	self updateListName.
	self checkListSizeChanged.
	indexes ifNil: [ self updateIndex ].
	self updateCachedForm
]

{ #category : #private }
ListBarGraph >> updateCachedForm [

	| canvas |
	cachedForm := Form extent: self extent depth: 32.
	canvas := FormCanvas on: cachedForm.
	canvas fillColor: self theme backgroundColor.
	indexes ifNil: [ ^ self ].
	self drawBarGraph: self values on: canvas
]

{ #category : #private }
ListBarGraph >> updateIndex [

	indexes := nil.
	script ifNil: [ ^ self ].
	listName ifNil: [ ^ self ].
	(script listVarNames includes: listName) ifFalse: [ ^ self ].
	listCount := script evaluator lineCountOfList: listName.
	indexes := (1 to: listCount) asArray.
	self barWidth < listCount ifTrue: [ 
		indexes := (indexes shuffled copyFrom: 1 to: self barWidth truncated)
			           sorted ]
]

{ #category : #private }
ListBarGraph >> updateListName [

	| list |
	script ifNil: [ ^ self ].
	list := script listVarNames.
	(listName notNil and: [ list includes: listName ]) ifTrue: [ ^ self ].
	listName := list isEmpty
		            ifTrue: [ nil ]
		            ifFalse: [ list sorted first ].
	indexes := nil
]

{ #category : #private }
ListBarGraph >> values [

	indexes ifNil: [ ^ nil ].
	^ indexes collect: [ :each | 
		  script evaluator getLine: each ofList: listName ]
]

{ #category : #private }
ListBarGraph >> yCoordsOf: aNumber min: aMinNumber max: aMaxNumber [

	| bh |
	bh := self barHeight / (aMaxNumber - aMinNumber).
	^ (bh * (aNumber - aMinNumber)) truncated
]
