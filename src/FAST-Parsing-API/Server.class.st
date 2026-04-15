Class {
	#name : 'Server',
	#superclass : 'Object',
	#instVars : [
		'dispatcher',
		'server'
	],
	#category : 'FAST-Parsing-API',
	#package : 'FAST-Parsing-API'
}

{ #category : 'accessing' }
Server class >> start [

	| serv |
	serv := self new server: (ZnServer startDefaultOn: 1701).
	serv registerRoutes.
	serv server delegate: serv dispatcher.
	serv server
		logToTranscript;
		start.

	^ serv
]

{ #category : 'accessing' }
Server >> dispatcher [

	^ dispatcher
]

{ #category : 'accessing' }
Server >> dispatcher: anObject [

	dispatcher := anObject
]

{ #category : 'public' }
Server >> handleParseRequest: aRequest [

	| postData dict nbSourceCode |
	postData := aRequest entity contents.
	dict := (NeoJSONReader on: postData readStream) next.

	"Should handle ifAbsent"
	nbSourceCode := dict
		        at: 'source'
		        ifAbsent: [
		        ^ Error new signal: 'notebook source is missing in the request' ].


	^ FastParsingService
		  parseInvocationFromSource: nbSourceCode
]

{ #category : 'as yet unclassified' }
Server >> registerRoutes [

	dispatcher := ZnDispatcherDelegate new.
	dispatcher map: '/parse' to: [ :request :response |
			| res |
			res := self handleParseRequest: request.

			response
				entity:
					(ZnEntity json:
							 '{"profile": "' , res sous_graphs, '"}'); "This should return json sous grpahs"
				yourself ].
]

{ #category : 'accessing' }
Server >> server [ 

	^server
]

{ #category : 'accessing' }
Server >> server: anObject [

	server := anObject
]
