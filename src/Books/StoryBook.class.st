"
Клас StoryBook успадковує від FairyTale і моделює окрему фізичну книгу казки.
Містить додаткові характеристики, такі як кількість сторінок і кількість ілюстрацій.
Клас використовується для представлення конкретного видання або монографії казки.
"
Class {
	#name : 'StoryBook',
	#superclass : 'FairyTale',
	#instVars : [
		'pages',
		'illustrations'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'testing' }
StoryBook class >> isVoyageRoot [
    ^ true
]

{ #category : 'instance creation' }
StoryBook class >> minimalIllustrations [
	^0.
]

{ #category : 'instance creation' }
StoryBook class >> minimalPages [
	^0.
]

{ #category : 'instance creation' }
StoryBook class >> newWithAuthor: anAuthor title: aTitle publisher: aPublisher year: aYear pages: aPages illustrations: aIllustrations [
	| obj safePages safeIllustrations |

	safePages := aPages max: self minimalPages.
	safeIllustrations := aIllustrations max: self minimalIllustrations.

	obj := self basicNew.
	obj
		author: anAuthor;
		title: aTitle;
		publisher: aPublisher;
		publicationYear: aYear;
		pages: safePages;
		illustrations: safeIllustrations.
	^ obj

]

{ #category : 'instance creation' }
StoryBook class >> pages: pagesCount illustrations: illustrationsCount [
	| safePages safeIllustrations |
	
	safePages := pagesCount max: self class minimalPages.
	safeIllustrations := illustrationsCount max: self class minimalIllustrations.

	^ self new
		pages: safePages;
		illustrations: safeIllustrations.

]

{ #category : 'instance creation' }
StoryBook class >> title: aTitle author: anAuthor [ 
	^ self new
		title: aTitle;
		author: anAuthor;
		publisher: '';
		publicationYear: Date today year;
		pages: 0;
		illustrations: 0;
		yourself
]

{ #category : 'comparing' }
StoryBook >> denserThan: anotherBook [
    ^ self illustrationDensity > anotherBook illustrationDensity

]

{ #category : 'statistics' }
StoryBook >> illustrationDensity [
	pages = 0 ifTrue: [ ^ 0 ].
	^ illustrations / pages

]

{ #category : 'accessing' }
StoryBook >> illustrations [
    ^ illustrations
]

{ #category : 'accessing' }
StoryBook >> illustrations: aNumber [
    illustrations := aNumber
]

{ #category : 'initialization' }
StoryBook >> initialize [ 
	super initialize.
	pages := 0.
	illustrations := 0

]

{ #category : 'comparing' }
StoryBook >> moreIllustratedThan: anotherBook [
    ^ illustrations > anotherBook illustrations

]

{ #category : 'accessing' }
StoryBook >> pages [
    ^ pages
]

{ #category : 'accessing' }
StoryBook >> pages: aNumber [
    pages := aNumber
]

{ #category : 'printing' }
StoryBook >> printOn: aStream [
    super printOn: aStream.
    aStream
        nextPut: Character cr;
        nextPutAll: 'Book has ';
        nextPutAll: pages asString;
        nextPutAll: ' pages and ';
        nextPutAll: illustrations asString;
        nextPutAll: ' illustrations.'.

]

{ #category : 'accessing' }
StoryBook >> totalPages [
	^ self pages + self illustrations.
]
