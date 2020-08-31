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
		'whenStartDo',
		'whenStopDo',
		'showHistory',
		'whenHistoryDo'
	],
	#category : #'Algorit-Spec2'
}

{ #category : #specs }
SpAlgoritStage class >> defaultSpec [
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
	aString isEmpty
		ifTrue: [ ^ self ].
	messages text: messages text , aString.
	self showLastMessage
]

{ #category : #accessing }
SpAlgoritStage >> clearMessage [
	messages text: ''.
	self showLastMessage
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
	toolBar := self newToolBar.
	varTable := self newTable.
	listTable := self newTable.
	messages := self newCode
		withoutSyntaxHighlight;
		yourself.
	messages := self newText.
	self setupToolBar.
	self focusOrder
		add: toolBar;
		add: varTable;
		add: listTable
]

{ #category : #accessing }
SpAlgoritStage >> messages [
	^ messages text asString
]

{ #category : #initialization }
SpAlgoritStage >> setupToolBar [
	toolBar
		addItem:
			(SpToolBarButton new
				label: 'Start' localized;
				icon: (ScratchTheme formAt: #goButton);
				action: [ whenStartDo ifNotNil: [ whenStartDo value ] ]);
		addItem:
			(SpToolBarButton new
				label: 'Stop' localized;
				icon: (ScratchTheme formAt: #stopButton);
				action: [ whenStopDo ifNotNil: [ whenStopDo value ] ]);
		addItemRight:
			(SpToolBarButton new
				label: 'Clear' localized;
				icon: (Smalltalk ui iconNamed: #smallDelete);
				action: [ whenClearDo ifNotNil: [ whenClearDo value ] ]);
		addItemRight:
			(SpToolBarButton new
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

{ #category : #private }
SpAlgoritStage >> showLastMessage [
	messages textArea moveCursorToIndex: messages text size
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
