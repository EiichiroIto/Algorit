Trait {
	#name : 'TScratchPlotterMenu',
	#category : 'FromScratch-Plotter',
	#package : 'FromScratch',
	#tag : 'Plotter'
}

{ #category : 'menu actions' }
TScratchPlotterMenu >> savePlotImage: aPlotter [

	| file saveForm |
	saveForm := self formFrom: aPlotter extent: 400 @ 400.
	saveForm ifNil: [ ^ self ].
	file := SpScratchPresenter
		        chooseForSaveFileReference: 'Save Plots Snapshot' localized
		        extensions: { self application imageExtension }
		        path: self application extraPath.
	file ifNil: [ ^ self ].
	self application extraDirectory: file parent.
	saveForm writePNGFileNamed: file pathString
]

{ #category : 'menu actions' }
TScratchPlotterMenu >> setMaxPlotSize: aPlotter [

	| ret |
	ret := SpScratchPresenter
		       request: 'number of max plots?' localized
		       initialAnswer: (aPlotter maxSize ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		       ifTrue: [ nil ]
		       ifFalse: [ ret asNumberNoError ].
	aPlotter maxSize: ret
]

{ #category : 'menu actions' }
TScratchPlotterMenu >> setMaxValue: aPlotter [

	| ret |
	ret := SpScratchPresenter
		       request: 'maximum plot value?' localized
		       initialAnswer: (aPlotter max ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		       ifTrue: [ nil ]
		       ifFalse: [ ret asNumberNoError ].
	aPlotter max: ret
]

{ #category : 'menu actions' }
TScratchPlotterMenu >> setMinValue: aPlotter [

	| ret |
	ret := SpScratchPresenter
		       request: 'minimum plot value?' localized
		       initialAnswer: (aPlotter min ifNil: [ '' ]) asString.
	ret ifNil: [ ^ self ].
	ret := ret isEmpty
		       ifTrue: [ nil ]
		       ifFalse: [ ret asNumberNoError ].
	aPlotter min: ret
]

{ #category : 'menu actions' }
TScratchPlotterMenu >> setPlotPeriod: aPlotter [

	| ret |
	ret := SpScratchPresenter
		       request: 'update plot period? (in milliseconds)' localized
		       initialAnswer: (aPlotter updatePeriod ifNil: [ '' ]) asString.
	(ret isNil or: [ ret isEmpty ]) ifTrue: [ ^ self ].
	ret := ret asNumberNoError.
	aPlotter updatePeriod: ret
]

{ #category : 'menu actions' }
TScratchPlotterMenu >> showMenuForPlotter: aPlotter event: anEvent [
	| m checked unchecked |
	checked := Smalltalk ui iconNamed: #smallOk.
	unchecked := Smalltalk ui iconNamed: #blank.
	m := self newMenu.
	m
		title: 'Plotter menu' localized;
		addItem: [ :item | 
			item
				name: 'Plot data' localized;
				action: [ aPlotter acceptPlots: aPlotter acceptPlots not ];
				icon: [ aPlotter acceptPlots
						ifTrue: [ checked ]
						ifFalse: [ unchecked ] ];
				autoRefresh: true ].
	m
		addItem: [ :item | 
			item
				name: 'Clear plots' localized;
				action: [ aPlotter clearPlots ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set min value' localized;
				action: [ self setMinValue: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set max value' localized;
				action: [ self setMaxValue: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set max plots' localized;
				action: [ self setMaxPlotSize: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Set update period' localized;
				action: [ self setPlotPeriod: aPlotter ] ].
	m
		addItem: [ :item | 
			item
				name: 'Save plot data' localized;
				action: [ self savePlotImage: aPlotter ] ].
	m openWithSpecAt: anEvent cursorPoint
]
