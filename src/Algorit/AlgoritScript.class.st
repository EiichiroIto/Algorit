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

	argMorphBuilder
		addBooleanArg: $b;
		addEventTitleArg: $e;
		addChoiceArg: $f
		options:
			#( 'abs' 'sqrt' 'sin' 'cos' 'tan' 'asin' 'acos' 'atan' 'ln' 'log'
			   'e ^' '10 ^' )
		initialChoice: 'sqrt';
		addLocalVarArg: $l;
		addChoiceArg: $L selector: #listVarNames;
		addSpriteArg: $m;
		addNumberExpressArg: $n initialExpression: '10';
		addChoiceArg: $S selector: #subNames;
		addStringExpressArg: $s;
		addChoiceArg: $v selector: #varNames;
		addNumberExpressArg: $p selector: #listPositionMenu target: nil initialExpression: '1'
]

{ #category : #'block specs' }
AlgoritScript >> addBlockSpecs [

	self
		addControlBlockSpecs;
		addOperatorBlockSpecs;
		addMiscBlockSpecs;
		addVariableBlockSpecs
]

{ #category : #'block specs' }
AlgoritScript >> addControlBlockSpecs [

	blockMorphBuilder
		addCategory: 'control';
		addHatBlock: 'when setup' type: #S arguments: #(  );
		addHatBlock: 'when start' type: #G arguments: #(  );
		addSeparator;
		addCBlock: 'if %b' selector: #doIf arguments: #(  );
		addCBlock: 'if %b' selector: #doIfElse arguments: #(  );
		addSeparator;
		addCBlock: 'forever' selector: #doForever arguments: #( 10 );
		addCBlock: 'repeat %n' selector: #doRepeat arguments: #( 10 );
		addCBlock: 'while %b' selector: #doWhile arguments: #(  );
		addCBlock: 'repeat until %b' selector: #doUntil arguments: #(  );
		addSeparator;
		addSpecial: 'call %S' selector: #callSubroutine arguments: #(  );
		addSpecial: 'return' selector: #doReturn arguments: #( );
		addSeparator;
		addTimed: 'wait %n secs' selector: #wait:elapsed:from: arguments: #( 1 );
		addSeparator;
		addSpecial: 'stop all' selector: #stopAll arguments: #(  )
]

{ #category : #variables }
AlgoritScript >> addList: aString [
	listVarNames add: aString.
	evaluator clearList: aString
]

{ #category : #'block specs' }
AlgoritScript >> addMiscBlockSpecs [

	blockMorphBuilder
		addCategory: 'misc';
		addCommand: 'print %s' selector: #print: arguments: #( 'hello,' );
		addCommand: 'print %s with newline' selector: #println: arguments: #( 'world' );
		addSeparator;
		addReporter: 'timer' selector: #now;
		addCommand: 'reset timer' selector: #resetTimer;
		addSeparator;
		addCommand: 'set random seed %n' selector: #setRandomSeed: arguments: #( 0 );
		addSpecial: 'assert %b' selector: #doAssert arguments: #(  )
]

{ #category : #'block specs' }
AlgoritScript >> addOperatorBlockSpecs [

	blockMorphBuilder
		addCategory: 'operators';
		addReporter: '%n + %n' selector: #plus:and: arguments: #( 1 2 );
		addReporter: '%n - %n' selector: #minus:with: arguments: #( 1 2 );
		addReporter: '%n * %n' selector: #multiply:and: arguments: #( 1 2 );
		addReporter: '%n / %n' selector: #divide:by: arguments: #( 1 2 );
		addReporter: '- %n' selector: #negated: arguments: #( 1 );
		addSeparator;
		addReporter: 'pick random %n to %n' selector: #randomFrom:to: arguments: #( 1 10 );
		addSeparator;
		addBooleanReporter: '%s < %s' selector: #less:than: arguments: #( '' '' );
		addBooleanReporter: '%s <= %s' selector: #lessEqual:than: arguments: #( '' '' );
		addBooleanReporter: '%s = %s' selector: #equal:to: arguments: #( '' '' );
		addBooleanReporter: '%s > %s' selector: #more:than: arguments: #( '' '' );
		addBooleanReporter: '%s >= %s' selector: #moreEqual:than: arguments: #( '' '' );
		addBooleanReporter: '%n between %n and %n' selector: #is:between:and: arguments: #( 50 0 100 );
		addSeparator;
		addBooleanReporter: '%b and %b' selector: #and:with: arguments: #( '' '' );
		addBooleanReporter: '%b or %b' selector: #or:with: arguments: #( '' '' );
		addBooleanReporter: 'not %b' selector: #not: arguments: #( '' '' );
		addSeparator;
		addBooleanReporter: 'true' selector: #getTrue;
		addBooleanReporter: 'false' selector: #getFalse;
		addSeparator;
		addReporter: '%n div %n' selector: #div:by: arguments: #( 7 3 );
		addReporter: '%n mod %n' selector: #mod:by: arguments: #( 7 3 );
		addReporter: 'round %n' selector: #rounded: arguments: #( 1.5 );
		addReporter: 'truncate %n' selector: #truncated: arguments: #( 1.5 );
		addSeparator;
		addReporter: '%f of %n' selector: #computeFunction:of: arguments: #( 'sqrt' 10 )
]

{ #category : #variables }
AlgoritScript >> addVariable: aString [

	varNames add: aString.
	evaluator
		setVar: aString to: 0;
		setWatchingVar: aString to: true
]

{ #category : #'block specs' }
AlgoritScript >> addVariableBlockSpecs [

	blockMorphBuilder
		addCategory: 'list';
		addCommand: 'add %n to %L' selector: #append:toList: arguments: #( 10 '' );
		addCommand: 'add %n to %n to %L' selector: #appendFrom:to:toList: arguments: #( 10 99 '' );
		addCommand: 'add %n randoms from %n to %n to %L' selector: #appendRandom:from:to:toList: arguments: #( 20 10 99 '' );
		addCommand: 'delete %p of %L' selector: #deleteLine:ofList: arguments: #( 1 '' );
		addCommand: 'replace item %p of %L with %n' selector: #setLine:ofList:to: arguments: #( 1 '' 10 );
		addCommand: 'swap items %p and %p of %L' selector: #swapLine:and:ofList: arguments: #( 1 2 '' );
		addCommand: 'clear list %L' selector: #clearList: arguments: #( '' );
		addSeparator;
		addReporter: 'item %p of %L' selector: #getLine:ofList: arguments: #( 1 '' );
		addReporter: 'length of %L' selector: #lineCountOfList: arguments: #( '' );
		addBooleanReporter: '%L contains %n' selector: #list:contains: arguments: #( '' 10 );
		addSeparator;
		addCommand: 'shuffle %L' selector: #shuffleList: arguments: #( '' );
		addCommand: 'sort %L' selector: #sortList: arguments: #( '' );
		addCommand: 'reverse %L' selector: #reverseList: arguments: #( '' )
]

{ #category : #api }
AlgoritScript >> clear [
	evaluator clear
]

{ #category : #variables }
AlgoritScript >> deleteList: aString [
	listVarNames remove: aString ifAbsent: [  ].
	evaluator deleteList: aString
]

{ #category : #variables }
AlgoritScript >> deleteVariable: aString [
	varNames remove: aString ifAbsent: [  ].
	evaluator deleteVariable: aString
]

{ #category : #evaluation }
AlgoritScript >> evaluateFunction: aSymbol withArgs: anArgs [

	(#( stopThread stopAll return: returnValue ) includes: aSymbol) 
		ifTrue: [ self perform: aSymbol withArguments: anArgs ].
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

	blockMorphBuilder
		setCategory: 'control' color: (Color h: 41 s: 0.85 v: 0.9);
		setCategory: 'operators' color: (Color h: 93 s: 0.9 v: 0.76);
		setCategory: 'misc' color: (Color h: 200 s: 0.98 v: 0.86);
		setCategory: 'variables' color: ScratchTheme variableBlockColor;
		setCategory: 'list' color: ScratchTheme listBlockColor
]

{ #category : #processes }
AlgoritScript >> stopAllProcesses [
	blocksBin isArray
		ifTrue: [ ^ self ].
	blocksBin
		submorphsDo: [ :each | 
			each isBlockMorph
				ifTrue: [ each clearProcess.
					each litUp: false.
					each
						allMorphsDo: [ :each2 | 
							each2 isBlockMorph
								ifTrue: [ each2 updateCachedForm ] ] ] ]
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
