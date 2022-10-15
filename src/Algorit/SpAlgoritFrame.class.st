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
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: #logo withConstraints: [ :c | c width: 200 ];
				   add: #buttonOpen
				   withConstraints: [ :c | c width: self iconWidth ];
				   add: #buttonSave
				   withConstraints: [ :c | c width: self iconWidth ];
				   add: #menu;
				   yourself)
		  withConstraints: [ :c | c height: self toolbarHeight ];
		  add: (SpBoxLayout newHorizontal
				   add: #viewerPane
				   withConstraints: [ :c | c width: self viewerPaneWidth ];
				   add: (SpPanedLayout newHorizontal
						    add: (SpBoxLayout newVertical
								     add: #titlePane
								     withConstraints: [ :c | c height: self titleButtonHeight ];
								     add: #editorPane;
								     yourself);
						    add: #stageFrame;
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
		whenClearDo: [ 
			self clear.
			self updateDisplay ];
		whenStopDo: [ application stopAllProcesses ];
		whenStartDo: [ application doStart ];
		whenSetupDo: [ application doSetup ];
		whenVariablesPageChangedDo: [ stageFrame updateVars: self target ];
		whenListsPageChangedDo: [ stageFrame updateLists: self target ]
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
					enabled: [ self settings dontClose not ] ];
			addItem: [ :item | 
				item
					name: 'Quit' localized;
					action: [ application class quit ] ] ].
	^ m
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
	editorPane := self newMorph.
	editorPane morph: (ScrollFrameMorph new
			 growthFraction: 0.1;
			 color: ScratchTheme scriptsPaneColor).
	titlePane := self newLabel
		             label: 'new project';
		             yourself.
	stageFrame := self instantiate: SpAlgoritStage.
	self focusOrder add: editorPane
]

{ #category : #accessing }
SpAlgoritFrame >> projectName [

	^ titlePane label
]

{ #category : #accessing }
SpAlgoritFrame >> projectName: aString [

	titlePane label: aString
]

{ #category : #accessing }
SpAlgoritFrame >> scriptForm [

	^ editorPane morph contents screenshot
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

{ #category : #accessing }
SpAlgoritFrame >> target: aScript [

	viewerPane target: aScript.
	stageFrame target: aScript.
	editorPane morph contents: aScript blocksBin.
	editorPane morph contents color: ScratchTheme scriptsPaneColor
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

{ #category : #stepping }
SpAlgoritFrame >> whenStepsDo: aBlock [
	stageFrame whenStepsDo: aBlock
]
