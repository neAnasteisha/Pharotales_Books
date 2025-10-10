Class {
	#name : 'Book',
	#superclass : 'Object',
	#instVars : [
		'author',
		'title',
		'publisher',
		'yearOfPublishing'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'initialization' }
Book >> initialize [
    super initialize.
    author := ''.
    title := ''.
    publisher := ''.
    yearOfPublishing := 0.
]
