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
		'variables',
		'historyTable',
		'lists',
		'graphMorph'
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
						add: #variables;
						add: #lists;
						yourself);
				add:
					(SpBoxLayout newHorizontal
						add: #stepperMorph withConstraints: [ :c | c width: 5 ];
						add: #messages;
						yourself);
				yourself);
		yourself
]

{ #category : #api }
SpAlgoritStage >> addMessage: aString [

	messages morph
		put: aString;
		changed
]

{ #category : #api }
SpAlgoritStage >> clearMessage [

	messages morph
		clearScreen;
		changed
]

{ #category : #initialization }
SpAlgoritStage >> createConsole [

	^ self newMorph
		  morph: ScratchConsoleMorph new;
		  yourself
]

{ #category : #initialization }
SpAlgoritStage >> createGraphMorphPage [

	graphMorph := self newMorph
		              morph: self newGraphMorph;
		              yourself.
	^ SpNotebookPage
		  title: self graphLabel
		  icon: (self iconNamed: #morph)
		  provider: [ graphMorph ]
]

{ #category : #initialization }
SpAlgoritStage >> createHistoryPage [

	historyTable := self newTable.
	^ SpNotebookPage
		title: self historyLabel
		icon: (self iconNamed: #history)
		provider: [ historyTable ]
]

{ #category : #initialization }
SpAlgoritStage >> createListPage [

	listTable := self newTable.
	^ SpNotebookPage
		title: self listLabel
		icon: (self iconNamed: #morph)
		provider: [ listTable ]
]

{ #category : #initialization }
SpAlgoritStage >> createValuePage [

	varTable := self newTable.
	^ SpNotebookPage
		title: self valueLabel
		icon: (self iconNamed: #morph)
		provider: [ varTable ]
]

{ #category : #accessing }
SpAlgoritStage >> display [
	^ self stepper
]

{ #category : #constants }
SpAlgoritStage >> graphLabel [

	^ 'graph' localized
]

{ #category : #constants }
SpAlgoritStage >> historyLabel [

	^ 'history' localized
]

{ #category : #initialization }
SpAlgoritStage >> initializePresenter [

	stepperMorph := self newMorph morph: ScratchStepperMorph new yourself.
	self stepper stepTime: 1.
	toolBar := self newToolbar.
	messages := self createConsole.
	variables := self newNotebook
		             addPage: self createValuePage;
		             addPage: self createHistoryPage;
		             yourself.
	lists := self newNotebook
		         addPage: self createListPage;
		         addPage: self createGraphMorphPage;
		         yourself.
	self setupToolBar.
	self focusOrder
		add: toolBar;
		add: variables;
		add: lists
]

{ #category : #testing }
SpAlgoritStage >> isShowingHistory [

	variables selectedPage ifNil: [ ^ false ].
	^ variables selectedPage title = self historyLabel
]

{ #category : #constants }
SpAlgoritStage >> listLabel [

	^ 'list' localized
]

{ #category : #private }
SpAlgoritStage >> newGraphMorph [

	^ ListBarGraph new
		  stepTime: 200;
		  yourself
]

{ #category : #initialization }
SpAlgoritStage >> setupToolBar [

	toolBar
		addItem: (SpToolbarButtonPresenter new
				 label: 'Setup' localized;
				 icon: (ScratchTheme formAt: #setupButton);
				 action: [ whenSetupDo ifNotNil: [ whenSetupDo value ] ]);
		addItem: (SpToolbarButtonPresenter new
				 label: 'Start' localized;
				 icon: (ScratchTheme formAt: #goButton);
				 action: [ whenStartDo ifNotNil: [ whenStartDo value ] ]);
		addItem: (SpToolbarButtonPresenter new
				 label: 'Stop' localized;
				 icon: (ScratchTheme formAt: #stopButton);
				 action: [ whenStopDo ifNotNil: [ whenStopDo value ] ]);
		addItemRight: (SpToolbarButtonPresenter new
				 label: 'Clear' localized;
				 icon: (self iconNamed: #smallDelete);
				 action: [ whenClearDo ifNotNil: [ whenClearDo value ] ])
]

{ #category : #private }
SpAlgoritStage >> setupVarTableColumns: aCollection [

	historyTable
		columns: #(  );
		addColumn: (SpStringTableColumn
				 title: self variableLabel
				 evaluated: [ :x | x first ]).
	aCollection do: [ :each | 
		historyTable addColumn:
			(SpStringTableColumn title: each evaluated: [ :x | 
				 x second = each
					 ifTrue: [ x third asString ]
					 ifFalse: [ '' ] ]) ].
	varTable
		columns: #(  );
		addColumn: (SpStringTableColumn
				 title: self variableLabel
				 evaluated: [ :x | x first ]);
		addColumn: (SpStringTableColumn
				 title: self valueLabel
				 evaluated: [ :x | x second ])
]

{ #category : #private }
SpAlgoritStage >> startStepping [

	self stepper startStepping
]

{ #category : #accessing }
SpAlgoritStage >> stepper [
	^ stepperMorph morph
]

{ #category : #accessing }
SpAlgoritStage >> target: aScript [

	graphMorph morph script: aScript.
	self updateVarTable: aScript.
	self updateListTable: aScript
]

{ #category : #api }
SpAlgoritStage >> updateListTable: aScript [
	listTable
		columns: #();
		addColumn: (SpStringTableColumn title: self listLabel evaluated: [ :x | x first ]).
	aScript watchingLists sorted
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

{ #category : #api }
SpAlgoritStage >> updateLists: aScript [

	aScript ifNil: [ ^ self ].
	listTable items: aScript watchingListItems.
	graphMorph morph needsUpdate: true
]

{ #category : #api }
SpAlgoritStage >> updateVarTable: aScript [
	self setupVarTableColumns: aScript watchingVars sorted.
	self updateVars: aScript
]

{ #category : #api }
SpAlgoritStage >> updateVars: aScript [

	aScript ifNil: [ ^ self ].
	self isShowingHistory
		ifTrue: [ historyTable items: aScript watchingVarHistory ]
		ifFalse: [ varTable items: aScript watchingVarAndValues ]
]

{ #category : #constants }
SpAlgoritStage >> valueLabel [

	^ 'value' localized
]

{ #category : #constants }
SpAlgoritStage >> variableLabel [

	^ 'variable' localized
]

{ #category : #accessing }
SpAlgoritStage >> whenClearDo: aBlock [
	whenClearDo := aBlock
]

{ #category : #accessing }
SpAlgoritStage >> whenListsPageChangedDo: aBlock [

	lists whenSelectedPageChangedDo: aBlock
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

{ #category : #accessing }
SpAlgoritStage >> whenVariablesPageChangedDo: aBlock [

	variables whenSelectedPageChangedDo: aBlock
]
