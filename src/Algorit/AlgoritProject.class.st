Class {
	#name : 'AlgoritProject',
	#superclass : 'ScratchProject',
	#category : 'Algorit-Project',
	#package : 'Algorit',
	#tag : 'Project'
}

{ #category : 'constants' }
AlgoritProject class >> fileVersion [
	^ 1
]

{ #category : 'constants' }
AlgoritProject class >> fileVersionTag [
	^ 'AlgoritV'
]

{ #category : 'constants' }
AlgoritProject class >> objStreamClass [
	^ STONObjStream
]

{ #category : 'accessing' }
AlgoritProject >> assureExistsScriptNamed: each [

	self setupScripts
]

{ #category : 'api' }
AlgoritProject >> clearVarHistory [
	scripts do: [ :each | each evaluator clearVarHistory ]
]

{ #category : 'api' }
AlgoritProject >> countVarHistory [
	| sum |
	sum := 0.
	scripts do: [ :each | sum := sum + each evaluator varHistory size ].
	^ sum
]

{ #category : 'instance creation' }
AlgoritProject >> newScript [

	^ AlgoritScript new
		  project: self;
		  yourself
]

{ #category : 'accessing' }
AlgoritProject >> scriptNamed: aString [

	^ scripts first
]

{ #category : 'api' }
AlgoritProject >> setupScripts [

	scripts isEmpty ifFalse: [ ^ self ].
	self addScript: self newScript
]

{ #category : 'api' }
AlgoritProject >> stopAll [

	application stopAllProcesses
]

{ #category : 'api' }
AlgoritProject >> stopAllProcesses [
	scripts do: #stopAllProcesses
]

{ #category : 'api' }
AlgoritProject >> updateVarTable: aScript [

	application updateVarTable: aScript
]
