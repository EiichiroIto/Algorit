Class {
	#name : #SpAlgoritFrame,
	#superclass : #SpScratchFrame,
	#instVars : [
		'logo',
		'buttonOpen',
		'buttonSave',
		'menu'
	],
	#category : #'Algorit-Spec2'
}

{ #category : #layout }
SpAlgoritFrame class >> defaultLayout [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #logo withConstraints: [ :c | c width: 200 ];
				add: #buttonOpen
					withConstraints: [ :c | c width: self iconWidth ];
				add: #buttonSave
					withConstraints: [ :c | c width: self iconWidth ];
				add: #menu;
				yourself)
			withConstraints: [ :c | c height: self toolbarHeight ];
		add:
			(SpBoxLayout newHorizontal
				add: #viewerPane
					withConstraints: [ :c | c width: self viewerPaneWidth ];
				add:
					(SpPanedLayout newHorizontal
						add: #editorPane;
						add:
							(SpBoxLayout newVertical
								add: #titlePane
									withConstraints: [ :c | c height: self titleButtonHeight ];
								add: #stageFrame;
								yourself);
						yourself);
				yourself);
		yourself
]

{ #category : #accessing }
SpAlgoritFrame >> clear [
	self target clear.
	stageFrame clearMessage
]

{ #category : #initialization }
SpAlgoritFrame >> connectPresenters [
	buttonOpen action: [ application openProject ].
	buttonSave action: [ application saveProject ].
	stageFrame
		whenClearDo: [ self clear.
			self updateDisplay ];
		whenStopDo: [ self application stopAllProcesses ];
		whenStartDo: [ self application doStart ];
		whenSetupDo: [ self application doSetup ];
		whenHistoryDo: [ self updateVarTable: self target ]
]

{ #category : #private }
SpAlgoritFrame >> defaultExtent [
	^ 1024 @ 768
]

{ #category : #private }
SpAlgoritFrame >> exportMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Export S-EXP' localized;
				action: [ application exportSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Export Script image' localized;
				action: [ application saveScriptsToImage ] ];
		yourself
]

{ #category : #private }
SpAlgoritFrame >> fileMenu [

	| m |
	m := self newMenu.
	m
		addItem: [ :item | 
			item
				name: 'New' localized;
				action: [ application newProject ] ];
		addItem: [ :item | 
			item
				name: 'Open' localized;
				action: [ application openProject ] ].
	application examplesDirectory isDirectory ifTrue: [ 
		m addItem: [ :item | 
			item
				name: 'Examples' localized;
				subMenu: self examplesMenu ] ].
	m addGroup: [ :grp | 
		grp
			addItem: [ :item | 
				item
					name: 'Project Notes' localized;
					action: [ application editNotes ] ];
			addItem: [ :item | 
				item
					name: 'Save' localized;
					action: [ application saveProjectNoDialog ] ];
			addItem: [ :item | 
				item
					name: 'Save As' localized;
					action: [ application saveProject ] ] ].
	m addGroup: [ :grp | 
		grp
			addItem: [ :item | 
				item
					name: 'Import ...' localized;
					subMenu: self importMenu ];
			addItem: [ :item | 
				item
					name: 'Export ...' localized;
					subMenu: self exportMenu ] ].
	m addGroup: [ :grp | 
		grp
			addItem: [ :item | 
				item
					name: 'Close' localized;
					action: [ application closeAllWindows ];
					enabled: [ application class dontClose not ] ];
			addItem: [ :item | 
				item
					name: 'Quit' localized;
					action: [ application quit ] ] ].
	^ m
]

{ #category : #private }
SpAlgoritFrame >> helpMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: ('About ' , application appName) localized;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			item
				name: 'Restart' localized;
				action: [ self stepper startStepping ] ];
		addItem: [ :item | 
			item
				name: 'Inspect' localized;
				action: [ application inspect ] ];
		addItem: [ :item | 
			item
				name: 'Settings' localized;
				subMenu: self settingsMenu ];
		yourself
]

{ #category : #private }
SpAlgoritFrame >> importMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Import S-EXP' localized;
				action: [ application importSexpCode ] ];
		yourself
]

{ #category : #initialization }
SpAlgoritFrame >> initializePresenters [
	logo := self newImage
		image: (ScratchTheme formAt: #logo);
		yourself.
	buttonOpen := self newButton
		icon: (Smalltalk ui iconNamed: #smallOpen);
		help: 'Open Project' localized;
		yourself.
	buttonSave := self newButton
		icon: (Smalltalk ui iconNamed: #smallSave);
		help: 'Save Project' localized;
		yourself.
	menu := self newMenuBar.
	self setupMenu.
	viewerPane := self instantiate: SpScratchListViewer.
	editorPane := self instantiate: SpScratchEditor.
	titlePane := self instantiate: SpScratchTitle.
	stageFrame := self instantiate: SpAlgoritStage.
	self focusOrder add: editorPane
]

{ #category : #initialization }
SpAlgoritFrame >> setupMenu [
	menu
		addItem: [ :item | 
			item
				name: 'File' localized;
				subMenu: self fileMenu ];
		addItem: [ :item | 
			item
				name: 'Help' localized;
				subMenu: self helpMenu ]
]

{ #category : #private }
SpAlgoritFrame >> stageShotExtent: size [
	^ nil
]

{ #category : #private }
SpAlgoritFrame >> stepper [
	^ stageFrame stepper
]

{ #category : #accessing }
SpAlgoritFrame >> target: aScript [
	super target: aScript.
	self updateVarTable: aScript.
	self updateListTable: aScript
]

{ #category : #accessing }
SpAlgoritFrame >> updateDisplay [
	self target
		in: [ :t | 
			t varsModified
				ifTrue: [ t varsModified: false.
					stageFrame updateVars: t ].
			t listsModified
				ifTrue: [ t listsModified: false.
					stageFrame updateLists: t ].
			t messages ifNotEmpty: [ :str | stageFrame addMessage: str ] ]
]

{ #category : #accessing }
SpAlgoritFrame >> updateListTable: aScript [
	stageFrame updateListTable: aScript
]

{ #category : #accessing }
SpAlgoritFrame >> updateVarTable: aScript [
	stageFrame updateVarTable: aScript
]

{ #category : #accessing }
SpAlgoritFrame >> updateVars: anAlgoritScript [ 
	stageFrame updateVars: anAlgoritScript 
]

{ #category : #stepping }
SpAlgoritFrame >> whenStepsDo: aBlock [
	stageFrame whenStepsDo: aBlock
]
