Class {
	#name : 'FairyTaleTest',
	#superclass : 'TestCase',
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'tests' }
FairyTaleTest >> testAccessors [
    | tale |
    tale := FairyTale new.
    tale author: 'Grimm Brothers'.
    tale title: 'Cinderella'.
    tale publisher: 'Old Tales'.
    tale publicationYear: 1812.

    self assert: tale author equals: 'Grimm Brothers'.
    self assert: tale title equals: 'Cinderella'.
    self assert: tale publisher equals: 'Old Tales'.
    self assert: tale publicationYear equals: 1812.

]

{ #category : 'tests' }
FairyTaleTest >> testCreation [
    | tale |
    tale := FairyTale newWithAuthor: 'Andersen'
                         title: 'The Snow Queen'
                         publisher: 'Classic Press'
                         year: 1844.

    self assert: tale author equals: 'Andersen'.
    self assert: tale title equals: 'The Snow Queen'.
    self assert: tale publisher equals: 'Classic Press'.
    self assert: tale publicationYear equals: 1844.

]

{ #category : 'tests' }
FairyTaleTest >> testInitialize [
    | tale |
    tale := FairyTale new.

    self assert: tale author equals: ''.
    self assert: tale title equals: ''.
    self assert: tale publisher equals: ''.
    self assert: tale publicationYear equals: 2025.

]

{ #category : 'tests' }
FairyTaleTest >> testPrintOn [
    | tale output |
    tale := FairyTale newWithAuthor: 'Andersen'
                         title: 'The Snow Queen'
                         publisher: 'Classic Press'
                         year: 1844.

    output := String streamContents: [ :s | tale printOn: s ].

    self assert: (output includesSubstring: 'Andersen') equals: true.
    self assert: (output includesSubstring: 'The Snow Queen') equals: true.
    self assert: (output includesSubstring: '1844') equals: true.

]

{ #category : 'tests' }
FairyTaleTest >> testYearLimits [
	| limits |
	limits := FairyTale yearLimits.
	self assert: limits first equals: 1574.
	self assert: limits second equals: Date today year.
]
