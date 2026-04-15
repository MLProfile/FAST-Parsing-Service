Class {
	#name : 'FastParsingService',
	#superclass : 'Object',
	#instVars : [
		'source'
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

{ #category : 'parsing' }
FastParsingService >> parseInvocation [

 1halt.
]

{ #category : 'accessing' }
FastParsingService >> source [

    ^source
]

{ #category : 'accessing' }
FastParsingService >> source: aSourceCode [

    source:= aSourceCode 
]
