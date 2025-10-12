Class {
	#name : 'TaleCollection',
	#superclass : 'FairyTale',
	#instVars : [
		'pagesPerVolume'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'accessing' }
TaleCollection >> initialize [
	super initialize.
	pagesPerVolume := OrderedCollection new.
]

{ #category : 'accessing' }
TaleCollection >> pagesPerVolume [
	^ pagesPerVolume
]

{ #category : 'accessing' }
TaleCollection >> pagesPerVolume: aCollection [

	self assert: [ aCollection allSatisfy: [ :n | n isInteger and: [ n > 0 ] ] ].
	pagesPerVolume := aCollection asOrderedCollection.
]

{ #category : 'accessing' }
TaleCollection >> volumes [
	^ pagesPerVolume size
]
