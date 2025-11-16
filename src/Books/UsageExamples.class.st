Class {
	#name : 'UsageExamples',
	#superclass : 'Object',
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'as yet unclassified' }
UsageExamples class >> booksComparison [
    <script>
    | books |

    books := self createSampleBooks.

    Transcript cr; show: 'Comparison of StoryBook and StoryBook:'; cr.
    Transcript show: 'book1 < book2: ', ((books at: #book1) < (books at: #book2)) printString; cr.
    Transcript show: 'book1 > book3: ', ((books at: #book1) > (books at: #book3)) printString; cr.
    Transcript show: 'book2 = book3: ', ((books at: #book2) = (books at: #book3)) printString; cr.

    Transcript cr; show: 'Comparison of TaleCollection and TaleCollection:'; cr.
    Transcript show: 'tale1 < tale2: ', ((books at: #tale1) < (books at: #tale2)) printString; cr.
    Transcript show: 'tale2 > tale3: ', ((books at: #tale2) > (books at: #tale3)) printString; cr.
    Transcript show: 'tale1 = tale3: ', ((books at: #tale1) = (books at: #tale3)) printString; cr.

    Transcript cr; show: 'Comparison of StoryBook and TaleCollection:'; cr.
    Transcript show: 'book1 < tale1: ', ((books at: #book1) < (books at: #tale1)) printString; cr.
    Transcript show: 'book2 > tale2: ', ((books at: #book2) > (books at: #tale2)) printString; cr.
    Transcript show: 'book3 = tale3: ', ((books at: #book3) = (books at: #tale3)) printString; cr.

]

{ #category : 'as yet unclassified' }
UsageExamples class >> booksCreation [
    <script>
    | story tale |
	 Transcript cr; show: '--- Created ---'.
    story := StoryBook newWithAuthor: 'Andersen' 
                             title: 'Snow Queen' 
                             publisher: 'ClassicHouse' 
                             year: 1844 
                             pages: 120 
                             illustrations: 10.

    tale := TaleCollection new.
    tale author: 'Grimm'; 
         title: 'Collected Tales'; 
         publisher: 'FolkPress'; 
         publicationYear: 1813.
    tale pagesPerVolume: #(120 140 160).

    Transcript cr; show: 'StoryBook: ', story printString; cr.
    Transcript show: 'TaleCollection: ', tale printString; cr.

]

{ #category : 'as yet unclassified' }
UsageExamples class >> createBooksCollection [
    <script>
    | books newTale allBooks largestBook num |

    books := self createSampleBooks.
    allBooks := OrderedCollection new.
    books keysAndValuesDo: [ :key :book | allBooks add: book ].

	 newTale := TaleCollection newFromDialog.
    newTale ifNotNil: [
        allBooks add: newTale.
    ].

    Transcript cr; show: '--- All books ---'; cr.
	 num := 1.
    allBooks do: [ :book |
        Transcript show: num; show: '. '.
		  Transcript show: book printString; cr.
		  num := num + 1.
    ].

	 largestBook := allBooks inject: allBooks first
        into: [ :maxBook :book | (book totalPages > maxBook totalPages) ifTrue: [ book ] ifFalse: [ maxBook ] ].
    Transcript cr; show: 'The largest one:'; cr.
    Transcript show: largestBook printString; cr.
    Transcript cr.
    Transcript show: 'Is it a TaleCollection? ', (largestBook isKindOf: TaleCollection) printString; cr.



]

{ #category : 'as yet unclassified' }
UsageExamples class >> createSampleBooks [
    | dict |
    
    dict := Dictionary new.

	 dict at: #book1 put: (StoryBook newWithAuthor: 'Roald Dahl' title: 'Matilda' publisher: 'Puffin Books' year: 1988 pages: 240 illustrations: 10).
	 dict at: #book2 put: (StoryBook newWithAuthor: 'Roald Dahl' title: 'Charlie and the Chocolate Factory' publisher: 'Puffin Books' year: 1964 pages: 176 illustrations: 20).
	 dict at: #book3 put: (StoryBook newWithAuthor: 'Dr. Seuss' title: 'The Cat in the Hat' publisher: 'Random House' year: 1957 pages: 61 illustrations: 25).
	 dict at: #tale1 put: (TaleCollection new author: 'J.K. Rowling'; title: 'Harry Potter Series'; publisher: 'Bloomsbury'; publicationYear: 1997;
		  pagesPerVolume: #(223 251 317 636 766 607 607); yourself).
	 dict at: #tale2 put: (TaleCollection new author: 'C.S. Lewis'; title: 'The Chronicles of Narnia'; publisher: 'HarperCollins'; publicationYear: 1950;
		  pagesPerVolume: #(208 240 208 248 240 208 224); yourself).
	 dict at: #tale3 put: (TaleCollection new author: 'Cressida Cowell'; title: 'How to Train Your Dragon Series'; publisher: 'Bloomsbury'; publicationYear: 2003; 		                   	          pagesPerVolume: #(128 144 176 160 192 208 224 256 272 288); yourself).
			
    ^ dict.
]

{ #category : 'as yet unclassified' }
UsageExamples class >> loadBooksFromDB [
    <script>
    | repo allBooks num |

    Transcript cr; show: 'Books loaded from the database:'; cr.
    repo := VORepository current.
    allBooks := repo allItems.
	 num := 1.
    allBooks do: [:b |
		  Transcript show: num; show: '. '.
        Transcript show: b printString; cr.
		  num := num +1. ].

]

{ #category : 'as yet unclassified' }
UsageExamples class >> loadTaleCollectionsFromFile [
    <script>
    | fuelFile stonFile loadedFromFuel loadedFromSton num |

    TaleCollection clearAll.
    fuelFile := 'tales_collection.fuel' asFileReference.
    loadedFromFuel := FLMaterializer materializeFromFileNamed: fuelFile fullName.
    Transcript cr; show: 'Loaded from FUEL:'; cr.
	 num := 1.
    loadedFromFuel do: [:tale |
        TaleCollection add: tale.
		  Transcript show: num; show: '. '.
        Transcript show: tale printString; cr.
		  num := num + 1. 
    ].

    stonFile := 'tales_collection.ston' asFileReference.
    TaleCollection clearAll.
    stonFile readStreamDo: [:stream |
        loadedFromSton := STON fromStream: stream
    ].
    Transcript cr; show: 'Loaded from STON:'; cr.
	 num := 1.
    loadedFromSton do: [:tale |
        TaleCollection add: tale.
		  Transcript show: num; show: '. '.
        Transcript show: tale printString; cr.
  		  num := num + 1.
    ].

]

{ #category : 'as yet unclassified' }
UsageExamples class >> saveBooksToDB [
    <script>
    | repo books |

    VORepository setRepository: nil.
    repo := FairyTaleDBRepo setupInMemory.
    VORepository setRepository: repo.
    books := self createSampleBooks.
    books valuesDo: [:obj | obj save. ].

    Transcript cr; show: 'Books was successfully saved to the database.'; cr.

]

{ #category : 'as yet unclassified' }
UsageExamples class >> saveTaleCollectionsToFile [
    <script>
    | fuelFile stonFile books allTales |

    books := self createSampleBooks.
    allTales := OrderedCollection new.
    books valuesDo: [ :book |
        (book isKindOf: TaleCollection) ifTrue: [ allTales add: book ].
    ].

    fuelFile := 'tales_collection.fuel' asFileReference.
    FLSerializer serialize: allTales toFileNamed: fuelFile fullName.
    Transcript cr; show: 'Saved in FUEL format: ', fuelFile fullName; cr.

    stonFile := 'tales_collection.ston' asFileReference.
    stonFile writeStreamDo: [ :stream |
        STON put: allTales onStream: stream
    ].
    Transcript show: 'Saved in STON format: ', stonFile fullName; cr.

]
