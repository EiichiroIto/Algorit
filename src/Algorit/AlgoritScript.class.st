Class {
	#name : #AlgoritScript,
	#superclass : #ScratchScript,
	#instVars : [
		'varNames',
		'listVarNames',
		'evaluator',
		'objName'
	],
	#category : #'Algorit-Project'
}

{ #category : #'ston-core' }
AlgoritScript class >> stonAllInstVarNames [
	^ super stonAllInstVarNames , #(objName varNames listVarNames evaluator)
]

{ #category : #'argument menus' }
AlgoritScript >> addArgBuilder [
	super addArgBuilder.
	argBuilder
		addNumberExpressArg: $p
		selector: #listPositionMenu
		target: nil
		initialExpression: '1'
]

{ #category : #variables }
AlgoritScript >> addList: aString [
	listVarNames add: aString.
	evaluator clearList: aString
]

{ #category : #variables }
AlgoritScript >> addVariable: aString [
	varNames add: aString.
	evaluator setVar: aString to: 0
]

{ #category : #'misc ops' }
AlgoritScript >> asserting: anObject [
	anObject ifTrue: [ ^ self ].
	self stopAll.
	self error
]

{ #category : #'block specs' }
AlgoritScript >> blocks [
	"Answer a collection of block specifications for the blocks that are common to all objects. Block specificatons (Arrays) are interspersed with category names (Strings). A block specification is an Array of the form: (<block spec string> <block type> <selector> [optional initial argument values]).

	Explanation of flags:
		-	no flags
		b	boolean reporter
		c	c-shaped block containing a sequence of commands (always special form)
		r	reporter
		s	special form command with its own evaluation rule
		t	timed command, like wait or glide
		E	message event hat
		K	key event hat
		M	mouse-click event hat
		S	start event hat
		W	when <condition> hat (obsolete)"

	| blocks |
	blocks := #(
		'control'
			('when setup'							S	-)
			('when start'							G	-)
			-
			('if %b'									c	doIf)
			('if %b'									c	doIfElse)
			-
			('forever'								c	doForever)
			('repeat %n'							c	doRepeat 10)
			('while %b'								c	doWhile)
			('repeat until %b'					c	doUntil)
			-
			('call %S'								s	callSubroutine '')
			('return'									s	doReturn)
			-
			('wait %n secs'						t	wait:elapsed:from: 1)
			-
			('stop all'								-	stopAll)
		'operators'
			('%n + %n'								r	+ - -)
			('%n - %n'								r	- - -)
			('%n * %n'								r	* - -)
			('%n / %n'								r	/ - -)
			('- %n'										r	negated: 1)
			-
			('pick random %n to %n'			r	randomFrom:to: 1 10)
			-
			('%s < %s'								b	< '' '')
			('%s = %s'								b	= '' '')
			('%s > %s'								b	> '' '')
			('%n between %n and %n'			b is:between:and: 50 0 100)
			-
			('%b and %b'							b	&)
			('%b or %b'								b	|)
			('not %b'									b	not:)
			-
			('true'										b 	getTrue)
			('false'									b 	getFalse)
			-
			('%n mod %n'							r	\\ - -)
			('round %n'								r	rounded: -)
			('truncate %n'							r	truncated: -)
			-
			('%f of %n'								r	computeFunction:of: 'sqrt' 10)
		'misc'
			('print %s'								-	print: 'hello,')
			('print %s with newline'		-	println: 'world')
			-
			('assert %b'							-	#asserting:)
	).

	^ blocks, self variablesBlocks
]

{ #category : #accessing }
AlgoritScript >> clear [
	evaluator clear
]

{ #category : #variables }
AlgoritScript >> deleteList: aString [
	listVarNames remove: aString ifAbsent: [  ]
]

{ #category : #variables }
AlgoritScript >> deleteVariable: aString [
	varNames remove: aString ifAbsent: [  ].
	evaluator deleteVariable: aString
]

{ #category : #evaluation }
AlgoritScript >> evaluateFunction: aSymbol withArgs: anArgs [
	(#(stopThread stopAll return: #asserting: returnValue) includes: aSymbol)
		ifTrue: [ ^ self perform: aSymbol withArguments: anArgs ].
	^ self evaluator perform: aSymbol withArguments: anArgs
]

{ #category : #accessing }
AlgoritScript >> evaluator [
	^ evaluator
]

{ #category : #initialization }
AlgoritScript >> initialize [
	super initialize.
	varNames := OrderedCollection new.
	listVarNames := OrderedCollection new.
	evaluator := self newEvaluator
		yourself
]

{ #category : #testing }
AlgoritScript >> isValidSubName: aString [ 
	^ true
]

{ #category : #testing }
AlgoritScript >> isWatchingVar: aString [
	^ evaluator isWatchingVar: aString
]

{ #category : #'argument menus' }
AlgoritScript >> listPositionMenu [
	^ #((1 1) ('last' -1))
]

{ #category : #'argument menus' }
AlgoritScript >> listVarNames [
	^ listVarNames
]

{ #category : #accessing }
AlgoritScript >> listsModified [
	^ evaluator listsModified
]

{ #category : #accessing }
AlgoritScript >> listsModified: aBoolean [
	evaluator listsModified: aBoolean
]

{ #category : #accessing }
AlgoritScript >> messages [
	| msg |
	msg := evaluator messages.
	evaluator messages: ''.
	^ msg
]

{ #category : #private }
AlgoritScript >> newEvaluator [
	^ AlgoritEvaluator new
]

{ #category : #accessing }
AlgoritScript >> objName [
	^ objName
]

{ #category : #accessing }
AlgoritScript >> objName: aString [
	objName := aString
]

{ #category : #'block specs' }
AlgoritScript >> setupBlockCategory [
	blockDef
		addCategory: 'control' color: (Color h: 41 s: 0.85 v: 0.9);
		addCategory: 'operators' color: (Color h: 93 s: 0.9 v: 0.76);
		addCategory: 'misc' color: (Color h: 200 s: 0.98 v: 0.86);
		addCategory: 'variables' color: ScratchTheme variableBlockColor;
		addCategory: 'list' color: ScratchTheme listBlockColor
]

{ #category : #'control ops' }
AlgoritScript >> stopAll [
	project stopAll
]

{ #category : #processes }
AlgoritScript >> stopAllProcesses [
	blocksBin isArray
		ifTrue: [ ^ self ].
	blocksBin
		submorphsDo: [ :each | 
			each isBlockMorph
				ifTrue: [ each clearProcess.
					each litUp: false ] ]
]

{ #category : #accessing }
AlgoritScript >> toggleWatcher: aToggleButton for: aVariableBlockMorph [
	| v |
	v := aVariableBlockMorph variable.
	evaluator toggleWatchingVar: v.
	self updateWatcher: aToggleButton for: aVariableBlockMorph.
	self project updateVarTable: self
]

{ #category : #accessing }
AlgoritScript >> updateWatcher: aToggleButton for: aBlockMorph [
	| v |
	v := aBlockMorph variable.
	(evaluator isWatchingVar: v)
		ifTrue: [ aToggleButton on ]
		ifFalse: [ aToggleButton off ]
]

{ #category : #'argument menus' }
AlgoritScript >> varNames [
	^ varNames sorted
]

{ #category : #variables }
AlgoritScript >> variableNameInUse: aString [
	^ (varNames includes: aString) or: [ listVarNames includes: aString ]
]

{ #category : #'block specs' }
AlgoritScript >> variablesBlocks [
	^ #(
		'list'
			('add %n to %L'									-	append:toList: 10 '')
			('add %n to %n to %L'							-	appendFrom:to:toList: 10 99 '')
			('delete %p of %L'								-	deleteLine:ofList: 1 '')
			('replace item %p of %L with %n'		-	setLine:ofList:to: 1 '' 10)
			('swap items %p and %p of %L'			-	swapLine:and:ofList: 1 2 '')
			('clear list %L'									-	clearList: '')
			-
			('item %p of %L'									r	getLine:ofList: 1 '')
			('length of %L'									r	lineCountOfList: '')
			('%L contains %n'								b	list:contains: '' 10)
			-
			('shuffle %L'										- shuffleList: '')
			('sort %L'											- sortList: '')
	)
]

{ #category : #accessing }
AlgoritScript >> varsModified [
	^ evaluator varsModified
]

{ #category : #accessing }
AlgoritScript >> varsModified: aBoolean [
	evaluator varsModified: aBoolean
]

{ #category : #processes }
AlgoritScript >> wait: duration elapsed: elapsed from: ignored [
	"Do nothing; just wait for the time interval to elapse."

	^ nil
]

{ #category : #accessing }
AlgoritScript >> watchingListItems [
	| list n |
	list := self watchingLists sorted
		collect: [ :each | evaluator lists at: each ifAbsent: [ #() ] ].
	list isEmpty
		ifTrue: [ ^ #() ].
	n := (list collect: #size) max.
	^ (1 to: n)
		collect: [ :each | 
			{each}
				,
					(list
						collect: [ :l | 
							each > l size
								ifTrue: [ nil ]
								ifFalse: [ l at: each ] ]) ]
]

{ #category : #accessing }
AlgoritScript >> watchingLists [
	^ listVarNames
]

{ #category : #accessing }
AlgoritScript >> watchingVarAndValues [
	^ evaluator watchingVarAndValues
]

{ #category : #accessing }
AlgoritScript >> watchingVarHistory [
	^ evaluator watchingVarHistory
]

{ #category : #accessing }
AlgoritScript >> watchingVars [
	^ evaluator watchingVars
]
