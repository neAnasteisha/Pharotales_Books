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
TaleCollectionTest >> testAddVolumeWithPagesPreconditions [
	self should: [ t1 addVolumeWithPages: 0 ] raise: AssertionFailure.
	self should: [ t1 addVolumeWithPages: -5 ] raise: AssertionFailure.
	self should: [ t1 addVolumeWithPages: '10' ] raise: AssertionFailure
]

{ #category : 'running' }
TaleCollectionTest >> testCollectionStoresAndEnumerates [
	coll add: t1; add: t2; add: t3.
	self assert: coll size equals: 3.
	self assert: (coll anySatisfy: [ :e | e author = 'Андерсен' ]).
	self assert: (coll collect: #totalPages) sum equals: (t1 totalPages + t2 totalPages + t3 totalPages)
]

{ #category : 'running' }
TaleCollectionTest >> testDescriptionFormat [
	| d |
	d := t1 description.
	self assert: (d includesSubstring: 'Автор: ').
	self assert: (d includesSubstring: t1 author).
	self assert: (d includesSubstring: 'Назва: ').
	self assert: (d includesSubstring: 'Рік: 1852').
	self assert: (d includesSubstring: 'Томів: 3')
]

{ #category : 'running' }
TaleCollectionTest >> testRegistryAddAndClear [
	(TaleCollection respondsTo: #all) ifTrue: [
		self assert: TaleCollection all isEmpty.
		TaleCollection add: t1.
		TaleCollection add: t2.
		self assert: TaleCollection all size equals: 2.
		TaleCollection clearAll.
		self assert: TaleCollection all isEmpty ]
]

{ #category : 'running' }
TaleCollectionTest >> testSortingByTotalPagesWithLessOperator [
	| sorted |
	sorted := (Array with: t1 with: t2 with: t3)
		asSortedCollection: [ :a :b | a totalPages <= b totalPages ].
	self assert: sorted size equals: 3.
	self assert: sorted first totalPages <= sorted second totalPages.
	self assert: sorted second totalPages <= sorted third totalPages.

]

{ #category : 'running' }
TaleCollectionTest >> testTotalPages [
	self assert: t1 totalPages equals: 355.
	self assert: t2 totalPages equals: 110.
	self assert: t3 totalPages equals: 200
]

{ #category : 'running' }
TaleCollectionTest >> testVolumesCount [
	self assert: t1 volumes equals: 3.
	self assert: t2 volumes equals: 2.
	self assert: t3 volumes equals: 1
]
