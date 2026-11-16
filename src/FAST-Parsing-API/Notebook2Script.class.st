Class {
	#name : 'Notebook2Script',
	#superclass : 'Object',
	#instVars : [
		'source',
		'tempFilePath'
	],
	#category : 'FAST-Parsing-API',
	#package : 'FAST-Parsing-API'
}

{ #category : 'as yet unclassified' }
Notebook2Script class >> convertSource: aSource [

^ self new
		  source: aSource;
		  writeFile;
		  convert;
		  yourself
]

{ #category : 'writing' }
Notebook2Script >> convert [
"
This method use OSSubprocess to convert the notebook to python script
To use it while developing, change command path to a local venv with jupytext installed
/Users/mignard/Documents/work/FAST-Parsing-Service/.venv/bin/python
"
OSSUnixSubprocess new
    command: '/usr/local/bin/jupytext';
    arguments: { '--to'. 'py'. '--output'. '-'. tempFilePath pathString };
        redirectStdout;
        redirectStderr;
        runAndWaitOnExitDo: [ :process :outString :errString |
            process isSuccess
                ifTrue: [ source := outString ]
                ifFalse: [ self error: errString ] ].
	self deleteFile.

		  	

]

{ #category : 'writing' }
Notebook2Script >> deleteFile [ 
	tempFilePath ensureDelete. 
]

{ #category : 'accessing' }
Notebook2Script >> source [

	^source 
]

{ #category : 'accessing' }
Notebook2Script >> source: aSource [

	source := aSource 
]

{ #category : 'writing' }
Notebook2Script >> writeFile [
	tempFilePath := FileLocator temp / (UUID new asString, '.ipynb').

   tempFilePath writeStreamDo: [ :stream | 
        stream nextPutAll: source ].


]
