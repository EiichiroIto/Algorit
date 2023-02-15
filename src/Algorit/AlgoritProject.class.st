Class {
	#name : #AlgoritProject,
	#superclass : #ScratchProject,
	#category : #'Algorit-Project'
}

{ #category : #constants }
AlgoritProject class >> fileVersion [
	^ 1
]

{ #category : #constants }
AlgoritProject class >> fileVersionTag [
	^ 'AlgoritV'
]

{ #category : #constants }
AlgoritProject class >> objStreamClass [
	^ STONObjStream
]

{ #category : #api }
AlgoritProject >> addScriptNamed: aString [
	| script |
	script := AlgoritScript new
		project: self;
		objName: aString;
		yourself.
	self addScript: script.
	^ script
]

{ #category : #accessing }
AlgoritProject >> application: anApplication [
	super application: anApplication.
	scripts isEmpty
		ifTrue: [ self addScriptNamed: anApplication mainScriptName ]
]

{ #category : #accessing }
AlgoritProject >> assureExistsBreed: each [
	((self scripts collect: #objName) includes: each)
		ifTrue: [ ^ self ].
	self addScriptNamed: each
]

{ #category : #api }
AlgoritProject >> clearVarHistory [
	scripts do: [ :each | each evaluator clearVarHistory ]
]

{ #category : #api }
AlgoritProject >> countVarHistory [
	| sum |
	sum := 0.
	scripts do: [ :each | sum := sum + each evaluator varHistory size ].
	^ sum
]

{ #category : #api }
AlgoritProject >> stopAll [
	self application stopAllProcesses
]

{ #category : #processes }
AlgoritProject >> stopAllProcesses [
	scripts do: #stopAllProcesses
]

{ #category : #api }
AlgoritProject >> updateVarTable: aScript [
	self application updateVarTable: aScript
]
