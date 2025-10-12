Class {
	#name : 'StoryBookTest',
	#superclass : 'TestCase',
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'tests' }
StoryBookTest >> testAccessors [
	| book |
	book := StoryBook new.
	book pages: 120.
	book illustrations: 30.

	self assert: book pages equals: 120.
	self assert: book illustrations equals: 30.

]

{ #category : 'tests' }
StoryBookTest >> testComparison [
	| b1 b2 |
	b1 := StoryBook new.
	b1 pages: 100.
	b1 illustrations: 20.

	b2 := StoryBook new.
	b2 pages: 100.
	b2 illustrations: 40.

	self assert: (b2 denserThan: b1) equals: true.
	self assert: (b1 denserThan: b2) equals: false.

]

{ #category : 'tests' }
StoryBookTest >> testDenserThan [
	| book1 book2 |
	
	book1 := StoryBook new.
	book1 pages: 100.
	book1 illustrations: 25.

	book2 := StoryBook new.
	book2 pages: 200.
	book2 illustrations: 20.

	self assert: (book1 denserThan: book2).
	self deny: (book2 denserThan: book1).

]

{ #category : 'tests' }
StoryBookTest >> testIllustrationDensity [
	| book |
	book := StoryBook new.
	book pages: 100.
	book illustrations: 25.

	self assert: book illustrationDensity equals: 0.25.

]

{ #category : 'tests' }
StoryBookTest >> testInitialize [
	| book |
	book := StoryBook new.

	self assert: book pages equals: 0.
	self assert: book illustrations equals: 0.

]

{ #category : 'tests' }
StoryBookTest >> testMinimalIllustrations [
	self assert: StoryBook minimalIllustrations equals: 0.
]

{ #category : 'tests' }
StoryBookTest >> testMinimalPages [
	self assert: StoryBook minimalPages equals: 0.

]

{ #category : 'tests' }
StoryBookTest >> testMoreIllustratedThan [
	| b1 b2 |
	b1 := StoryBook new.
	b1 illustrations: 15.

	b2 := StoryBook new.
	b2 illustrations: 30.

	self assert: (b2 moreIllustratedThan: b1) equals: true.
	self assert: (b1 moreIllustratedThan: b2) equals: false.

]

{ #category : 'tests' }
StoryBookTest >> testPrintOn [
	| book output |
	book := StoryBook new.
	book pages: 120.
	book illustrations: 30.

	output := String streamContents: [ :s | book printOn: s ].

	self assert: (output includesSubstring: '120') equals: true.
	self assert: (output includesSubstring: '30') equals: true.

]
