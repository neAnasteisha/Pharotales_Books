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
		'publisherInput',
		'typeDropdown',
		'pagesInput',
		'illustrationsInput',
		'pagesRow',
		'illustrationsRow',
		'pagesLabel',
		'illustrationsLabel',
		'typeDropDown'
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
	| author title publisher year pages illustrations tale repo isStoryBook |
	
	author := authorInput text ifEmpty: [ ^ self inform: 'Enter the author!' ].
	title := titleInput text ifEmpty: [ ^ self inform: 'Enter the title!' ].
	publisher := publisherInput text ifEmpty: [ 'Secret' ].

	year := [ yearInput text asNumber ]
		on: Error do: [ ^ self inform: 'Year must be a number!' ].

	isStoryBook := (typeDropdown selectedItem = 'StoryBook').

	isStoryBook
		ifTrue: [
			pages := [ pagesInput text asNumber ]
				on: Error do: [ ^ self inform: 'Pages must be a number!' ].
			illustrations := [ illustrationsInput text asNumber ]
				on: Error do: [ ^ self inform: 'Illustrations must be a number!' ].
			tale := StoryBook
				newWithAuthor: author
				title: title
				publisher: publisher
				year: year
				pages: pages
				illustrations: illustrations
		]
		ifFalse: [
			tale := FairyTale
				newWithAuthor: author
				title: title
				publisher: publisher
				year: year
		].

	repo := FairyTaleDBRepo current.
	repo save: tale.

	self clearInputs.
	self refreshList.
	self inform: 'The book was added!'.

]

{ #category : 'initialization' }
SpFairyTaleGUI >> clearInputs [
"Очищує поля вводу після додавання книги"
	authorInput text: ''.
	titleInput text: ''.
	publisherInput text: ''.
	yearInput text: ''.
	pagesInput text: ''.
	illustrationsInput text: ''.
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
            ifNil: [ detailsText text: '' ] ].

    "NEW"
    typeDropdown whenSelectionChangedDo: [ self updateFieldsVisibility ].

]

{ #category : 'initialization' }
SpFairyTaleGUI >> defaultLayout [
	^ SpBoxLayout newVertical
		add: (SpBoxLayout newHorizontal
			add: 'Author:' width: 80;
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
			add: 'Type:' width: 80;
			add: #typeDropdown;
			yourself) height: 30;
		add: (SpBoxLayout newHorizontal
			add: 'Pages:' width: 80;
			add: #pagesInput;
			yourself) height: 30;
		add: (SpBoxLayout newHorizontal
			add: 'Illustrations:' width: 80;
			add: #illustrationsInput;
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
SpFairyTaleGUI >> deleteSelected [
	| selected repo |
	selected := bookList selectedItem ifNil: [ ^ self inform: 'Select a book first!' ].
	repo := FairyTaleDBRepo current.
	repo remove: selected.
	self refreshList.
	self inform: 'The book was deleted.'

]

{ #category : 'initialization' }
SpFairyTaleGUI >> initializeLayout [

    | mainContainer topFields pagesRow illustrationsRow |
    
    mainContainer := SpBoxLayout newVertical.

    topFields := SpBoxLayout newVertical.
    topFields
        add: (SpBoxLayout newHorizontal add:'Author:' width:80; add: authorInput; yourself);
        add: (SpBoxLayout newHorizontal add:'Title:' width:80; add: titleInput; yourself);
        add: (SpBoxLayout newHorizontal add:'Publisher:' width:80; add: publisherInput; yourself);
        add: (SpBoxLayout newHorizontal add:'Year:' width:80; add: yearInput; yourself);
        add: (SpBoxLayout newHorizontal add:'Type:' width:80; add: typeDropDown; yourself).

    pagesRow := SpBoxLayout newHorizontal
        add:'Pages:' width:80; add: pagesInput; yourself.

    illustrationsRow := SpBoxLayout newHorizontal
        add:'Illustrations:' width:80; add: illustrationsInput; yourself.

    mainContainer
        add: topFields;
        add: pagesRow;
        add: illustrationsRow.

    self layout: mainContainer.

    pagesRow name: #pagesRow.
    illustrationsRow name: #illustrationsRow.

]

{ #category : 'initialization' }
SpFairyTaleGUI >> initializePresenters [
	super initializePresenters.

	authorInput := self newTextInput.
	titleInput := self newTextInput.
	publisherInput := self newTextInput.
	yearInput := self newTextInput.

	"Тип просто вибираємо – без логіки видимості"
	typeDropdown := self newDropList.
	typeDropdown items: #('FairyTale' 'StoryBook').
	typeDropdown selectItem: 'StoryBook'.

	pagesInput := self newTextInput.
	illustrationsInput := self newTextInput.

	bookList := self newList.
	bookList display: [ :tale | tale title , ' - ' , tale author ].

	detailsText := self newText.
	detailsText beNotEditable.

	addButton := self newButton.
	addButton
		label: 'Add book';
		icon: (self iconNamed: #add).

	refreshButton := self newButton.
	refreshButton
		label: 'Refresh';
		icon: (self iconNamed: #refresh).

	deleteButton := self newButton.
	deleteButton
		label: 'Delete';
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
	bookList items: FairyTaleDBRepo current allItems

]

{ #category : 'initialization' }
SpFairyTaleGUI >> showDetails: aTale [
	| text |
	aTale isNil ifTrue: [ ^ detailsText text: '' ].

	(aTale isKindOf: TaleCollection)
		ifTrue: [ ^ detailsText text: aTale fullReportString ].

	text := String streamContents: [ :s | aTale printOn: s ].
	detailsText text: text

]

{ #category : 'initialization' }
SpFairyTaleGUI >> updateFieldsVisibility [
	| type |
	type := typeDropdown selectedItem ifNil: [ '' ].

	(type = 'StoryBook')
		ifTrue: [
			pagesInput visible: true.
			illustrationsInput visible: true.
		]
		ifFalse: [
			pagesInput visible: false.
			illustrationsInput visible: false.
		].

]
