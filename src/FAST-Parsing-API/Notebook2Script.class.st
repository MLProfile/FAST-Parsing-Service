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
    command: '/Users/mignard/Documents/work/FAST-Parsing-Service/.venv/bin/python';
    arguments: { '-m'. 'jupytext'. '--to'. 'py'. '--output'. '-'. tempFilePath pathString };
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
"This method delete the temp file"

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
"This methode need to write the content of source in a temp file"

	tempFilePath := FileLocator temp / (UUID new asString, '.ipynb').

   tempFilePath writeStreamDo: [ :stream | 
        stream nextPutAll: source ].


]
