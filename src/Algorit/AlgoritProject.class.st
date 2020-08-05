Class {
	#name : #AlgoritProject,
	#superclass : #ScratchProject,
	#category : #'Algorit-Project'
}

{ #category : #accessing }
AlgoritProject class >> appVersion [
	^ 1
]

{ #category : #accessing }
AlgoritProject class >> appVersionTag [
	^ 'AlgoritV'
]

{ #category : #accessing }
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

{ #category : #private }
AlgoritProject >> newObjStream [
	^ AlgoritObjStream new
]

{ #category : #processes }
AlgoritProject >> stopAllProcesses [
	scripts do: #stopAllProcesses
]

{ #category : #accessing }
AlgoritProject >> updateVarTable: aScript [
	self application updateVarTable: aScript
]