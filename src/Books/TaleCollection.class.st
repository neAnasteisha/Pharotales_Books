Class {
	#name : 'TaleCollection',
	#superclass : 'FairyTale',
	#instVars : [
		'pagesPerVolume'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'instance creation' }
TaleCollection class >> newFromDialog [
	| author title year pagesStr pages |
	author := UIManager default request: 'Автор:'.
	author isNil ifTrue: [ ^ nil ].

	title := UIManager default request: 'Назва:'.
	title isNil ifTrue: [ ^ nil ].

	year := UIManager default
		request: 'Рік видання:'
		initialAnswer: ''.
	year isNil ifTrue: [ ^ nil ].
	year := year asNumber.

	pagesStr := UIManager default
		request: 'Сторінки по томах (через кому, напр. 120,95,140):'.
	pagesStr isNil ifTrue: [ ^ nil ].

	pages := self parsePagesPerVolume: pagesStr.
	pages isEmpty ifTrue: [ ^ nil ].

	^ self new
		author: author;
		title: title;
		publicationYear: year;
		pagesPerVolume: pages;
		yourself

]

{ #category : 'instance creation' }
TaleCollection class >> parsePagesPerVolume: aString [
	^ ((aString findTokens: ',; ') collect: [ :s |
			| n |
			n := s asNumber.
			(n isInteger and: [ n > 0 ]) ifTrue: [ n ] ifFalse: [ 0 ] ])
		select: [ :each | each > 0 ].

]

{ #category : 'accessing' }
TaleCollection >> < aTale [
	^ self totalPages < aTale totalPages
]

{ #category : 'accessing' }
TaleCollection >> addVolumeWithPages: pageCount [
	(self assert: [ pageCount isInteger and: [ pageCount > 0 ] ]).
	pagesPerVolume add: pageCount.
	^ pageCount
]

{ #category : 'accessing' }
TaleCollection >> description [
	^ 'Автор: ', self author,
	  ', Назва: ', self title,
	  ', Рік: ', self publicationYear printString,
	  ', Томів: ', self volumes printString,
	  ', Загальний обсяг: ', self totalPages printString, ' сторінок',
	  ', Аркушів: ',
	    (self printedSheets printShowingDecimalPlaces: 2).
]

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
TaleCollection >> printedSheets [
	^ (self totalPages / 32.0)
]

{ #category : 'accessing' }
TaleCollection >> removeVolumeAt: index [
	self assert: [ index between: 1 and: pagesPerVolume size ].
	pagesPerVolume removeAt: index.
]

{ #category : 'accessing' }
TaleCollection >> replaceVolumeAt: index withPages: pageCount [
	self assert: [ index between: 1 and: pagesPerVolume size ].
	self assert: [ pageCount isInteger and: [ pageCount > 0 ] ].
	pagesPerVolume at: index put: pageCount.
]

{ #category : 'accessing' }
TaleCollection >> totalPages [
	^ pagesPerVolume inject: 0 into: [ :sum :each | sum + each ]
]

{ #category : 'accessing' }
TaleCollection >> volumes [
	^ pagesPerVolume size
]
