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
	
	| jsonImport |
	jsonImport := imports collect: [ :import | 
        Dictionary new
            at: 'id'           put: UUID new asString; "Supposons que vous avez cette méthode"
            at: 'library'      put: '';
            at: 'function'     put: '';
            at: 'value'        put: (Dictionary new 
                                    at: 'start_pos'    put: import startPos; 
											  at: 'end_pos' put: import endPos;
                                    yourself);
            at: 'source'       put: import sourceCode;
            "at: 'start_lineno' put: import startLine;"
            "at: 'end_lineno'   put: import endLine;"
            at: 'step_name'    put: 'Library Loading';
            yourself ].

	jsonImport:= jsonImport first. "collect renvoi un moose groupe doit y avoir un collect qui ne renvoi pas un moose groupe"

    importsSousGraphs:= NeoJSONWriter toString: jsonImport
]
