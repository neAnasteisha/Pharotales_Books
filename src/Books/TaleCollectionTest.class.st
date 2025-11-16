Class {
	#name : 'TaleCollectionTest',
	#superclass : 'TestCase',
	#instVars : [
		't1',
		't2',
		't3',
		'coll'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'running' }
TaleCollectionTest >> setUp [
    super setUp.
    (TaleCollection respondsTo: #clearAll) ifTrue: [ TaleCollection clearAll ].

    t1 := TaleCollection new
        author: 'Андерсен';
        title: 'Казки';
        publicationYear: 1852;
        pagesPerVolume: #(120 95 140);
        yourself.

    t2 := TaleCollection new
        author: 'Брати Грімм';
        title: 'Дитячі й родинні казки';
        publicationYear: 1812;
        pagesPerVolume: #(50 60);
        yourself.

    t3 := TaleCollection new
        author: 'Шарль Перро';
        title: 'Казки матінки Гуски';
        publicationYear: 1697;
        pagesPerVolume: #(200);
        yourself.

    coll := OrderedCollection new.

]

{ #category : 'running' }
TaleCollectionTest >> testAddVolumeWithPages [
	| oldCount |
	oldCount := t3 volumes.
	self assert: (t3 addVolumeWithPages: 30) equals: 30.
	self assert: t3 volumes equals: oldCount + 1.
	self assert: t3 totalPages equals: 230

]

{ #category : 'running' }
TaleCollectionTest >> testDescription [
	| d |
	d := t1 description.

	self assert: (d includesSubstring: 'Автор: ').
	self assert: (d includesSubstring: t1 author).
	self assert: (d includesSubstring: 'Назва: ').
	self assert: (d includesSubstring: t1 title).
	self assert: (d includesSubstring: 'Рік: ', t1 publicationYear printString).
	self assert: (d includesSubstring: 'Томів: ', t1 volumes printString).
	self assert: (d includesSubstring: 'Загальний обсяг: ', t1 totalPages printString).
	self assert: (d includesSubstring: 'Аркушів:').
	self assert: (d includesSubstring: (t1 printedSheets printShowingDecimalPlaces: 2)).

]

{ #category : 'running' }
TaleCollectionTest >> testFullReportString [
	| r |
	r := t1 fullReportString.

	self assert: (r includesSubstring: '=== Книга ===').
	self assert: (r includesSubstring: 'Автор: ').
	self assert: (r includesSubstring: t1 author).
	self assert: (r includesSubstring: 'Назва: ').
	self assert: (r includesSubstring: t1 title).
	self assert: (r includesSubstring: 'Рік: ').
	self assert: (r includesSubstring: t1 publicationYear printString).

	self assert: (r includesSubstring: 'Томи: ').
	self assert: (r includesSubstring: t1 volumes printString).
	(t1 respondsTo: #pagesBreakdownString)
		ifTrue: [ self assert: (r includesSubstring: t1 pagesBreakdownString) ].

	self assert: (r includesSubstring: 'Сторінок разом: ' , t1 totalPages printString).
	self assert: (r includesSubstring: 'Аркушів (точно): ').
	self assert: (r includesSubstring: (t1 printedSheets printShowingDecimalPlaces: 2)).
	self assert: (r includesSubstring: 'Аркушів (мінімально): ' , t1 printedSheetsCeiling printString).
	self assert: (r includesSubstring: String cr).
]

{ #category : 'running' }
TaleCollectionTest >> testPagesBreakdownString [
	| expected result |

	expected := String streamContents: [ :str |
		str nextPut: $[.
		t1 pagesPerVolume
			doWithIndex: [ :each :i |
				str nextPutAll: each printString.
				i < t1 pagesPerVolume size ifTrue: [ str nextPutAll: ', ' ] ].
		str nextPut: $] ].

	result := t1 pagesBreakdownString.
	self assert: result equals: expected.
	self assert: (result beginsWith: '[').
	self assert: (result endsWith: ']').
	self assert: (result includesSubstring: ', ').
]

{ #category : 'running' }
TaleCollectionTest >> testPagesPerVolume [
	"Перевіряє, що метод приймає лише позитивні цілі числа і правильно зберігає їх."
	
	t1 pagesPerVolume: #(120 95 140).
	self assert: t1 pagesPerVolume equals: #(120 95 140) asOrderedCollection.

	self should: [ t1 pagesPerVolume: #(120 -5 90) ] raise: AssertionFailure.


]

{ #category : 'running' }
TaleCollectionTest >> testRemoveVolumeAt [

	t1 pagesPerVolume: #(120 95 140).
	t1 removeVolumeAt: 2.
	self assert: t1 pagesPerVolume equals: #(120 140) asOrderedCollection.
	self should: [ t1 removeVolumeAt: 5 ] raise: AssertionFailure.
]

{ #category : 'running' }
TaleCollectionTest >> testReplaceVolumeAtwithPages [

	t1 pagesPerVolume: #(120 95 140).

	t1 replaceVolumeAt: 2 withPages: 100.
	self assert: t1 pagesPerVolume equals: #(120 100 140) asOrderedCollection.

	self should: [ t1 replaceVolumeAt: 5 withPages: 200 ] raise: AssertionFailure.
	self should: [ t1 replaceVolumeAt: 1 withPages: -10 ] raise: AssertionFailure.
	self should: [ t1 replaceVolumeAt: 1 withPages: 'abc' ] raise: AssertionFailure.

]

{ #category : 'running' }
TaleCollectionTest >> testTotalPages [
	self assert: t1 totalPages equals: 355.
	self assert: t2 totalPages equals: 110.
	self assert: t3 totalPages equals: 200.
]
