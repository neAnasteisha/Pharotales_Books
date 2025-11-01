Class {
	#name : 'SpFairyTaleGUI',
	#superclass : 'SpPresenter',
	#instVars : [
		'bookList',
		'addButton',
		'deleteButton',
		'refreshButton',
		'detailsText',
		'authorInput',
		'titleInput',
		'yearInput',
		'publisherInput'
	],
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'instance creation' }
SpFairyTaleGUI class >> open [
	^ self new open
]

{ #category : 'initialization' }
SpFairyTaleGUI >> addBook [
"Додає інформацію про книгу"
	| author title publisher year tale |
	
	author := authorInput text ifEmpty: [ ^ self inform: 'Enter the author!' ].
	title := titleInput text ifEmpty: [ ^ self inform: 'Enter the title!' ].
	publisher := publisherInput text ifEmpty: [ 'Secret' ].
	
	year := [ yearInput text asNumber ] 
		on: Error 
		do: [ ^ self inform: 'Nice try, but year must be a number!' ].
	
	tale := FairyTale 
		newWithAuthor: author
		title: title
		publisher: publisher
		year: year.
	
	TaleCollection add: tale.
	
	self clearInputs.
	self refreshList.
	self inform: 'The book was added!'
]

{ #category : 'initialization' }
SpFairyTaleGUI >> clearInputs [
"Очищує поля вводу після додавання книги"
	authorInput text: ''.
	titleInput text: ''.
	publisherInput text: ''.
	yearInput text: ''
]

{ #category : 'initialization' }
SpFairyTaleGUI >> connectPresenters [
"Для того, щоб кнопки себе якось поводили"
	addButton action: [ self addBook ].
	refreshButton action: [ self refreshList ].
	deleteButton action: [ self deleteSelected ].
	
	bookList whenSelectionChangedDo: [ :selection |
		selection selectedItem 
			ifNotNil: [ :tale | self showDetails: tale ]
			ifNil: [ detailsText text: '' ] ]
]

{ #category : 'initialization' }
SpFairyTaleGUI >> defaultLayout [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: 'Auhor:' width: 80;
			add: #authorInput;
			yourself) height: 30;
		add: (SpBoxLayout newHorizontal
			add: 'Title:' width: 80;
			add: #titleInput;
			yourself) height: 30;
		add: (SpBoxLayout newHorizontal
			add: 'Publisher:' width: 80;
			add: #publisherInput;
			yourself) height: 30;
		add: (SpBoxLayout newHorizontal
			add: 'Year:' width: 80;
			add: #yearInput;
			yourself) height: 30;
		add: (SpBoxLayout newHorizontal
			add: #addButton;
			add: #refreshButton;
			add: #deleteButton;
			yourself) height: 40;
		add: 'List of books:' height: 25;
		add: #bookList;
		add: 'Details:' height: 25;
		add: #detailsText height: 150;
		yourself
]

{ #category : 'initialization' }
SpFairyTaleGUI >> initializePresenters [
"Візуальні компоненти"
	authorInput := self newTextInput.
	titleInput := self newTextInput.
	publisherInput := self newTextInput.
	yearInput := self newTextInput.
	
	bookList := self newList.
	bookList display: [ :tale | tale title, ' - ', tale author ].
	
	detailsText := self newText.
	detailsText beNotEditable.
	
	addButton := self newButton.
	addButton label: 'Add book'; 
	icon: (self iconNamed: #add).
	
	refreshButton := self newButton.
	refreshButton label: 'Refresh'; 
	icon: (self iconNamed: #refresh).
	
	deleteButton := self newButton.
	deleteButton label: 'Delete'; 
	icon: (self iconNamed: #delete).
	
	self refreshList.
]

{ #category : 'initialization' }
SpFairyTaleGUI >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Library of fairy tales Pharotales';
		initialExtent: 600@550
]

{ #category : 'initialization' }
SpFairyTaleGUI >> refreshList [
"Оновлює список казок"
	TaleCollection ensureAll.
	bookList items: TaleCollection all asOrderedCollection
]
