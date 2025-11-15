Class {
	#name : 'UsageExamples',
	#superclass : 'Object',
	#category : 'Books',
	#package : 'Books'
}

{ #category : 'as yet unclassified' }
UsageExamples class >> createSampleBooks [
    | dict tale1 tale2 tale3 |
    
    dict := Dictionary new.

    dict at: #book1 put: (StoryBook newWithAuthor: 'Andersen' title: 'Snow Queen' publisher: 'ClassicHouse' year: 1844 pages: 120 illustrations: 10).
    dict at: #book2 put: (StoryBook newWithAuthor: 'Grimm' title: 'Cinderella' publisher: 'FolkPress' year: 1812 pages: 100 illustrations: 5).
    dict at: #book3 put: (StoryBook newWithAuthor: 'Perrault' title: 'Sleeping Beauty' publisher: 'FairyPub' year: 1697 pages: 80 illustrations: 8).

    dict at: #tale1 put: (TaleCollection new author: 'Andersen'; title: 'Collected Tales 1'; publisher: 'ClassicHouse'; publicationYear: 1845; pagesPerVolume: #(120 140 160); yourself).
    dict at: #tale2 put: (TaleCollection new author: 'Grimm'; title: 'Collected Tales 2'; publisher: 'FolkPress'; publicationYear: 1813; pagesPerVolume: #(90 110 100); yourself).
    dict at: #tale3 put: (TaleCollection new author: 'Perrault'; title: 'Collected Tales 3'; publisher: 'FairyPub'; publicationYear: 1698; pagesPerVolume: #(100 120 130); yourself).

    ^ dict

]

{ #category : 'as yet unclassified' }
UsageExamples class >> exampleBookCollection [
    <script>
    | books newTale allBooks largestBook |

    books := self createSampleBooks.
    allBooks := OrderedCollection new.
    books keysAndValuesDo: [ :key :book | allBooks add: book ].

	 newTale := TaleCollection newFromDialog.
    newTale ifNotNil: [
        allBooks add: newTale.
    ].

    Transcript cr; show: 'All books:'; cr.
    allBooks do: [ :book |
        Transcript show: book printString; cr.
        Transcript cr
    ].

	 largestBook := allBooks inject: allBooks first
        into: [ :maxBook :book | (book totalPages > maxBook totalPages) ifTrue: [ book ] ifFalse: [ maxBook ] ].
    Transcript cr; show: 'The largest one:'; cr.
    Transcript show: largestBook printString; cr.
    Transcript cr.

    Transcript show: 'Is it a TaleCollection? ', (largestBook isKindOf: TaleCollection) printString; cr.



]

{ #category : 'as yet unclassified' }
UsageExamples class >> exampleBooksCreation [
    <script>
    | story tale |
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

    Transcript cr; show: story printString; cr.
    Transcript show: tale printString; cr.

]

{ #category : 'as yet unclassified' }
UsageExamples class >> exampleComparison [
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
UsageExamples class >> loadTaleCollectionsFromFile [
    <script>
    | fuelFile stonFile loadedFromFuel loadedFromSton |

    Transcript cr; show: 'Loading TaleCollections from files'; cr.
    TaleCollection clearAll.
    fuelFile := 'tales_collection.fuel' asFileReference.
    loadedFromFuel := FLMaterializer materializeFromFileNamed: fuelFile fullName.
    Transcript show: 'Loaded from FUEL:'; cr.
    loadedFromFuel do: [:tale |
        TaleCollection add: tale.
        Transcript show: tale printString; cr.
    ].

    stonFile := 'tales_collection.ston' asFileReference.
    TaleCollection clearAll.
    stonFile readStreamDo: [:stream |
        loadedFromSton := STON fromStream: stream
    ].
    Transcript show: 'Loaded from STON:'; cr.
    loadedFromSton do: [:tale |
        TaleCollection add: tale.
        Transcript show: tale printString; cr.
    ].

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
    Transcript show: 'Saved in FUEL format: ', fuelFile fullName; cr.

    stonFile := 'tales_collection.ston' asFileReference.
    stonFile writeStreamDo: [ :stream |
        STON put: allTales onStream: stream
    ].
    Transcript show: 'Saved in STON format: ', stonFile fullName; cr.

    Transcript cr; show: 'All TaleCollection objects have been successfully saved.'; cr.

]
