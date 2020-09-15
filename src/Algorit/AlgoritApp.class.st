Class {
	#name : #AlgoritApp,
	#superclass : #SpScratchApp,
	#instVars : [
		'runningBlocks',
		'inProcessStep'
	],
	#category : #'Algorit-Spec2'
}

{ #category : #accessing }
AlgoritApp class >> appFolderName [
	^ 'algorit'
]

{ #category : #accessing }
AlgoritApp class >> appName [
	^ 'Algorit'
]

{ #category : #accessing }
AlgoritApp class >> extension [
	^ 'al'
]

{ #category : #'class initialization' }
AlgoritApp class >> initialize [
	"self initialize"
	ScratchDirectory current appName: self appFolderName.
	ScratchTheme
		themesURL: self themesURL;
		setupThemeNamed: self appFolderName
]

{ #category : #'world menu' }
AlgoritApp class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self appName asSymbol)
		order: 0.5;
		target: self;
		action: [self new open]; 
		icon: self icon
]

{ #category : #'as yet unclassified' }
AlgoritApp class >> recodingExtent [
	^ 400 @ 400
]

{ #category : #accessing }
AlgoritApp class >> themesURL [
	^ 'https://raw.githubusercontent.com/EiichiroIto/Algorit/master/Themes.zip'
]

{ #category : #private }
AlgoritApp >> aboutAppString [
	^ self appName
		,
			'
Copyright © 2020 Eiichiro Ito (ghc02331@nifty.com)
All rights reserved.

Based on Scratch from the MIT Media Lab, v' , self basedVersion
		,
			'
Copyright © 2009 Massachusetts Institute of Technology.
All rights reserved.
'
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
AlgoritApp >> createProject [
	^ AlgoritProject new
]

{ #category : #'menu actions' }
AlgoritApp >> doSetup [
	| block |
	self stopAllProcesses.
	block := self setupHatBlock.
	block
		ifNil:
			[ ^ UIManager default alert: 'Only one setup block needed!' localized ].
	self startProcessFor: block
]

{ #category : #'menu actions' }
AlgoritApp >> doStart [
	| block |
	self stopAllProcesses.
	block := self startHatBlock.
	block
		ifNil:
			[ ^ UIManager default alert: 'Only one start block needed!' localized ].
	self startProcessFor: block
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
	self setupView.
	Smalltalk garbageCollect.
	project modified: false.
	"project needBuild: true."
	presenter updateDisplay
]

{ #category : #private }
AlgoritApp >> mainScriptName [
	^ 'main'
]

{ #category : #private }
AlgoritApp >> newPresenter [
	^ SpAlgoritFrame basicNew
		application: self;
		initialize;
		whenStepsDo: [ self stepProcesses ];
		yourself
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
AlgoritApp >> setupHatBlock [
	| list |
	list := self target hatBlocks
		select:
			[ :each | (each isKindOf: EventHatMorph) and: [ each eventName = #setup ] ].
	list size = 1
		ifTrue: [ ^ list first ].
	^ nil
]

{ #category : #private }
AlgoritApp >> startHatBlock [
	| list |
	list := self target hatBlocks
		select:
			[ :each | (each isKindOf: EventHatMorph) and: [ each eventName = #start ] ].
	list size = 1
		ifTrue: [ ^ list first ].
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
		onFailure: [ proc errorFlag: true ].
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

{ #category : #accessing }
AlgoritApp >> updateVars [
	presenter updateVars: self target
]
