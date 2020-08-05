"
just dummy library pane
"
Class {
	#name : #SpAlgoritLibrary,
	#superclass : #SpPresenter,
	#category : #'Algorit-Spec2'
}

{ #category : #specs }
SpAlgoritLibrary class >> defaultSpec [
	^ SpBoxLayout newHorizontal
]

{ #category : #accessing }
SpAlgoritLibrary >> selectButton: aString [
	"do nothing"
]
