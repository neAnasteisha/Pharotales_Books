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
	^1574.
]

{ #category : 'instance creation' }
FairyTale class >> newWithAuthor: anAuthor title: aTitle publisher: aPublisher year: aYear [
	| obj |
	obj := self basicNew.
	obj
		author: anAuthor;
		title: aTitle;
		publisher: aPublisher;
		publicationYear: aYear.
		^ obj
]

{ #category : 'comparing' }
FairyTale >> < anObject [
    ^ self totalPages < anObject totalPages.
]

{ #category : 'comparing' }
FairyTale >> = anObject [
    ^ self totalPages = anObject totalPages.
]

{ #category : 'comparing' }
FairyTale >> > anObject [
    ^ anObject < self
]

{ #category : 'accessing' }
FairyTale >> author [

	^ author
]

{ #category : 'accessing' }
FairyTale >> author: aString [

	author := aString
]

{ #category : 'initialization' }
FairyTale >> initialize [ 
	author := ''.
	title := ''.
	publisher := ''.
	publicationYear := Date today year.
	
]

{ #category : 'accessing' }
FairyTale >> isVoyageRoot [
	^ true

]

{ #category : 'printing' }
FairyTale >> printOn: aStream [
    aStream
        nextPut: $";
        nextPutAll: title;
        nextPut: $";
        nextPutAll: ' by ';
        nextPutAll: author;
        nextPutAll: ' (';
        nextPutAll: publisher;
        nextPutAll: ', ';
        nextPutAll: publicationYear asString;
        nextPut: $).


]

{ #category : 'accessing' }
FairyTale >> publicationYear [

	^ publicationYear
]

{ #category : 'accessing' }
FairyTale >> publicationYear: aNumber [

	publicationYear := aNumber max: self class minimalYear.
]

{ #category : 'accessing' }
FairyTale >> publisher [

	^ publisher
]

{ #category : 'accessing' }
FairyTale >> publisher: aString [

	publisher := aString
]

{ #category : 'accessing' }
FairyTale >> title [

	^ title
]

{ #category : 'accessing' }
FairyTale >> title: aString [

	title := aString
]

{ #category : 'accessing' }
FairyTale >> totalPages [
	self subclassResponsibility.
]
