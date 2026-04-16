Class {
	#name : 'FastParsingService',
	#superclass : 'Object',
	#instVars : [
		'source',
		'model',
		'importsSousGraphs'
	],
	#category : 'FAST-Parsing-API',
	#package : 'FAST-Parsing-API'
}

{ #category : 'parsing' }
FastParsingService class >> parseInvocationFromSource: nbSourceCode [

^ self new
		  source: nbSourceCode;
		  parseInvocation;
		  yourself
]

{ #category : 'accessing' }
FastParsingService >> importsSousGraphs [

	^ importsSousGraphs
]

{ #category : 'accessing' }
FastParsingService >> importsSousGraphs: anObject [

	importsSousGraphs := anObject
]

{ #category : 'parsing' }
FastParsingService >> parseInvocation [

 | imports calls |

 model:=	FASTPythonImporter parse: source.
 "Methond should not be named parse invocation since we will also return import statments"

 imports:= (FQTypeQuery types: { FASTPyImportStatement }) executeOn: model.
 calls:= (FQTypeQuery types: { FASTPyCall }) executeOn: model.

 self sousGraphsFromimports: imports AndInvocation: calls. 



]

{ #category : 'accessing' }
FastParsingService >> source [

    ^source
]

{ #category : 'accessing' }
FastParsingService >> source: aSourceCode [

    source:= aSourceCode 
]

{ #category : 'as yet unclassified' }
FastParsingService >> sousGraphsFromimports: imports AndInvocation: calls [ 
	
	| jsonImport jsonCalls |
	jsonImport := imports asCollection collect: [ :import | 
        Dictionary new
            at: 'id'           put: UUID new asString; 
            at: 'library'      put: '';
            at: 'function'     put: '';
				at: 'line' put: (Dictionary new at: 'start' put: 'todo'; at: 'end' put: 'todo'; yourself);
				at: 'cursor' put: (Dictionary new at: 'start' put: import startPos; at: 'end' put: import endPos; yourself);
            at: 'source'       put: import sourceCode;
            at: 'step_name'    put: 'Library Loading';
            yourself ].

	jsonCalls := calls asCollection collect: [ :call | 
        Dictionary new
            at: 'id'           put: UUID new asString; 
            at: 'library'      put: '';
            at: 'function'     put: '';
				at: 'line' put: (Dictionary new at: 'start' put: 'todo'; at: 'end' put: 'todo'; yourself);
				at: 'cursor' put: (Dictionary new at: 'start' put: call startPos; at: 'end' put: call endPos; yourself);
            at: 'source'       put: call sourceCode;
            at: 'step_name'    put: '';
            yourself ].

	jsonImport:= jsonImport addAllLast: jsonCalls . "??? pourquoi je perd ce qu'il yh a dans jsonImports ?"

   importsSousGraphs:= NeoJSONWriter toString: jsonImport "Bonger ça dans la classe serveur"
]
