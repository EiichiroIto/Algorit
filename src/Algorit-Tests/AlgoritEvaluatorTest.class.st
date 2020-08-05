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
AlgoritEvaluatorTest >> testVarsModified [
	| e |
	e := self newEvaluator.
	self assert: e varsModified.
	e varsModified: false.
	self deny: e varsModified.
	e varsModified: true.
	self assert: e varsModified
]
