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

{ #category : 'instance creation' }
StoryBook class >> newWithAuthor: anAuthor title: aTitle publisher: aPublisher year: aYear pages: p illustrations: illus [ [

	^ self basicNew base: ( FairyTale newWithAuthor: anAuthor title: aTitle publisher:  aPublisher year: aYear);
		pages: p;
		illustrations: illus
]
]

{ #category : 'instance creation' }
StoryBook class >> pages: pagesCount illustrations: illustrationsCount [
    ^ self new
        pages: pagesCount;
        illustrations: illustrationsCount.

]

{ #category : 'comparing' }
StoryBook >> < anotherBook [
    ^ pages < anotherBook pages

]

{ #category : 'comparing' }
StoryBook >> denserThan: anotherBook [
    ^ self illustrationDensity > anotherBook illustrationDensity

]

{ #category : 'statistics' }
StoryBook >> illustrationDensity [
    pages = 0 ifTrue: [ ^ 0 ].
    ^ (illustrations / pages) * 100

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
