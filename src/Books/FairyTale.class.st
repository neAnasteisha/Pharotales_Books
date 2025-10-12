"
Клас FairyTale є базовим для всіх типів казок.
Він зберігає основні властивості казки, такі як назва, автор, мораль та тривалість.
Клас може бути розширений для створення конкретних підтипів казкових історій.
Використовується як основа для класів StoryBook і TaleCollection.
"
Class {
	#name : 'FairyTale',
	#superclass : 'Object',
	#instVars : [
		'author',
		'title',
		'publisher',
		'publicationYear'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'globals' }
FairyTale class >> minimalYear [
	^1000.
]

{ #category : 'instance creation' }
FairyTale class >> newWithAuthor: anAuthor title: aTitle publisher: aPublisher year: aYear [
	| obj yearValue |
	yearValue := aYear max: FairyTale minimalYear.
	obj := self basicNew.
	obj
		author: anAuthor;
		title: aTitle;
		publisher: aPublisher;
		publicationYear: yearValue.
		^ obj
]

{ #category : 'comparing' }
FairyTale >> < anObject [
    (anObject isKindOf: FairyTale)
        ifTrue: [^ self publicationYear < anObject publicationYear].
    ^ false
]

{ #category : 'comparing' }
FairyTale >> = anObject [
    ^ (anObject isKindOf: FairyTale)
        ifTrue: [self title = anObject title]
        ifFalse: [false].
]

{ #category : 'comparing' }
FairyTale >> > anObject [
    (anObject isKindOf: FairyTale)
        ifTrue: [^ self publicationYear > anObject publicationYear].
    ^ false
]

{ #category : 'accessing' }
FairyTale >> author [

	^ author
]

{ #category : 'accessing' }
FairyTale >> author: anObject [

	author := anObject
]

{ #category : 'initialization' }
FairyTale >> initialize [ 
	author := ''.
	title := ''.
	publisher := ''.
	publicationYear := Date today year.
]

{ #category : 'printing' }
FairyTale >> printOn: aStream [
    aStream
        nextPutAll: '"' , title , '"';
        nextPutAll: ' by ' , author;
        nextPutAll: ' (' , publisher , ', ' , publicationYear asString , ')'.

]

{ #category : 'accessing' }
FairyTale >> publicationYear [

	^ publicationYear
]

{ #category : 'accessing' }
FairyTale >> publicationYear: anObject [

	publicationYear := anObject max: self class minimalYear.
]

{ #category : 'accessing' }
FairyTale >> publisher [

	^ publisher
]

{ #category : 'accessing' }
FairyTale >> publisher: anObject [

	publisher := anObject
]

{ #category : 'accessing' }
FairyTale >> title [

	^ title
]

{ #category : 'accessing' }
FairyTale >> title: anObject [

	title := anObject
]
