Class {
	#name : 'BaselineOfFastParsingAPI',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFastParsingAPI',
	#package : 'BaselineOfFastParsingAPI'
}

{ #category : 'baselines' }
BaselineOfFastParsingAPI >> baseline: spec [ 
    <baseline>
    spec
    for: #common
    do: [ 
        self defineDependencies: spec.
        self definePackages: spec.]

]

{ #category : 'baselines' }
BaselineOfFastParsingAPI >> defineDependencies: spec [

	spec
		baseline: 'FASTPython'
		with: [
		spec repository: 'github://moosetechnology/FAST-Python:main/src' ]
]

{ #category : 'baselines' }
BaselineOfFastParsingAPI >> definePackages: spec [ 

	spec
		package: 'FAST-Parsing-API'
		with: [ spec requires: #( 'FASTPython' ) ]


]
