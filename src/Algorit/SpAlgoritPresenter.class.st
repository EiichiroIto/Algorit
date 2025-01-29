Class {
	#name : 'SpAlgoritPresenter',
	#superclass : 'SpScratchPresenter',
	#instVars : [
		'buttonOpen',
		'buttonSave'
	],
	#category : 'Algorit-Spec2',
	#package : 'Algorit',
	#tag : 'Spec2'
}

{ #category : 'api' }
SpAlgoritPresenter >> clear [
	self target clear.
	stageFrame clearMessage
]

{ #category : 'initialization' }
SpAlgoritPresenter >> connectPresenters [

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

{ #category : 'private' }
SpAlgoritPresenter >> defaultExtent [
	^ 1024 @ 768
]

{ #category : 'layout' }
SpAlgoritPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: #logo withConstraints: [ :c | c width: 200 ];
				   add: #buttonOpen
				   withConstraints: [ :c | c width: self class iconWidth ];
				   add: #buttonSave
				   withConstraints: [ :c | c width: self class iconWidth ];
				   add: #menu;
				   yourself)
		  withConstraints: [ :c | c height: self class toolbarHeight ];
		  add: (SpBoxLayout newHorizontal
				   add: #viewerPane
				   withConstraints: [ :c | c width: self class viewerPaneWidth ];
				   add: (SpPanedLayout newHorizontal
						    add: (SpBoxLayout newVertical
								     add: (SpBoxLayout newHorizontal
										      add: #modifiedProjectLabel
										      withConstraints: [ :c | c expand: false ];
										      add: #projectNameLabel;
										      yourself)
								     withConstraints: [ :c | c expand: false ];
								     add: #editorPane;
								     yourself);
						    add: #stageFrame;
						    yourself);
				   yourself);
		  yourself
]

{ #category : 'private' }
SpAlgoritPresenter >> exportMenu [

	^ self newMenu
		  addItem: [ :item | 
			  item
				  name: 'Export S-EXP' localized;
				  action: [ application exportSexpCode ] ];
		  addItem: [ :item | 
			  item
				  name: 'Export Script image' localized;
				  action: [ application exportScriptImage ] ];
		  yourself
]

{ #category : 'private' }
SpAlgoritPresenter >> fileMenu [

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

{ #category : 'private' }
SpAlgoritPresenter >> importMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Import S-EXP' localized;
				action: [ application importSexpCode ] ];
		yourself
]

{ #category : 'initialization' }
SpAlgoritPresenter >> initializePresenters [

	super initializePresenters.
	buttonOpen := self newButton
		              icon: (Smalltalk ui iconNamed: #smallOpen);
		              help: 'Open Project' localized;
		              yourself.
	buttonSave := self newButton
		              icon: (Smalltalk ui iconNamed: #smallSave);
		              help: 'Save Project' localized;
		              yourself.
	self focusOrder add: editorPane
]

{ #category : 'initialization' }
SpAlgoritPresenter >> newStage [

	^ self instantiate: SpAlgoritStage
]

{ #category : 'accessing' }
SpAlgoritPresenter >> scriptForm [

	^ editorPane morph contents screenshot
]

{ #category : 'initialization' }
SpAlgoritPresenter >> setupMenu [
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

{ #category : 'private' }
SpAlgoritPresenter >> stageShotExtent: size [
	^ nil
]

{ #category : 'accessing' }
SpAlgoritPresenter >> target: aScript [

	viewerPane target: aScript.
	stageFrame target: aScript.
	editorPane morph contents: aScript blocksBin.
	editorPane morph contents color: ScratchTheme scriptsPaneColor
]

{ #category : 'api' }
SpAlgoritPresenter >> updateDisplay [
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

{ #category : 'api' }
SpAlgoritPresenter >> updateListTable: aScript [
	stageFrame updateListTable: aScript
]

{ #category : 'api' }
SpAlgoritPresenter >> updateVarTable: aScript [
	stageFrame updateVarTable: aScript
]

{ #category : 'stepping' }
SpAlgoritPresenter >> whenStepsDo: aBlock [
	stageFrame whenStepsDo: aBlock
]
