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
FairyTaleTest >> testComparison [
	| tale1 tale2 tale3 |
	
	tale1 := FairyTale new.
	tale1 author: 'Andersen'.
	tale1 title: 'The Snow Queen'.
	tale1 publisher: 'Classic Press'.
	tale1 publicationYear: 1844.

	tale2 := FairyTale new.
	tale2 author: 'Andersen'.
	tale2 title: 'The Snow Queen'.
	tale2 publisher: 'Classic Press'.
	tale2 publicationYear: 1844.

	tale3 := FairyTale new.
	tale3 author: 'Andersen'.
	tale3 title: 'The Wild Swans'.
	tale3 publisher: 'Classic Press'.
	tale3 publicationYear: 1838.

	self assert: (tale1 = tale2).       "перевірка рівності"
	self assert: (tale3 < tale1).       "перевірка порівняння за роком"
	self deny: (tale1 < tale3).         "обернена перевірка"

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
FairyTaleTest >> testEquality [
    | t1 t2 |
    t1 := FairyTale newWithAuthor: 'Andersen'
                        title: 'The Snow Queen'
                        publisher: 'Classic Press'
                        year: 1844.
    t2 := FairyTale newWithAuthor: 'Andersen'
                        title: 'The Snow Queen'
                        publisher: 'Classic Press'
                        year: 1844.

    self assert: (t1 = t2) equals: true.

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
FairyTaleTest >> testMinimalYear [
    self assert: FairyTale minimalYear equals: 1000.

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
