"
An AlgoritEvaluatorTest is a test class for testing the behavior of AlgoritEvaluator
"
Class {
	#name : #AlgoritEvaluatorTest,
	#superclass : #TestCase,
	#category : #'Algorit-Tests'
}

{ #category : #private }
AlgoritEvaluatorTest >> newEvaluator [
	^ AlgoritEvaluator new
]

{ #category : #test }
AlgoritEvaluatorTest >> testAppendVarData [
	| e |
	e := self newEvaluator.
	self assert: e varHistory isCollection.
	self assert: e varHistory isEmpty.
	e appendVar: 'a' data: 1.
	e appendVar: 'b' data: 2.
	e appendVar: 'c' data: 3.
	self assert: e varHistory size equals: 3.
	self
		assertCollection: e varHistory first
		equals: (Array with: 'a' with: 1).
	self
		assertCollection: e varHistory second
		equals: (Array with: 'b' with: 2).
	self
		assertCollection: e varHistory third
		equals: (Array with: 'c' with: 3)
]

{ #category : #test }
AlgoritEvaluatorTest >> testChangeVarBy [
	| e |
	e := self newEvaluator.
	self assert: e vars isEmpty.
	self assert: e varHistory isEmpty.
	e setVar: 'a' to: 123.
	e changeVar: 'a' by: 234.
	self assert: e vars size equals: 1.
	self assert: (e vars at: 'a') equals: 123 + 234.
	self assert: e varHistory size equals: 2.
	self
		assertCollection: e varHistory first
		equals: (Array with: 'a' with: 123).
	self
		assertCollection: e varHistory second
		equals: (Array with: 'a' with: 123 + 234)
]

{ #category : #test }
AlgoritEvaluatorTest >> testClear [
	| e |
	e := self newEvaluator.
	e messages: 'abc'.
	e appendVar: 'a' data: 123.
	self deny: e messages isEmpty.
	self deny: e varHistory isEmpty.
	e clear.
	self assert: e messages isEmpty.
	self assert: e varHistory isEmpty
]

{ #category : #test }
AlgoritEvaluatorTest >> testClearVarHistory [
	| e |
	e := self newEvaluator.
	self assert: e varHistory isCollection.
	self assert: e varHistory isEmpty.
	e appendVar: 'a' data: 1.
	e appendVar: 'b' data: 2.
	e appendVar: 'c' data: 3.
	self assert: e varHistory size equals: 3.
	e varsModified: false.
	e clearVarHistory.
	self assert: e varHistory isEmpty.
	self assert: e varsModified
]

{ #category : #test }
AlgoritEvaluatorTest >> testDeleteVariable [
	| e |
	e := self newEvaluator.
	e setVar: 'a' to: 123.
	e setVar: 'b' to: 456.
	e setVar: 'c' to: 789.
	self assert: (e vars includesKey: 'a').
	self assert: (e vars includesKey: 'b').
	self assert: (e vars includesKey: 'c').
	e deleteVariable: 'b'.
	self assert: (e vars includesKey: 'a').
	self deny: (e vars includesKey: 'b').
	self assert: (e vars includesKey: 'c').
	self assert: e varHistory size equals: 2.
	self
		assertCollection: e varHistory first
		equals: (Array with: 'a' with: 123).
	self
		assertCollection: e varHistory second
		equals: (Array with: 'c' with: 789)
]

{ #category : #test }
AlgoritEvaluatorTest >> testGetVar [
	| e |
	e := self newEvaluator.
	self assert: (e getVar: 'a') equals: 0.
	e setVar: 'a' to: 123.
	self assert: (e getVar: 'a') equals: 123
]

{ #category : #test }
AlgoritEvaluatorTest >> testInitialize [
	| e |
	e := self newEvaluator.
	self assert: e vars isDictionary.
	self assert: e vars isEmpty.
	self assert: e lists isDictionary.
	self assert: e lists isEmpty.
	self assert: e watchingVars isEmpty.
	self assert: e messages isEmpty.
	self assert: e varsModified.
	self assert: e listsModified
]

{ #category : #test }
AlgoritEvaluatorTest >> testIsWatchingVar [
	self testSetWatchingVarTo
]

{ #category : #test }
AlgoritEvaluatorTest >> testListsModified [
	| e |
	e := self newEvaluator.
	self assert: e listsModified.
	e listsModified: false.
	self deny: e listsModified.
	e listsModified: true.
	self assert: e listsModified
]

{ #category : #test }
AlgoritEvaluatorTest >> testMessages [
	| e |
	e := self newEvaluator.
	self assert: e messages isEmpty.
	e messages: 'abc'.
	self assert: e messages equals: 'abc'
]

{ #category : #test }
AlgoritEvaluatorTest >> testNumbersFromTo [
	| e r |
	e := self newEvaluator.
	r := e numbers: 5 from: 1 to: 3.
	self assertCollection: r equals: #(1 2 3 1 2).
	r := e numbers: 5 from: 3 to: 4.
	self assertCollection: r equals: #(3 4 3 4 3)
]

{ #category : #test }
AlgoritEvaluatorTest >> testPrint [
	| e |
	e := self newEvaluator.
	e messages: 'abc'.
	e print: 'def'.
	self assert: e messages equals: 'abcdef'
]

{ #category : #test }
AlgoritEvaluatorTest >> testPrintln [
	| e |
	e := self newEvaluator.
	e messages: 'abc'.
	e println: 'def'.
	self assert: e messages equals: 'abcdef' , String crlf
]

{ #category : #test }
AlgoritEvaluatorTest >> testSetVarTo [
	| e |
	e := self newEvaluator.
	self assert: e vars isEmpty.
	self assert: e varHistory isEmpty.
	e setVar: 'a' to: 123.
	e setVar: 'b' to: 456.
	e setVar: 'c' to: 789.
	e setVar: 'b' to: 234.
	self assert: e vars size equals: 3.
	self assert: (e vars at: 'a') equals: 123.
	self assert: (e vars at: 'b') equals: 234.
	self assert: (e vars at: 'c') equals: 789.
	self assert: e varHistory size equals: 4.
	self
		assertCollection: e varHistory first
		equals: (Array with: 'a' with: 123).
	self
		assertCollection: e varHistory second
		equals: (Array with: 'b' with: 456).
	self
		assertCollection: e varHistory third
		equals: (Array with: 'c' with: 789).
	self
		assertCollection: e varHistory fourth
		equals: (Array with: 'b' with: 234)
]

{ #category : #test }
AlgoritEvaluatorTest >> testSetWatchingVarTo [
	| e |
	e := self newEvaluator.
	self deny: (e isWatchingVar: 'a').
	e setWatchingVar: 'a' to: true.
	self assert: (e isWatchingVar: 'a').
	e setWatchingVar: 'a' to: false.
	self deny: (e isWatchingVar: 'a')
]

{ #category : #test }
AlgoritEvaluatorTest >> testToggleWatchingVar [
	| e |
	e := self newEvaluator.
	self deny: (e isWatchingVar: 'a').
	e toggleWatchingVar: 'a'.
	self assert: (e isWatchingVar: 'a').
	e toggleWatchingVar: 'a'.
	self deny: (e isWatchingVar: 'a')
]

{ #category : #test }
AlgoritEvaluatorTest >> testVarHistory [
	| e |
	e := self newEvaluator.
	self assert: e varHistory isCollection.
	self assert: e varHistory isEmpty
]

{ #category : #test }
AlgoritEvaluatorTest >> testVars [
	self testSetVarTo
]

{ #category : #test }
AlgoritEvaluatorTest >> testVarsModified [
	| e |
	e := self newEvaluator.
	self assert: e varsModified.
	e varsModified: false.
	self deny: e varsModified.
	e varsModified: true.
	self assert: e varsModified
]

{ #category : #test }
AlgoritEvaluatorTest >> testWatchingVars [
	| e |
	e := self newEvaluator.
	self deny: (e watchingVars includes: 'a').
	e setWatchingVar: 'a' to: true.
	self assert: (e watchingVars includes: 'a').
	e setWatchingVar: 'a' to: false.
	self deny: (e watchingVars includes: 'a')
]
