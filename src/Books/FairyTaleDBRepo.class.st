Class {
	#name : 'FairyTaleDBRepo',
	#superclass : 'Object',
	#instVars : [
		'items'
	],
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

{ #category : 'initialization' }
FairyTaleDBRepo class >> setupInMemory [
	Current := FairyTaleDBRepo new.
	Current initialize.
	^ Current

]

{ #category : 'initialization' }
FairyTaleDBRepo >> allItems [
	^ items asOrderedCollection

]

{ #category : 'initialization' }
FairyTaleDBRepo >> initialize [
	super initialize.
	items := OrderedCollection new.

]

{ #category : 'initialization' }
FairyTaleDBRepo >> remove: aBook [
	items remove: aBook ifAbsent: [ ]

]

{ #category : 'initialization' }
FairyTaleDBRepo >> root [
	^ items

]

{ #category : 'initialization' }
FairyTaleDBRepo >> save: aBook [
	items add: aBook

]
