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
AlgoritEvaluatorTest >> testAppendFromToToList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	self assert: (e lists at: #abc) isEmpty.
	e appendFrom: 2 to: 5 toList: 'abc'.
	self
		assertCollection: (e lists at: #abc)
		equals: #(2 3 4 5) asOrderedCollection
]

{ #category : #test }
AlgoritEvaluatorTest >> testAppendRandomFromToToList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e
		appendRandom: 3
		from: 1
		to: 3
		toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) sorted asArray
		equals: #(1 2 3).
	e clearList: 'abc'.
	e
		appendRandom: 6
		from: 1
		to: 3
		toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) sorted asArray
		equals: #(1 1 2 2 3 3).
	e setRandomSeed: 1234.
	e clearList: 'abc'.
	e
		appendRandom: 3
		from: 1
		to: 10
		toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(2 8 6)
]

{ #category : #test }
AlgoritEvaluatorTest >> testAppendToList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 1 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 3 toList: 'abc'.
	self assert: (e lists at: #abc) isCollection.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 2 3).
	self should: [ e append: 1 toList: 'def' ] raise: Error
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
AlgoritEvaluatorTest >> testClearList [
	| e |
	e := self newEvaluator.
	self assert: e lists isDictionary.
	self assert: e lists isEmpty.
	e clearList: 'abc'.
	self assert: (e lists at: #abc) isCollection.
	self assert: (e lists at: #abc) isEmpty
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
AlgoritEvaluatorTest >> testDeleteLineOfList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 1 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 3 toList: 'abc'.
	e append: 4 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 2 3 4 5).
	e deleteLine: 4 ofList: 'abc'.
	e deleteLine: 2 ofList: 'abc'.
	self assertCollection: (e lists at: #abc) asArray equals: #(1 3 5)
]

{ #category : #test }
AlgoritEvaluatorTest >> testDeleteList [
	| e |
	e := self newEvaluator.
	self deny: (e lists includesKey: #abc).
	e clearList: 'abc'.
	self assert: (e lists includesKey: #abc).
	e deleteList: 'abc'.
	self deny: (e lists includesKey: #abc)
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
AlgoritEvaluatorTest >> testGetFalse [
	self deny: self newEvaluator getFalse
]

{ #category : #test }
AlgoritEvaluatorTest >> testGetLineOfList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 1 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 3 toList: 'abc'.
	e append: 4 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self assert: (e getLine: 1 ofList: 'abc') equals: 1.
	self assert: (e getLine: 2 ofList: 'abc') equals: 2.
	self assert: (e getLine: 3 ofList: 'abc') equals: 3.
	self assert: (e getLine: 4 ofList: 'abc') equals: 4.
	self assert: (e getLine: 5 ofList: 'abc') equals: 5.
	self should: [ e getLine: 1 ofList: 'def' ] raise: Error
]

{ #category : #test }
AlgoritEvaluatorTest >> testGetTrue [
	self assert: self newEvaluator getTrue
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
AlgoritEvaluatorTest >> testIsBetweenAnd [
	| e |
	e := self newEvaluator.
	self assert: (e is: -1 between: -1 and: 10).
	self assert: (e is: 5 between: -1 and: 10).
	self assert: (e is: 10 between: -1 and: 10).
	self deny: (e is: -2 between: 1 and: 10).
	self deny: (e is: 11 between: 1 and: 10)
]

{ #category : #test }
AlgoritEvaluatorTest >> testIsWatchingVar [
	self testSetWatchingVarTo
]

{ #category : #test }
AlgoritEvaluatorTest >> testLineCountOfList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	self assert: (e lineCountOfList: 'abc') equals: 0.
	e append: 1 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 3 toList: 'abc'.
	e append: 4 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self assert: (e lineCountOfList: 'abc') equals: 5.
	self should: [ e lineCountOfList: 'def' ] raise: Error
]

{ #category : #test }
AlgoritEvaluatorTest >> testListContains [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 1 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 3 toList: 'abc'.
	e append: 4 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self assert: (e list: 'abc' contains: 1).
	self assert: (e list: 'abc' contains: 2).
	self assert: (e list: 'abc' contains: 3).
	self assert: (e list: 'abc' contains: 4).
	self assert: (e list: 'abc' contains: 5).
	self deny: (e list: 'abc' contains: 6)
]

{ #category : #test }
AlgoritEvaluatorTest >> testLists [
	| e |
	e := self newEvaluator.
	self assert: e lists isDictionary.
	self assert: e lists isEmpty
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
AlgoritEvaluatorTest >> testNegated [
	| e |
	e := self newEvaluator.
	self assert: (e negated: 0) equals: 0.
	self assert: (e negated: 1) equals: -1.
	self assert: (e negated: -1) equals: 1
]

{ #category : #test }
AlgoritEvaluatorTest >> testNot [
	| e |
	e := self newEvaluator.
	self assert: (e not: false).
	self deny: (e not: true)
]

{ #category : #test }
AlgoritEvaluatorTest >> testNumbersFromTo [
	| e r |
	e := self newEvaluator.
	r := e numbers: 5 from: 2 to: 6.
	self assertCollection: r equals: #(2 3 4 5 6).
	r := e numbers: 6 from: 3 to: 4.
	self assertCollection: r equals: #(3 4 3 4 3 4).
	r := e numbers: 100 from: 1 to: 9999.
	self assertCollection: r asSet asArray sorted size equals: 100
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
	self assert: e messages equals: 'abcdef' , String cr
]

{ #category : #test }
AlgoritEvaluatorTest >> testRandom [
	| e |
	e := self newEvaluator.
	self assert: e random identicalTo: SharedRandom globalGenerator
]

{ #category : #test }
AlgoritEvaluatorTest >> testRandomFromTo [
	| e r |
	e := self newEvaluator.
	e setRandomSeed: 1234.
	r := e randomFrom: 1 to: 10.
	self assert: r equals: 1.
	r := e randomFrom: 1 to: 10.
	self assert: r equals: 4.
	r := e randomFrom: 1 to: 10.
	self assert: r equals: 5
]

{ #category : #test }
AlgoritEvaluatorTest >> testReverseList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 10 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 300 toList: 'abc'.
	e append: 40 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(10 2 300 40 5).
	e reverseList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(5 40 300 2 10).
	self should: [ e sortList: 'def' ] raise: Error
]

{ #category : #test }
AlgoritEvaluatorTest >> testRounded [
	| e |
	e := self newEvaluator.
	self assert: (e rounded: 10) equals: 10.
	self assert: (e rounded: -10) equals: -10.
	self assert: (e rounded: 1.4) equals: 1.
	self assert: (e rounded: 1.5) equals: 2.
	self assert: (e rounded: -1.4) equals: -1.
	self assert: (e rounded: -1.5) equals: -2
]

{ #category : #test }
AlgoritEvaluatorTest >> testSetLineOfListTo [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 1 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 3 toList: 'abc'.
	e append: 4 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 2 3 4 5).
	e setLine: 2 ofList: 'abc' to: 20.
	e setLine: 4 ofList: 'abc' to: 40.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 20 3 40 5).
	e setLine: 0 ofList: 'abc' to: 20.
	e setLine: 6 ofList: 'abc' to: 20.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 20 3 40 5).
	e setLine: -1 ofList: 'abc' to: 50.
	e setLine: -2 ofList: 'abc' to: 400.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 20 3 400 50).
	self should: [ e setLine: 1 ofList: 'def' to: 20 ] raise: Error
]

{ #category : #test }
AlgoritEvaluatorTest >> testSetRandomSeed [
	| e |
	e := self newEvaluator.
	e setRandomSeed: 1234.
	self deny: e random identicalTo: SharedRandom globalGenerator.
	self assert: (e random isKindOf: Random).
	e setRandomSeed: 0.
	self assert: e random identicalTo: SharedRandom globalGenerator
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
AlgoritEvaluatorTest >> testShuffleList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	self assert: (e lists at: #abc) isEmpty.
	e appendFrom: 2 to: 5 toList: 'abc'.
	self assertCollection: (e lists at: #abc) asArray equals: #(2 3 4 5).
	e shuffleList: 'abc'.
	self
		assertCollection: (e lists at: #abc) sorted asArray
		equals: #(2 3 4 5).
	e setRandomSeed: 1234.
	e clearList: 'abc'.
	e appendFrom: 2 to: 5 toList: 'abc'.
	e shuffleList: 'abc'.
	self assertCollection: (e lists at: #abc) asArray equals: #(3 4 5 2)
]

{ #category : #test }
AlgoritEvaluatorTest >> testSortList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 10 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 300 toList: 'abc'.
	e append: 40 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(10 2 300 40 5).
	e sortList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(2 5 10 40 300).
	self should: [ e sortList: 'def' ] raise: Error
]

{ #category : #test }
AlgoritEvaluatorTest >> testSwapLineAndOfList [
	| e |
	e := self newEvaluator.
	e clearList: 'abc'.
	e append: 1 toList: 'abc'.
	e append: 2 toList: 'abc'.
	e append: 3 toList: 'abc'.
	e append: 4 toList: 'abc'.
	e append: 5 toList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 2 3 4 5).
	e swapLine: 2 and: 4 ofList: 'abc'.
	self
		assertCollection: (e lists at: #abc) asArray
		equals: #(1 4 3 2 5).
	self should: [ e swapLine: 2 and: 4 ofList: 'def' ] raise: Error
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
AlgoritEvaluatorTest >> testTruncated [
	| e |
	e := self newEvaluator.
	self assert: (e truncated: 10) equals: 10.
	self assert: (e truncated: -10) equals: -10.
	self assert: (e truncated: 1.4) equals: 1.
	self assert: (e truncated: 1.5) equals: 1.
	self assert: (e truncated: -1.4) equals: -1.
	self assert: (e truncated: -1.5) equals: -1
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
