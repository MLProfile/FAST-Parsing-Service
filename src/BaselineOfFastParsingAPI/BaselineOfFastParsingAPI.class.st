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
		spec
		loads: 'FAST-Python-ExtraTools';
		repository: 'github://moosetechnology/FAST-Python:main/src' ].
	spec 
		baseline: 'OSSubprocess' with: [
    	spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ].	
	spec 
		baseline: 'FamixQueries'
		with: [
		spec repository: 'github://moosetechnology/FamixQueries' ].
]

{ #category : 'baselines' }
BaselineOfFastParsingAPI >> definePackages: spec [ 

	spec
		package: 'FAST-Parsing-API'
		with: [ spec requires: #( 'FASTPython' ) ]


]
