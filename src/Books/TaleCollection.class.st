Class {
	#name : 'TaleCollection',
	#superclass : 'FairyTale',
	#instVars : [
		'pagesPerVolume'
	],
	#classInstVars : [
		'All'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'instance creation' }
TaleCollection class >> add: aTale [
	self ensureAll.
	All add: aTale.
	^ aTale

]

{ #category : 'instance creation' }
TaleCollection class >> all [
	self ensureAll.
	^ All

]

{ #category : 'instance creation' }
TaleCollection class >> clearAll [
	All := OrderedCollection new.

]

{ #category : 'instance creation' }
TaleCollection class >> ensureAll [
	All ifNil: [ All := OrderedCollection new ].

]

{ #category : 'testing' }
TaleCollection class >> isVoyageRoot [
    ^ true
]

{ #category : 'as yet unclassified' }
TaleCollection class >> listToTranscript [
	self ensureAll.
	Transcript cr; show: '=== УСІ КНИГИ (', All size printString, ') ==='; cr.
	All do: [ :b | b printFullReport  ].
]

{ #category : 'instance creation' }
TaleCollection class >> newFromDialog [
	| author title year pagesStr pages tale |
	author := UIManager default request: 'Автор:'.
	author isNil ifTrue: [ ^ nil ].

	title := UIManager default request: 'Назва:'.
	title isNil ifTrue: [ ^ nil ].

	year := UIManager default request: 'Рік видання:' initialAnswer: ''.
	year isNil ifTrue: [ ^ nil ].
	[ year := Number readFrom: year readStream ] on: Error do: [ ^ nil ].

	pagesStr := UIManager default
		request: 'Сторінки по томах (через кому, напр. 120,95,140):'.
	pagesStr isNil ifTrue: [ ^ nil ].

	pages := (pagesStr findTokens: ',; ')
		collect: [ :s | [ s asNumber ] on: Error do: [ 0 ] ].
	pages := pages select: [ :n | (n isInteger) and: [ n > 0 ] ].
	pages isEmpty ifTrue: [ ^ nil ].

	tale := self new
		author: author;
		title: title;
		publicationYear: year;
		pagesPerVolume: pages;
		yourself.

	self add: tale.
	tale printFullReport.

	UIManager default inform:
		'Додано: ', tale title, ' (томів: ', tale volumes printString,
		', стор.: ', tale totalPages printString, ')'.

	^ tale

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
TaleCollection >> fullReportString [
	^ String streamContents: [ :s |
		s
			nextPutAll: '=== Книга ==='; cr;
			nextPutAll: 'Автор: '; nextPutAll: self author; cr;
			nextPutAll: 'Назва: '; nextPutAll: self title; cr;
			nextPutAll: 'Рік: '; nextPutAll: self publicationYear printString; cr;
			nextPutAll: 'Томи: '; nextPutAll: self volumes printString; space;
				nextPutAll: self pagesBreakdownString; cr;
			nextPutAll: 'Сторінок разом: '; nextPutAll: self totalPages printString; cr;
			nextPutAll: 'Аркушів (точно): ';
				nextPutAll: (self printedSheets printShowingDecimalPlaces: 2); cr;
			nextPutAll: 'Аркушів (мінімально): ';
				nextPutAll: self printedSheetsCeiling printString; cr ]
]

{ #category : 'accessing' }
TaleCollection >> initialize [
	super initialize.
	pagesPerVolume := OrderedCollection new.
]

{ #category : 'accessing' }
TaleCollection >> pagesBreakdownString [
	"Напр.: [120, 95, 140]"
	^ String streamContents: [ :stream |
		stream nextPut: $[.
		pagesPerVolume
			doWithIndex: [ :each :i |
				stream nextPutAll: each printString.
				i < pagesPerVolume size ifTrue: [ stream nextPutAll: ', ' ] ].
		stream nextPut: $] ].

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

{ #category : 'printing' }
TaleCollection >> printFullReport [ 
	Transcript cr; show: self fullReportString; cr.


]

{ #category : 'accessing' }
TaleCollection >> printedSheets [
	^ (self totalPages / 32.0)
]

{ #category : 'accessing' }
TaleCollection >> printedSheetsCeiling [
	^ self printedSheets ceiling
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
