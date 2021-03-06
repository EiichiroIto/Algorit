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

{ #category : #specs }
SpAlgoritFrame class >> defaultSpec [
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
SpAlgoritFrame >> fileMenu [
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'New' localized;
						action: [ application newProject ] ];
				addItem: [ :item | 
					item
						name: 'Open' localized;
						action: [ application openProject ] ];
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
						action: [ application saveProject ] ] ];
		addItem: [ :item | 
			item
				name: 'Close' localized;
				action: [ application close ];
				enabled: [ application class dontClose not ] ];
		addItem: [ :item | 
			item
				name: 'Quit' localized;
				action: [ application quit ] ];
		yourself
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
	libraryPane := self instantiate: SpAlgoritLibrary.
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
				subMenu: self helpMenu ].
	menu applyTo: self
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
