Class {
	#name : 'BaselineOfAlgorit',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAlgorit',
	#package : 'BaselineOfAlgorit'
}

{ #category : 'baselines' }
BaselineOfAlgorit >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'FromScratch';
			package: 'FromScratch-Tests'
			with: [ spec requires: #( 'FromScratch' ) ];
			package: 'Algorit' with: [ spec requires: #( 'FromScratch' ) ];
			package: 'Algorit-Tests' with: [ spec requires: #( 'Algorit' ) ] ].
	spec group: 'Deploy' with: #( 'Algorit' )
]

{ #category : 'accessing' }
BaselineOfAlgorit >> projectClass [
	^ MetacelloCypressBaselineProject
]
