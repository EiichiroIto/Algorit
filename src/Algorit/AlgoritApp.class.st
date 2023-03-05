Class {
	#name : #AlgoritApp,
	#superclass : #SpScratchApp,
	#instVars : [
		'runningBlocks',
		'inProcessStep'
	],
	#category : #'Algorit-Spec2'
}

{ #category : #private }
AlgoritApp class >> aboutAppString [

	^ self appName , ' v' , self appVersion , '
Copyright © 2020 Eiichiro Ito (ghc02331@nifty.com)
All rights reserved.

Based on Scratch from the MIT Media Lab, v' , self basedVersion , '
Copyright © 2009 Massachusetts Institute of Technology.
All rights reserved.
'
]

{ #category : #constants }
AlgoritApp class >> appFolderName [
	^ 'algorit'
]

{ #category : #constants }
AlgoritApp class >> appName [
	^ 'Algorit'
]

{ #category : #constants }
AlgoritApp class >> appVersion [
	^ '1.2.5'
]

{ #category : #constants }
AlgoritApp class >> extension [
	^ 'al'
]

{ #category : #'class initialization' }
AlgoritApp class >> initialize [
	"self initialize"
	ScratchTheme
		themesURL: self themesURL;
		setupThemeNamed: self appFolderName.
	ObjStream setupVariables "for test"
]

{ #category : #'world menu' }
AlgoritApp class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self appName asSymbol)
		order: 0.5;
		target: self;
		action: [self open]; 
		icon: self icon
]

{ #category : #constants }
AlgoritApp class >> presentationClass [
	^ SpAlgoritPresenter
]

{ #category : #constants }
AlgoritApp class >> projectClass [
	^ AlgoritProject
]

{ #category : #accessing }
AlgoritApp class >> recodingExtent [
	^ 400 @ 400
]

{ #category : #constants }
AlgoritApp class >> themesURL [
	^ 'https://raw.githubusercontent.com/EiichiroIto/Algorit/master/misc/Themes.zip'
]

{ #category : #'button actions' }
AlgoritApp >> addList: aScript [
	super addList: aScript.
	presenter updateListTable: aScript
]

{ #category : #'button actions' }
AlgoritApp >> addVariable: aScript [
	super addVariable: aScript.
	presenter updateVarTable: aScript
]

{ #category : #private }
AlgoritApp >> checkVarHistory [

	| ret |
	project countVarHistory < 100 ifTrue: [ ^ true ].
	ret := presenter confirm:
		       'Variable history is too large. Clear it before saving?'
			       localized.
	ret ifTrue: [ project clearVarHistory ].
	^ true
]

{ #category : #'button actions' }
AlgoritApp >> deleteList: aScript [
	super deleteList: aScript.
	presenter updateListTable: aScript
]

{ #category : #'button actions' }
AlgoritApp >> deleteVariable: aScript [
	super deleteVariable: aScript.
	presenter updateVarTable: aScript
]

{ #category : #'menu actions' }
AlgoritApp >> doSetup [

	| block |
	self stopAllProcesses.
	self fixUnsavedFields.
	block := self setupHatBlock.
	block ifNil: [ 
		^ presenter alert: 'Only one setup block needed!' localized ].
	project clearVarHistory.
	self startProcessFor: block
]

{ #category : #'menu actions' }
AlgoritApp >> doStart [

	| block |
	self stopAllProcesses.
	self fixUnsavedFields.
	block := self startHatBlock.
	block ifNil: [ 
		^ presenter alert: 'Only one start block needed!' localized ].
	self startProcessFor: block
]

{ #category : #'menu actions' }
AlgoritApp >> exportSexpCode [
	self export: (ScratchSexpExporter appName: self appName) extension: self sexpExtension isBinary: false
]

{ #category : #'menu actions' }
AlgoritApp >> importSexpCode [

	| script |
	self
		import: (ScratchSexpImporter appName: self appName)
		extension: self sexpExtension
		isBinary: false.
	script := presenter target.
	presenter
		updateListTable: script;
		updateVarTable: script
]

{ #category : #initialization }
AlgoritApp >> initialize [
	super initialize.
	runningBlocks := OrderedCollection new.
	inProcessStep := false
]

{ #category : #private }
AlgoritApp >> installNewProject: aProject [
	self stopAllProcesses.
	"presenter knWorld: self newWorld."
	project := aProject.
	project application: self.
	project setupScripts.
	project setupBlockSpecs.
	self setupView.
	presenter clear.
	Smalltalk garbageCollect.
	project modified: false.
	"project needBuild: true."
	presenter updateDisplay
]

{ #category : #processes }
AlgoritApp >> isProcessRunning [
	^ runningBlocks notEmpty
]

{ #category : #processes }
AlgoritApp >> processesToRun [
	"Answer a collection of processes to run. Filter out any processes for objects have been picked up. Always return a copy of the processes list."

	| result |
	result := runningBlocks collect: #scratchProc.
	result := result select: #notNil.
	^ result
]

{ #category : #processes }
AlgoritApp >> removeTerminatedProcesses [
	"Remove terminated processes from the process list."

	| newRunning proc |
	newRunning := runningBlocks species new: 100.
	runningBlocks
		do: [ :b | 
			(proc := b scratchProc)
				ifNotNil: [ proc isRunning
						ifTrue: [ newRunning addLast: b ]
						ifFalse: [ proc errorFlag
								ifFalse: [ b stop ] ] ] ].
	runningBlocks := newRunning
]

{ #category : #private }
AlgoritApp >> restoreProject [
	"self subclassResponsibility"
]

{ #category : #'menu actions' }
AlgoritApp >> saveProject [
	self checkVarHistory ifFalse: [ ^ false ].
	^ super saveProject
]

{ #category : #'menu actions' }
AlgoritApp >> saveProjectNoDialog [
	self checkVarHistory ifFalse: [ ^ false ].
	^ super saveProjectNoDialog
]

{ #category : #private }
AlgoritApp >> setupHatBlock [

	| list |
	list := self target startHatBlocks select: [ :each | 
		        each selector = #setup ].
	list size = 1 ifTrue: [ ^ list first ].
	^ nil
]

{ #category : #private }
AlgoritApp >> sexpExtension [
	^ 'als'
]

{ #category : #private }
AlgoritApp >> startHatBlock [

	| list |
	list := self target startHatBlocks select: [ :each | 
		        each selector = #start ].
	list size = 1 ifTrue: [ ^ list first ].
	^ nil
]

{ #category : #processes }
AlgoritApp >> startProcessFor: topBlock [
	"Start a process to run the given block or stack of blocks. Return the  
	new process."

	| sequence proc |
	sequence := topBlock blockSequence.
	sequence first isHatBlock
		ifTrue: [ sequence := sequence allButFirst ].
	topBlock scratchProc ifNotNil: [ topBlock stop ].
	proc := ScratchStackProcess new.
	proc
		topBlock: topBlock;
		expression: sequence.
	topBlock scratchProc: proc.
	(runningBlocks includes: topBlock)
		ifFalse: [ runningBlocks addLast: topBlock ].
	^ proc
]

{ #category : #processes }
AlgoritApp >> stepProcesses [
	"Run each Scratch process until it gives up control, then filter out any processes that have terminated."

	"Details: Iterate over a copy of processes to allow processes to stop themselves. During development, the error catcher makes it difficult to track down errors, so it can be disabled."

	| proc |
	presenter updateDisplay.
	"self isRecording ifTrue: [ recorder writeForced: false ]."
	inProcessStep
		ifTrue: [ ^ self ].
	inProcessStep := true.
	proc := nil.
	self class
		try: [ self processesToRun do: [ :p | (proc := p) runStepFor: self ] ]
		onFailure: [ proc errorFlag: true.
			proc topBlock 	updateCachedForm.
			runningBlocks := OrderedCollection new ].
	self removeTerminatedProcesses.
	inProcessStep := false
]

{ #category : #processes }
AlgoritApp >> stopAllProcesses [
	"Stop all running Scratch processes."

	project ifNotNil: [ project stopAllProcesses ].
	runningBlocks := OrderedCollection new.
	inProcessStep := false
]

{ #category : #accessing }
AlgoritApp >> updateVarTable: aScript [
	presenter updateVarTable: aScript
]
