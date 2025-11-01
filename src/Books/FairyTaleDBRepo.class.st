Class {
	#name : 'FairyTaleDBRepo',
	#superclass : 'Object',
	#classVars : [
		'Current'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'accessing' }
FairyTaleDBRepo class >> current [
	^ Current ifNil: [Current := self setupInMemory]
]

{ #category : 'as yet unclassified' }
FairyTaleDBRepo class >> setupInMemory [
	| repo |
	repo := VOMemoryRepository new.
	repo enableSingleton.
	^ repo
]
