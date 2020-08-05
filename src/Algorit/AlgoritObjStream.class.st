Class {
	#name : #AlgoritObjStream,
	#superclass : #ObjStream,
	#category : #'Algorit-Project'
}

{ #category : #'class initialization' }
AlgoritObjStream class >> initialize [
	"self initialize"
	self setupVariables
]

{ #category : #private }
AlgoritObjStream class >> userClasses [
	^ super userClasses, #(
		"id		class"
		(111		AlgoritProject)
		(112		AlgoritScript)
	)
]

{ #category : #'entry points' }
AlgoritObjStream >> readObjFrom: aStream showProgress: aBoolean [
	| str |
	str := aStream upToEnd asString.
	^ STON fromString: str
]

{ #category : #'entry points' }
AlgoritObjStream >> storeObj: anObject on: aStream [
	| str |
	str := STON toString: anObject.
	aStream nextPutAll: str asByteArray
]
