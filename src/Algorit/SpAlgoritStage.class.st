Class {
	#name : #SpAlgoritStage,
	#superclass : #SpPresenter,
	#instVars : [
		'stepperMorph',
		'toolBar',
		'varTable',
		'listTable',
		'whenClearDo',
		'messages',
		'whenSetupDo',
		'whenStartDo',
		'whenStopDo',
		'showHistory',
		'whenHistoryDo'
	],
	#category : #'Algorit-Spec2'
}

{ #category : #layout }
SpAlgoritStage class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #toolBar withConstraints: [ :c | c height: 50 ];
		add:
			(SpPanedLayout newVertical
				add:
					(SpPanedLayout newHorizontal
						add: #varTable;
						add: #listTable;
						yourself);
				add:
					(SpBoxLayout newHorizontal
						add: #stepperMorph withConstraints: [ :c | c width: 5 ];
						add: #messages;
						yourself);
				yourself);
		yourself
]

{ #category : #accessing }
SpAlgoritStage >> addMessage: aString [

	messages morph
		put: aString;
		changed
]

{ #category : #accessing }
SpAlgoritStage >> clearMessage [

	messages morph
		clearScreen;
		changed
]

{ #category : #accessing }
SpAlgoritStage >> display [
	^ self stepper
]

{ #category : #private }
SpAlgoritStage >> historyClicked [
	showHistory := showHistory not.
	
]

{ #category : #initialization }
SpAlgoritStage >> initializePresenter [
	showHistory := false.
	stepperMorph := self newMorph morph: ScratchStepperMorph new yourself.
	self stepper stepTime: 1.
	toolBar := self newToolbar.
	varTable := self newTable.
	listTable := self newTable.
	messages := self newConsole.
	self setupToolBar.
	self focusOrder
		add: toolBar;
		add: varTable;
		add: listTable
]

{ #category : #private }
SpAlgoritStage >> newConsole [

	^ self newMorph
		  morph: ScratchConsoleMorph new;
		  yourself
]

{ #category : #initialization }
SpAlgoritStage >> setupToolBar [
	toolBar
		addItem:
			(SpToolbarButtonPresenter new
				label: 'Setup' localized;
				icon: (ScratchTheme formAt: #setupButton);
				action: [ whenSetupDo ifNotNil: [ whenSetupDo value ] ]);
		addItem:
			(SpToolbarButtonPresenter new
				label: 'Start' localized;
				icon: (ScratchTheme formAt: #goButton);
				action: [ whenStartDo ifNotNil: [ whenStartDo value ] ]);
		addItem:
			(SpToolbarButtonPresenter new
				label: 'Stop' localized;
				icon: (ScratchTheme formAt: #stopButton);
				action: [ whenStopDo ifNotNil: [ whenStopDo value ] ]);
		addItemRight:
			(SpToolbarButtonPresenter new
				label: 'Clear' localized;
				icon: (Smalltalk ui iconNamed: #smallDelete);
				action: [ whenClearDo ifNotNil: [ whenClearDo value ] ]);
		addItemRight:
			(SpToolbarButtonPresenter new
				label: 'History' localized;
				icon: (Smalltalk ui iconNamed: #history);
				action: [ whenHistoryDo
						ifNotNil: [ self historyClicked.
							whenHistoryDo value ] ])
]

{ #category : #private }
SpAlgoritStage >> setupVarTableColumns: aCollection [
	varTable
		columns: #();
		addColumn:
			(SpStringTableColumn
				title: 'Vars' localized
				evaluated: [ :x | x first ]).
	showHistory
		ifTrue: [ aCollection
				do: [ :each | 
					varTable
						addColumn:
							(SpStringTableColumn
								title: each
								evaluated: [ :x | 
									x second = each
										ifTrue: [ x third asString ]
										ifFalse: [ '' ] ]) ] ]
		ifFalse: [ varTable
				addColumn:
					(SpStringTableColumn
						title: 'Values' localized
						evaluated: [ :x | x second ]) ]
]

{ #category : #accessing }
SpAlgoritStage >> stepper [
	^ stepperMorph morph
]

{ #category : #accessing }
SpAlgoritStage >> updateListTable: aScript [
	| lists |
	lists := aScript watchingLists sorted.
	listTable
		columns: #();
		addColumn: (SpStringTableColumn title: 'Lists' localized evaluated: [ :x | x first ]).
	lists
		withIndexDo: [ :each :index |
			listTable
				addColumn:
					(SpStringTableColumn
						title: each
						evaluated: [ :x | 
							(x at: index + 1)
								ifNil: [ '' ]
								ifNotNil: [ :v | v asString ] ]) ].
	self updateLists: aScript
]

{ #category : #accessing }
SpAlgoritStage >> updateLists: aScript [
	listTable items: aScript watchingListItems
]

{ #category : #accessing }
SpAlgoritStage >> updateVarTable: aScript [
	self setupVarTableColumns: aScript watchingVars sorted.
	self updateVars: aScript
]

{ #category : #accessing }
SpAlgoritStage >> updateVars: aScript [
	varTable
		items:
			(showHistory
				ifTrue: [ aScript watchingVarHistory ]
				ifFalse: [ aScript watchingVarAndValues ])
]

{ #category : #accessing }
SpAlgoritStage >> whenClearDo: aBlock [
	whenClearDo := aBlock
]

{ #category : #accessing }
SpAlgoritStage >> whenHistoryDo: aBlock [
	whenHistoryDo := aBlock
]

{ #category : #accessing }
SpAlgoritStage >> whenSetupDo: aBlock [
	whenSetupDo := aBlock
]

{ #category : #accessing }
SpAlgoritStage >> whenStartDo: aBlock [
	whenStartDo := aBlock
]

{ #category : #accessing }
SpAlgoritStage >> whenStepsDo: aBlock [
	self stepper
		whenStepsDo: aBlock;
		startStepping
]

{ #category : #accessing }
SpAlgoritStage >> whenStopDo: aBlock [
	whenStopDo := aBlock
]
