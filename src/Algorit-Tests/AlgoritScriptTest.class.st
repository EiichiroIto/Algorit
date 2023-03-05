"
An AlgoritScriptTest is a test class for testing the behavior of AlgoritScript
"
Class {
	#name : #AlgoritScriptTest,
	#superclass : #TestCase,
	#category : #'Algorit-Tests'
}

{ #category : #private }
AlgoritScriptTest >> newScript [

	^ AlgoritScript new
]

{ #category : #test }
AlgoritScriptTest >> testAddList [

	| script |
	script := self newScript.
	self assert: script listVarNames isEmpty.
	script addList: 'abc'.
	self assert: script listVarNames size equals: 1.
	self assert: script listVarNames first equals: 'abc'
]

{ #category : #test }
AlgoritScriptTest >> testAddVariable [

	| script |
	script := self newScript.
	self assert: script varNames isEmpty.
	self assert: script watchingVars isEmpty.
	script addVariable: 'abc'.
	self assert: script varNames size equals: 1.
	self assert: script varNames first equals: 'abc'.
	self assert: script watchingVars size equals: 1.
	self assert: (script watchingVars includes: 'abc')
]

{ #category : #test }
AlgoritScriptTest >> testDeleteList [

	| script |
	script := self newScript.
	script addList: 'abc'.
	script addList: 'def'.
	self assert: script listVarNames size equals: 2.
	self assert: script listVarNames first equals: 'abc'.
	self assert: script listVarNames second equals: 'def'.
	script deleteList: 'abc'.
	self assert: script listVarNames size equals: 1.
	self assert: script listVarNames first equals: 'def'.
	script deleteList: 'def'.
	self assert: script listVarNames isEmpty
]

{ #category : #test }
AlgoritScriptTest >> testDeleteVariable [

	| script |
	script := self newScript.
	script addVariable: 'abc'.
	script addVariable: 'def'.
	self assert: script varNames size equals: 2.
	self assert: script varNames first equals: 'abc'.
	self assert: script varNames second equals: 'def'.
	self assert: script watchingVars size equals: 2.
	self assert: (script watchingVars includes: 'abc').
	self assert: (script watchingVars includes: 'def').
	script deleteVariable: 'abc'.
	self assert: script varNames size equals: 1.
	self assert: script varNames first equals: 'def'.
	self assert: script watchingVars size equals: 1.
	self assert: (script watchingVars includes: 'def').
	script deleteVariable: 'def'.
	self assert: script varNames isEmpty.
	self assert: script watchingVars isEmpty
]

{ #category : #test }
AlgoritScriptTest >> testEvaluator [

	| script obj |
	script := self newScript.
	obj := script evaluator.
	self assert: (obj isKindOf: AlgoritEvaluator)
]

{ #category : #test }
AlgoritScriptTest >> testInitialize [

	| script |
	script := self newScript.
	self assert: script varNames isEmpty.
	self assert: script listVarNames isEmpty.
	self assert: (script evaluator isKindOf: AlgoritEvaluator)
]

{ #category : #test }
AlgoritScriptTest >> testIsValidSubName [

	self assert: (self newScript isValidSubName: 'abc').
	self assert: (self newScript isValidSubName: '').
	self assert: (self newScript isValidSubName: 'abc def')
]

{ #category : #test }
AlgoritScriptTest >> testIsWatchingVar [

	| script |
	script := self newScript.
	self deny: (script isWatchingVar: 'abc').
	script addVariable: 'abc'.
	self assert: (script isWatchingVar: 'abc')
]

{ #category : #test }
AlgoritScriptTest >> testListPositionMenu [

	self assert: self newScript listPositionMenu isArray
]

{ #category : #test }
AlgoritScriptTest >> testListVarNames [

	| script |
	script := self newScript.
	script addList: 'a'.
	script addList: 'b'.
	self assertCollection: script listVarNames hasSameElements: #( a b )
]

{ #category : #test }
AlgoritScriptTest >> testListsModified [

	| script |
	script := self newScript.
	self assert: script listsModified.
	script listsModified: false.
	self deny: script listsModified.
	script listsModified: true.
	self assert: script listsModified
]

{ #category : #test }
AlgoritScriptTest >> testNewEvaluator [

	| script |
	script := self newScript.
	self assert: (script newEvaluator isKindOf: AlgoritEvaluator)
]

{ #category : #test }
AlgoritScriptTest >> testObjName [

	| script obj |
	script := self newScript.
	obj := script objName.
	self assert: obj equals: 'main'
]

{ #category : #test }
AlgoritScriptTest >> testStartHatBlockNames [

	| script r |
	script := self newScript.
	r := script startHatBlockNames.
	self assert: r isArray.
	self assert: r size equals: 2
]

{ #category : #test }
AlgoritScriptTest >> testVarNames [

	| script |
	script := self newScript.
	script addVariable: 'c'.
	script addVariable: 'a'.
	script addVariable: 'b'.
	self assertCollection: script varNames hasSameElements: #( a b c )
]

{ #category : #test }
AlgoritScriptTest >> testVariableNameInUse [

	| script |
	script := self newScript.
	self deny: (script variableNameInUse: 'abc').
	self deny: (script variableNameInUse: 'def').
	script addVariable: 'abc'.
	self assert: (script variableNameInUse: 'abc').
	self deny: (script variableNameInUse: 'def').
	script addList: 'def'.
	self assert: (script variableNameInUse: 'abc').
	self assert: (script variableNameInUse: 'def')
]

{ #category : #test }
AlgoritScriptTest >> testVarsModified [

	| script |
	script := self newScript.
	self assert: script varsModified.
	script varsModified: false.
	self deny: script varsModified.
	script varsModified: true.
	self assert: script varsModified
]

{ #category : #test }
AlgoritScriptTest >> testWatchingVars [

	self testAddVariable
]
