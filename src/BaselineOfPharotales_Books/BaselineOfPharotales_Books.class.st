Class {
	#name : 'BaselineOfPharotales_Books',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharotales_Books',
	#package : 'BaselineOfPharotales_Books'
}

{ #category : 'baselines' }
BaselineOfPharotales_Books >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec package: 'Books' 
		].
]

{ #category : 'accessing' }
BaselineOfPharotales_Books >> projectClass [ 
	^ MetacelloCypressBaselineProject.
]
