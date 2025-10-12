Class {
	#name : 'TaleCollectionTest',
	#superclass : 'TestCase',
	#instVars : [
		't1',
		't2',
		'Tale'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'tests' }
TaleCollectionTest >> testEqualityAndHashConsistency [
	| t1copy |
	t1copy := TaleCollection new
		author: 'Андерсен';
		title: 'Казки';
		publicationYear: 1852;
		pagesPerVolume: #(120 95 140);
		yourself.
	(self respondsTo: #equals:) ifTrue: [
		self assert: (t1 = t1copy).
		self assert: t1 hash equals: t1copy hash ].
]

{ #category : 'tests' }
TaleCollectionTest >> testRegistryAddAllAndClear [
	self assert: TaleCollection all isEmpty.
	TaleCollection add: t1.
	TaleCollection add: t2.
	self assert: TaleCollection all size equals: 2.
	self assert: (TaleCollection all first == t1 or: [ TaleCollection all second == t2 ]).
	TaleCollection clearAll.
	self assert: TaleCollection all isEmpty.
]
